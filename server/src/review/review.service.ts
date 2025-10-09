import { Inject, Injectable } from '@nestjs/common';
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
    // TODO: create UserRepository bulks SELECT (findManys)
  }

  async findById(reviewId: number): Promise<ReviewResponse> {}

  async delete(reviewId: number): Promise<string> {}
}
