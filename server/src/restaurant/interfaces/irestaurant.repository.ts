import {
  Prisma,
  Promotion,
  Item,
  Restaurant as RestaurantModel,
} from '@prisma/client';
import { Restaurant } from '../restaurant.entity';

export type BasicRestaurantRecord = {
  restaurantId: number;
  name: string;
  description: string | null;
  address: string | null;
  latitude: number | null;
  longitude: number | null;
  priceRange: number | null;
};

export type RestaurantDetailRecord = BasicRestaurantRecord & {
  items: Item[];
  promotions: Promotion[];
};

export type RatingsAggregate = {
  restaurantId: number;
  _avg: { rating: number | null };
  _count: { rating: number };
};

export type UpdateRestaurantPartial = {
  name?: string;
  description?: string;
  address?: string;
  lat?: number;
  lng?: number;
  priceRange?: number;
  imageUrl?: string;
};

export interface RestaurantRepository {
  // Listing and search
  paginate(
    page: number,
    size: number,
  ): Promise<{ data: BasicRestaurantRecord[]; total: number }>;
  searchByKeyword(
    keyword: string,
    page: number,
    size: number,
  ): Promise<{ data: BasicRestaurantRecord[]; total: number }>;
  findAllBasic(): Promise<BasicRestaurantRecord[]>;

  // Details
  findDetailById(id: number): Promise<RestaurantDetailRecord | null>;
  getItemsByRestaurant(id: number): Promise<Item[]>;
  getPromotionsByRestaurant(id: number): Promise<Promotion[]>;

  // Aggregates
  getRatingsAggregateByRestaurantIds(
    restaurantIds: number[],
  ): Promise<RatingsAggregate[]>;
  getRatingSummary(
    restaurantId: number,
  ): Promise<{ average: number; count: number }>;

  // Ownership
  getOwnerUserId(restaurantId: number): Promise<number | null>;

  // Owner actions
  create(
    entity: Restaurant,
    tx?: Prisma.TransactionClient,
  ): Promise<RestaurantModel>;
  update(
    id: number,
    partial: UpdateRestaurantPartial,
    tx?: Prisma.TransactionClient,
  ): Promise<RestaurantModel>;
  upsertMenu(
    id: number,
    items: { name: string; description?: string; price: string }[],
    tx?: Prisma.TransactionClient,
  ): Promise<Item[]>;
  setPhoto(
    id: number,
    imageUrl: string,
    tx?: Prisma.TransactionClient,
  ): Promise<RestaurantModel>;
  remove(id: number, tx?: Prisma.TransactionClient): Promise<void>;

  // Promotions
  createPromotion(
    restaurantId: number,
    dto: {
      title: string;
      description?: string;
      startDate: Date;
      endDate: Date;
    },
    tx?: Prisma.TransactionClient,
  ): Promise<Promotion>;
  updatePromotion(
    restaurantId: number,
    promoId: number,
    dto: Partial<{
      title: string;
      description?: string;
      startDate: Date;
      endDate: Date;
    }>,
    tx?: Prisma.TransactionClient,
  ): Promise<Promotion>;
  deletePromotion(
    restaurantId: number,
    promoId: number,
    tx?: Prisma.TransactionClient,
  ): Promise<void>;
  getActivePromotions(restaurantId: number): Promise<Promotion[]>;
  getFeaturedPromotions(): Promise<Promotion[]>;
}
