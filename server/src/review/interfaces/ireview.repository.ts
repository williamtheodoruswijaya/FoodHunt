import { Review } from '../review.entity';
import { Prisma } from '@prisma/client';

export interface ReviewRepository {
  create(review: Review, tx?: Prisma.TransactionClient): Promise<Review>;
  getReviews(restaurantId: number): Promise<Review[]>;
  findById(reviewId: number): Promise<Review>;
  delete(reviewId: number, tx?: Prisma.TransactionClient): Promise<void>;
}
