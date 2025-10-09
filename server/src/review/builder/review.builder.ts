import { ReviewProps } from '../interfaces/ireview.entity';
import { Review } from '../review.entity';

export class ReviewBuilder {
  private props: Partial<ReviewProps> = {};

  constructor(
    userId: number,
    restaurantId: number,
    rating: number,
    comment: string,
  ) {
    this.props.userId = userId;
    this.props.restaurantId = restaurantId;
    this.props.rating = rating;
    this.props.comment = comment;
  }

  public setReviewId(reviewId: number) {
    this.props.reviewId = reviewId;
    return this;
  }

  public setCreatedAt(createdAt: Date) {
    this.props.createdAt = createdAt;
    return this;
  }

  public build(): Review {
    return new Review(this.props);
  }
}
