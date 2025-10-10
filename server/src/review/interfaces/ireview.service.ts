import { CreateReviewDto, ReviewResponse } from '../dto/create-review.dto';
import { User } from '../../user/user.entity';

export interface ReviewService {
  create(
    req: CreateReviewDto,
    user: User,
    restaurantId: number,
  ): Promise<ReviewResponse>;
  getReviews(restaurantId: number): Promise<ReviewResponse[]>;
  findById(reviewId: number): Promise<ReviewResponse>;
  delete(reviewId: number, user: User): Promise<string>;
}
