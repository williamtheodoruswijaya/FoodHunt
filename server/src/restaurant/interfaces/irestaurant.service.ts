import { RecommendationResult } from '../restaurant.service';

export interface RestaurantService {
  getRecommendations(params: {
    lat: number;
    lng: number;
    maxDistanceKm?: number;
    limit?: number;
    useMatrix?: boolean;
  }): Promise<RecommendationResult[]>;
  getRatingSummary(restaurantId: number);
}
