export interface ReviewProps {
  reviewId: number;
  userId: number;
  restaurantId: number;
  rating: number;
  comment: string;
  createdAt: Date;
}
