export interface RestaurantRepository {
  findAllBasic();
  getRatingsAggregateByRestaurantIds(restaurantIds: number[]);
  getRatingSummary(restaurantId: number);
}
