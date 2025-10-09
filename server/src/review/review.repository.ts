import { Injectable } from '@nestjs/common';
import { ReviewRepository } from './interfaces/ireview.repository';
import { PrismaService } from '../../prisma/prisma.service';
import { Prisma } from '@prisma/client';
import { Review } from './review.entity';

@Injectable()
export class ReviewRepositoryImpl implements ReviewRepository {
  constructor(private readonly prismaService: PrismaService) {}
  async create(
    review: Review,
    tx?: Prisma.TransactionClient,
  ): Promise<Review> {}
  async getReviews(restaurantId: number): Promise<Review[]> {}
  async findById(reviewId: number): Promise<Review> {}
  async delete(
    reviewId: number,
    tx?: Prisma.TransactionClient,
  ): Promise<void> {}
}
