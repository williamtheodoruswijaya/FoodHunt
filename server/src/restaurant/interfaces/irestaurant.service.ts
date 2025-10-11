import { RecommendationResult } from '../restaurant.service';
import { PaginationQueryDto } from '../dto/pagination.dto';
import { RestaurantSummaryDto } from '../dto/restaurant-summary.dto';
import {
  RestaurantDetailDto,
  RatingSummaryDto,
} from '../dto/restaurant-detail.dto';
import {
  CreateRestaurantDto,
  UpdateRestaurantDto,
  UpsertMenuDto,
  CreatePromotionDto,
  UpdatePromotionDto,
} from '../dto/restaurant-owner.dto';

export interface RestaurantService {
  // Search & Listing
  list(
    query: PaginationQueryDto,
  ): Promise<{ data: RestaurantSummaryDto[]; total: number }>;
  search(
    keyword: string,
    query: PaginationQueryDto,
  ): Promise<{ data: RestaurantSummaryDto[]; total: number }>;
  nearby(params: {
    lat: number;
    lng: number;
    maxDistanceKm?: number;
    limit?: number;
  }): Promise<RestaurantSummaryDto[]>;

  // Recommendations
  getRecommendations(params: {
    lat: number;
    lng: number;
    maxDistanceKm?: number;
    limit?: number;
    useMatrix?: boolean;
  }): Promise<RecommendationResult[]>;
  trending(): Promise<RestaurantSummaryDto[]>;
  nearest(params: {
    lat: number;
    lng: number;
    k?: number;
  }): Promise<RestaurantSummaryDto[]>;

  // Details
  detail(id: number): Promise<RestaurantDetailDto>;
  getRatingSummary(restaurantId: number): Promise<RatingSummaryDto>;
  getReviews(restaurantId: number);
  getMenu(restaurantId: number);
  getPromotions(restaurantId: number);

  // Owner actions
  create(dto: CreateRestaurantDto, userId: number);
  update(id: number, dto: UpdateRestaurantDto, userId: number);
  upsertMenu(id: number, dto: UpsertMenuDto, userId: number);
  setPhoto(id: number, imageUrl: string, userId: number);
  remove(id: number, userId: number);

  // Promotions
  createPromotion(id: number, dto: CreatePromotionDto, userId: number);
  updatePromotion(
    id: number,
    promoId: number,
    dto: UpdatePromotionDto,
    userId: number,
  );
  deletePromotion(id: number, promoId: number, userId: number);
  activePromotions(id: number);
  featuredPromotions();

  // Analytics
  analyticsOverview(id: number);
  analyticsReviews(id: number);
  analyticsPromotions(id: number);
}
