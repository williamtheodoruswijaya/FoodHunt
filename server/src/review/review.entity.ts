import { ReviewProps } from './interfaces/ireview.entity';

export class Review {
  private reviewId: number;
  private userId: number;
  private restaurantId: number;
  private rating: number;
  private comment: string;
  private createdAt: Date;

  constructor(partial: Partial<ReviewProps>) {
    Object.assign(this, partial);
  }

  public getReviewId(): number {
    return this.reviewId;
  }

  public getUserId(): number {
    return this.userId;
  }

  public getRestaurantId(): number {
    return this.restaurantId;
  }

  public getRating(): number {
    return this.rating;
  }

  public getComment(): string {
    return this.comment;
  }

  public getCreatedAt(): Date {
    return this.createdAt;
  }
}
