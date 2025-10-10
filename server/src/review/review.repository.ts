import { Injectable, NotFoundException } from '@nestjs/common';
import { ReviewRepository } from './interfaces/ireview.repository';
import { PrismaService } from '../../prisma/prisma.service';
import { Prisma } from '@prisma/client';
import { Review } from './review.entity';
import { ReviewBuilder } from './builder/review.builder';

@Injectable()
export class ReviewRepositoryImpl implements ReviewRepository {
  constructor(private readonly prismaService: PrismaService) {}
  async create(review: Review, tx?: Prisma.TransactionClient): Promise<Review> {
    const prismaClient = tx ?? this.prismaService;

    const createdReview = await prismaClient.review.create({
      data: {
        userId: review.getUserId(),
        restaurantId: review.getRestaurantId(),
        rating: review.getRating(),
        comment: review.getComment(),
      },
    });

    return new ReviewBuilder(
      createdReview.userId,
      createdReview.restaurantId,
      createdReview.rating,
      createdReview.comment,
    )
      .setReviewId(createdReview.reviewId)
      .setCreatedAt(createdReview.createdAt)
      .build();
  }

  async getReviews(restaurantId: number): Promise<Review[]> {
    const reviewsFromDb = await this.prismaService.review.findMany({
      where: {
        restaurantId: restaurantId,
      },
    });
    if (!reviewsFromDb) {
      return [];
    }

    return reviewsFromDb.map((review) => {
      return new ReviewBuilder(
        review.userId,
        review.restaurantId,
        review.rating,
        review.comment,
      )
        .setReviewId(review.reviewId)
        .setCreatedAt(review.createdAt)
        .build();
    });
  }

  async findById(reviewId: number): Promise<Review> {
    const reviewFromDb = await this.prismaService.review.findUnique({
      where: {
        reviewId: reviewId,
      },
    });

    if (!reviewFromDb) {
      throw new NotFoundException(`Review with id ${reviewId} not found`);
    }

    return new ReviewBuilder(
      reviewFromDb.userId,
      reviewFromDb.restaurantId,
      reviewFromDb.rating,
      reviewFromDb.comment,
    )
      .setReviewId(reviewFromDb.reviewId)
      .setCreatedAt(reviewFromDb.createdAt)
      .build();
  }

  async delete(reviewId: number, tx?: Prisma.TransactionClient): Promise<void> {
    const prismaClient = tx ?? this.prismaService;

    const targetReview = await prismaClient.review.findUnique({
      where: {
        reviewId: reviewId,
      },
    });
    if (!targetReview) {
      throw new NotFoundException(`Review with id ${reviewId} not found`);
    }

    await prismaClient.review.delete({
      where: {
        reviewId: reviewId,
      },
    });
  }
}
