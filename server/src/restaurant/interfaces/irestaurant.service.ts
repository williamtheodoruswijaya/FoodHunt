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
import { ReviewResponse } from '../../review/dto/create-review.dto';
import { Promotion, Item, Restaurant as RestaurantModel } from '@prisma/client';

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
  getReviews(restaurantId: number): Promise<ReviewResponse[]>;
  getMenu(restaurantId: number): Promise<
    {
      itemId: number;
      name: string;
      description: string | null;
      price: string;
    }[]
  >;
  getPromotions(restaurantId: number): Promise<
    {
      promotionId: number;
      title: string;
      description: string | null;
      startDate: Date;
      endDate: Date;
    }[]
  >;

  // Owner actions
  create(dto: CreateRestaurantDto, userId: number): Promise<RestaurantModel>;
  update(
    id: number,
    dto: UpdateRestaurantDto,
    userId: number,
  ): Promise<RestaurantModel>;
  upsertMenu(id: number, dto: UpsertMenuDto, userId: number): Promise<Item[]>;
  setPhoto(
    id: number,
    imageUrl: string,
    userId: number,
  ): Promise<RestaurantModel>;
  remove(id: number, userId: number): Promise<{ status: string }>;

  // Promotions
  createPromotion(
    id: number,
    dto: CreatePromotionDto,
    userId: number,
  ): Promise<Promotion>;
  updatePromotion(
    id: number,
    promoId: number,
    dto: UpdatePromotionDto,
    userId: number,
  ): Promise<Promotion>;
  deletePromotion(
    id: number,
    promoId: number,
    userId: number,
  ): Promise<{ status: string }>;
  activePromotions(id: number): Promise<
    {
      promotionId: number;
      title: string;
      description: string | null;
      startDate: Date;
      endDate: Date;
    }[]
  >;
  featuredPromotions(): Promise<
    {
      promotionId: number;
      title: string;
      description: string | null;
      startDate: Date;
      endDate: Date;
    }[]
  >;

  // Analytics
  analyticsOverview(id: number): Promise<{
    views: number;
    averageRating: number;
    ratingsCount: number;
    itemsCount: number;
    promotionsCount: number;
  }>;
  analyticsReviews(
    id: number,
  ): Promise<{ summary: { average: number; count: number } }>;
  analyticsPromotions(id: number): Promise<{ active: number; total: number }>;
}
