import {
  BadRequestException,
  Inject,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { ReviewService } from './interfaces/ireview.service';
import { ReviewRepository } from './interfaces/ireview.repository';
import { CreateReviewDto, ReviewResponse } from './dto/create-review.dto';
import { User } from '../user/user.entity';
import { ReviewBuilder } from './builder/review.builder';
import { PrismaService } from '../../prisma/prisma.service';
import { UserRepository } from '../user/interfaces/iuser.repository';

@Injectable()
export class ReviewServiceImpl implements ReviewService {
  constructor(
    @Inject('ReviewRepository')
    private readonly reviewRepository: ReviewRepository,
    private readonly userRepository: UserRepository,
    private readonly prisma: PrismaService,
  ) {}

  async create(
    req: CreateReviewDto,
    user: User,
    restaurantId: number,
  ): Promise<ReviewResponse> {
    const createdReview = await this.prisma.$transaction(async (tx) => {
      const reviewBuilder = new ReviewBuilder(
        user.getUserId(),
        restaurantId,
        req.rating,
        req.comment,
      )
        .setCreatedAt(new Date())
        .build();

      return await this.reviewRepository.create(reviewBuilder, tx);
    });

    return ReviewResponse.convertToResponse(createdReview, user);
  }

  async getReviews(restaurantId: number): Promise<ReviewResponse[]> {
    // 1. get reviews from repository
    const reviews = await this.reviewRepository.getReviews(restaurantId);
    if (!reviews || reviews.length === 0) {
      return [];
    }

    // 2. get unique id of each user
    const userIds = [...new Set(reviews.map((review) => review.getUserId()))];

    // 3. get all relevant user in one single query
    const users = await this.userRepository.findManyByIds(userIds);

    // 4. map each user into a MAP for O(1) search
    const map = new Map(users.map((user) => [user.getUserId(), user]));

    // 5. merge review data and users
    return reviews.map((review) => {
      const user = map.get(review.getUserId());
      return ReviewResponse.convertToResponse(review, user);
    });
  }

  async findById(reviewId: number): Promise<ReviewResponse> {
    if (!reviewId || reviewId <= 0) {
      throw new BadRequestException('User ID tidak valid.');
    }

    const review = await this.reviewRepository.findById(reviewId);

    const userId = review.getUserId();
    const user = await this.userRepository.findById(userId);

    return ReviewResponse.convertToResponse(review, user);
  }

  async delete(reviewId: number, user: User): Promise<string> {
    await this.prisma.$transaction(async (tx) => {
      const targetReview = await this.reviewRepository.findById(reviewId);
      if (!targetReview) {
        throw new BadRequestException('Review Not Found.');
      }

      if (targetReview.getUserId() !== user.getUserId()) {
        throw new UnauthorizedException('You are not the owner of this review');
      }

      await this.reviewRepository.delete(reviewId, tx);
    });

    return `Successfully deleted review with id ${reviewId}`;
  }
}
