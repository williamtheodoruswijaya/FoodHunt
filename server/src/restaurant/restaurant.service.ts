import {
  Injectable,
  BadRequestException,
  Inject,
  UnauthorizedException,
} from '@nestjs/common';
import { RestaurantService } from './interfaces/irestaurant.service';
import {
  RestaurantRepository,
  RatingsAggregate,
} from './interfaces/irestaurant.repository';
import { PaginationQueryDto } from './dto/pagination.dto';
import { RestaurantSummaryBuilder } from './builder/restaurant-summary.builder';
import { RestaurantSummaryDto } from './dto/restaurant-summary.dto';
import {
  RestaurantDetailDto,
  RatingSummaryDto,
} from './dto/restaurant-detail.dto';
import {
  CreateRestaurantDto,
  UpdateRestaurantDto,
  UpsertMenuDto,
  CreatePromotionDto,
  UpdatePromotionDto,
} from './dto/restaurant-owner.dto';
import { RestaurantBuilder } from './builder/restaurant.builder';
import { ReviewService } from '../review/interfaces/ireview.service';
import { ReviewResponse } from '../review/dto/create-review.dto';

export interface RecommendationResult {
  restaurantId: number;
  name: string;
  description?: string | null;
  address?: string | null;
  latitude?: number | null;
  longitude?: number | null;
  priceRange?: number | null;
  averageRating: number;
  ratingsCount: number;
  distanceKm: number | null;
  score: number;
}

@Injectable()
export class RestaurantServiceImpl implements RestaurantService {
  constructor(
    @Inject('RestaurantRepository') private readonly repo: RestaurantRepository,
    @Inject('ReviewService') private readonly reviewService: ReviewService,
  ) {}

  private async assertOwner(restaurantId: number, userId: number) {
    const ownerId = await this.repo.getOwnerUserId(restaurantId);
    if (!ownerId) throw new BadRequestException('Restaurant not found');
    if (ownerId !== userId) throw new UnauthorizedException('Not the owner');
  }

  private haversineDistanceKm(
    lat1: number,
    lon1: number,
    lat2: number,
    lon2: number,
  ): number {
    const toRad = (v: number) => (v * Math.PI) / 180;
    const R = 6371; // km
    const dLat = toRad(lat2 - lat1);
    const dLon = toRad(lon2 - lon1);
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(toRad(lat1)) *
        Math.cos(toRad(lat2)) *
        Math.sin(dLon / 2) *
        Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  // Listing & Search
  async list(
    query: PaginationQueryDto,
  ): Promise<{ data: RestaurantSummaryDto[]; total: number }> {
    const { page = 1, size = 10 } = query;
    const { data, total } = await this.repo.paginate(page, size);
    const ids = data.map((d) => d.restaurantId);
    const agg = await this.repo.getRatingsAggregateByRestaurantIds(ids);
    const map = new Map<number, { avg: number; count: number }>();
    for (const a of agg)
      map.set(a.restaurantId, {
        avg: a._avg.rating ?? 0,
        count: a._count.rating,
      });
    const result = data.map((r) =>
      new RestaurantSummaryBuilder(r.restaurantId, r.name)
        .description(r.description)
        .address(r.address)
        .latitude(r.latitude)
        .longitude(r.longitude)
        .priceRange(r.priceRange)
        .averageRating(map.get(r.restaurantId)?.avg ?? 0)
        .ratingsCount(map.get(r.restaurantId)?.count ?? 0)
        .build(),
    );
    return { data: result, total };
  }

  async search(keyword: string, query: PaginationQueryDto) {
    const { page = 1, size = 10 } = query;
    const { data, total } = await this.repo.searchByKeyword(
      keyword,
      page,
      size,
    );
    const ids = data.map((d) => d.restaurantId);
    const agg = await this.repo.getRatingsAggregateByRestaurantIds(ids);
    const map = new Map<number, { avg: number; count: number }>();
    for (const a of agg)
      map.set(a.restaurantId, {
        avg: a._avg.rating ?? 0,
        count: a._count.rating,
      });
    const result = data.map((r) =>
      new RestaurantSummaryBuilder(r.restaurantId, r.name)
        .description(r.description)
        .address(r.address)
        .latitude(r.latitude)
        .longitude(r.longitude)
        .priceRange(r.priceRange)
        .averageRating(map.get(r.restaurantId)?.avg ?? 0)
        .ratingsCount(map.get(r.restaurantId)?.count ?? 0)
        .build(),
    );
    return { data: result, total };
  }

  async nearby(params: {
    lat: number;
    lng: number;
    maxDistanceKm?: number;
    limit?: number;
  }): Promise<RestaurantSummaryDto[]> {
    const { lat, lng } = params;
    const maxDistanceKm = params.maxDistanceKm ?? 10;
    const limit = params.limit ?? 20;
    const base = await this.repo.findAllBasic();
    const ids = base.map((b) => b.restaurantId);
    const agg = await this.repo.getRatingsAggregateByRestaurantIds(ids);
    const map = new Map<number, { avg: number; count: number }>();
    for (const a of agg)
      map.set(a.restaurantId, {
        avg: a._avg.rating ?? 0,
        count: a._count.rating,
      });

    const ranked = base
      .map((r) => {
        const hasCoords = r.latitude != null && r.longitude != null;
        const distanceKm = hasCoords
          ? this.haversineDistanceKm(
              lat,
              lng,
              r.latitude as number,
              r.longitude as number,
            )
          : null;
        return {
          r,
          distanceKm,
        };
      })
      .filter((x) => x.distanceKm === null || x.distanceKm <= maxDistanceKm)
      .sort((a, b) => {
        if (a.distanceKm == null) return 1;
        if (b.distanceKm == null) return -1;
        return a.distanceKm - b.distanceKm;
      })
      .slice(0, limit);

    return ranked.map(({ r }) =>
      new RestaurantSummaryBuilder(r.restaurantId, r.name)
        .description(r.description)
        .address(r.address)
        .latitude(r.latitude)
        .longitude(r.longitude)
        .priceRange(r.priceRange)
        .averageRating(map.get(r.restaurantId)?.avg ?? 0)
        .ratingsCount(map.get(r.restaurantId)?.count ?? 0)
        .build(),
    );
  }

  // Recommendations
  async getRecommendations(params: {
    lat: number;
    lng: number;
    maxDistanceKm?: number;
    limit?: number;
    useMatrix?: boolean;
  }): Promise<RecommendationResult[]> {
    const { lat, lng } = params;
    if (lat === undefined || lng === undefined) {
      throw new BadRequestException('lat and lng are required');
    }
    const maxDistanceKm = params.maxDistanceKm ?? 10;
    const limit = params.limit ?? 20;
    const useMatrix = params.useMatrix ?? false;

    const restaurants = await this.repo.findAllBasic();
    const ids = restaurants.map((r) => r.restaurantId);
    const aggregates = await this.repo.getRatingsAggregateByRestaurantIds(ids);
    const aggMap = new Map<number, { avg: number; count: number }>();
    for (const a of aggregates) {
      aggMap.set(a.restaurantId, {
        avg: a._avg.rating ?? 0,
        count: a._count.rating,
      });
    }

    // Precompute coordinates
    const coords = restaurants.map((r) => ({
      id: r.restaurantId,
      lat: r.latitude ?? NaN,
      lng: r.longitude ?? NaN,
    }));

    // Optionally fetch distances via Google Distance Matrix in one batch
    let matrixDistances: Map<number, number> | null = null; // km
    if (
      useMatrix &&
      typeof fetch !== 'undefined' &&
      process.env.GOOGLE_MAPS_API_KEY
    ) {
      const valid = coords.filter(
        (c) => Number.isFinite(c.lat) && Number.isFinite(c.lng),
      );
      if (valid.length > 0) {
        const apiKey = process.env.GOOGLE_MAPS_API_KEY;
        if (!apiKey) {
          throw new Error('Google Maps API key is missing');
        }
        const destinations = valid
          .map((c) => encodeURIComponent(`${c.lat},${c.lng}`))
          .join('|');
        const url = `https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${lat},${lng}&destinations=${destinations}&key=${apiKey}`;
        try {
          const res = await fetch(url);
          if (res.ok) {
            interface DistanceMatrixResponse {
              rows: {
                elements: {
                  distance?: { value: number };
                  duration?: { value: number };
                  status: string;
                }[];
              }[];
            }
            const json: DistanceMatrixResponse = await res.json();
            const elements = json?.rows?.[0]?.elements;
            if (Array.isArray(elements)) {
              matrixDistances = new Map<number, number>();
              for (let i = 0; i < valid.length; i++) {
                const e = elements[i];
                const km = e?.distance?.value ? e.distance.value / 1000 : null;
                if (km !== null) matrixDistances.set(valid[i].id, km);
              }
            }
          }
        } catch {
          // ignore and fallback to haversine
        }
      }
    }

    const ratingWeight = 0.6;
    const distanceWeight = 0.4;

    const results: RecommendationResult[] = restaurants.map((r) => {
      const avg = aggMap.get(r.restaurantId)?.avg ?? 0;
      const count = aggMap.get(r.restaurantId)?.count ?? 0;
      const c = coords.find((x) => x.id === r.restaurantId)!;
      const hasCoords = Number.isFinite(c.lat) && Number.isFinite(c.lng);
      let distanceKm: number | null = null;
      if (hasCoords) {
        distanceKm =
          matrixDistances?.get(r.restaurantId) ??
          this.haversineDistanceKm(lat, lng, c.lat, c.lng);
      }

      const normalizedRating = avg > 0 ? avg / 5 : 0; // 0-1
      const normalizedDistance =
        distanceKm !== null ? 1 - Math.min(distanceKm / maxDistanceKm, 1) : 0; // 0-1, closer -> higher

      const score =
        ratingWeight * normalizedRating + distanceWeight * normalizedDistance;

      return {
        restaurantId: r.restaurantId,
        name: r.name,
        description: r.description,
        address: r.address,
        latitude: r.latitude,
        longitude: r.longitude,
        priceRange: r.priceRange,
        averageRating: avg,
        ratingsCount: count,
        distanceKm,
        score,
      };
    });

    return results.sort((a, b) => b.score - a.score).slice(0, limit);
  }

  async trending(): Promise<RestaurantSummaryDto[]> {
    const base = await this.repo.findAllBasic();
    const ids = base.map((b) => b.restaurantId);
    const agg = await this.repo.getRatingsAggregateByRestaurantIds(ids);
    const ranked = agg
      .map((a) => ({
        id: a.restaurantId,
        score: (a._avg.rating ?? 0) * 0.7 + (a._count.rating ?? 0) * 0.3,
      }))
      .sort((x, y) => y.score - x.score)
      .slice(0, 20);
    const idSet = new Set(ranked.map((r) => r.id));
    const mapAgg = new Map<number, RatingsAggregate>(
      agg.map((a) => [a.restaurantId, a] as const),
    );
    return base
      .filter((b) => idSet.has(b.restaurantId))
      .map((r) =>
        new RestaurantSummaryBuilder(r.restaurantId, r.name)
          .description(r.description)
          .address(r.address)
          .latitude(r.latitude)
          .longitude(r.longitude)
          .priceRange(r.priceRange)
          .averageRating(mapAgg.get(r.restaurantId)?._avg.rating ?? 0)
          .ratingsCount(mapAgg.get(r.restaurantId)?._count.rating ?? 0)
          .build(),
      );
  }

  async nearest(params: {
    lat: number;
    lng: number;
    k?: number;
  }): Promise<RestaurantSummaryDto[]> {
    const { lat, lng, k = 10 } = params;
    const base = await this.repo.findAllBasic();
    const ids = base.map((b) => b.restaurantId);
    const agg = await this.repo.getRatingsAggregateByRestaurantIds(ids);
    const map = new Map<number, RatingsAggregate>(
      agg.map((a) => [a.restaurantId, a] as const),
    );
    return base
      .map((r) => ({
        r,
        d:
          r.latitude != null && r.longitude != null
            ? this.haversineDistanceKm(
                lat,
                lng,
                r.latitude as number,
                r.longitude as number,
              )
            : Number.POSITIVE_INFINITY,
      }))
      .sort((a, b) => a.d - b.d)
      .slice(0, k)
      .map(({ r }) =>
        new RestaurantSummaryBuilder(r.restaurantId, r.name)
          .description(r.description)
          .address(r.address)
          .latitude(r.latitude)
          .longitude(r.longitude)
          .priceRange(r.priceRange)
          .averageRating(map.get(r.restaurantId)?._avg.rating ?? 0)
          .ratingsCount(map.get(r.restaurantId)?._count.rating ?? 0)
          .build(),
      );
  }

  // Details
  async detail(id: number): Promise<RestaurantDetailDto> {
    const r = await this.repo.findDetailById(id);
    if (!r) throw new BadRequestException('Restaurant not found');
    const rating = await this.repo.getRatingSummary(id);
    return {
      restaurantId: r.restaurantId,
      name: r.name,
      description: r.description,
      address: r.address,
      latitude: r.latitude,
      longitude: r.longitude,
      priceRange: r.priceRange,
      averageRating: rating.average,
      ratingsCount: rating.count,
      items: (r.items ?? []).map((i) => ({
        itemId: i.itemId,
        name: i.name,
        description: i.description,
        price: i.price,
      })),
      promotions: (r.promotions ?? []).map((p) => ({
        promotionId: p.promotionId,
        title: p.title,
        description: p.description,
        startDate: p.startDate,
        endDate: p.endDate,
      })),
    };
  }

  async getRatingSummary(restaurantId: number): Promise<RatingSummaryDto> {
    return this.repo.getRatingSummary(restaurantId);
  }

  async getReviews(restaurantId: number): Promise<ReviewResponse[]> {
    return this.reviewService.getReviews(restaurantId);
  }

  async getMenu(restaurantId: number) {
    const items = await this.repo.getItemsByRestaurant(restaurantId);
    return items.map((i) => ({
      itemId: i.itemId,
      name: i.name,
      description: i.description,
      price: i.price,
    }));
  }

  async getPromotions(restaurantId: number) {
    const promos = await this.repo.getPromotionsByRestaurant(restaurantId);
    return promos.map((p) => ({
      promotionId: p.promotionId,
      title: p.title,
      description: p.description,
      startDate: p.startDate,
      endDate: p.endDate,
    }));
  }

  // Owner actions
  async create(dto: CreateRestaurantDto, userId: number) {
    const entity = new RestaurantBuilder(
      userId,
      dto.name,
      dto.address ?? '',
      dto.lat,
      dto.lng,
    )
      .setDescription(dto.description)
      .setPriceRange(dto.priceRange)
      .build();
    const created = await this.repo.create(entity);
    return created;
  }

  async update(id: number, dto: UpdateRestaurantDto, userId: number) {
    await this.assertOwner(id, userId);
    return this.repo.update(id, dto);
  }

  async upsertMenu(id: number, dto: UpsertMenuDto, userId: number) {
    await this.assertOwner(id, userId);
    return this.repo.upsertMenu(id, dto.items);
  }

  async setPhoto(id: number, imageUrl: string, userId: number) {
    await this.assertOwner(id, userId);
    return this.repo.setPhoto(id, imageUrl);
  }

  async remove(id: number, userId: number) {
    await this.assertOwner(id, userId);
    await this.repo.remove(id);
    return { status: 'ok' };
  }

  // Promotions
  async createPromotion(id: number, dto: CreatePromotionDto, userId: number) {
    await this.assertOwner(id, userId);
    return this.repo.createPromotion(id, {
      title: dto.title,
      description: dto.description,
      startDate: new Date(dto.startDate),
      endDate: new Date(dto.endDate),
    });
  }
  async updatePromotion(
    id: number,
    promoId: number,
    dto: UpdatePromotionDto,
    userId: number,
  ) {
    await this.assertOwner(id, userId);
    return this.repo.updatePromotion(id, promoId, {
      title: dto.title,
      description: dto.description,
      startDate: dto.startDate ? new Date(dto.startDate) : undefined,
      endDate: dto.endDate ? new Date(dto.endDate) : undefined,
    });
  }
  async deletePromotion(id: number, promoId: number, userId: number) {
    await this.assertOwner(id, userId);
    await this.repo.deletePromotion(id, promoId);
    return { status: 'ok' };
  }
  async activePromotions(id: number) {
    const promos = await this.repo.getActivePromotions(id);
    return promos.map((p) => ({
      promotionId: p.promotionId,
      title: p.title,
      description: p.description,
      startDate: p.startDate,
      endDate: p.endDate,
    }));
  }
  async featuredPromotions() {
    const promos = await this.repo.getFeaturedPromotions();
    return promos.map((p) => ({
      promotionId: p.promotionId,
      title: p.title,
      description: p.description,
      startDate: p.startDate,
      endDate: p.endDate,
    }));
  }

  // Analytics (basic with available data)
  async analyticsOverview(id: number) {
    const detail = await this.repo.findDetailById(id);
    if (!detail) throw new BadRequestException('Restaurant not found');
    const rating = await this.repo.getRatingSummary(id);
    const itemsCount = (detail.items ?? []).length;
    const promotionsCount = (detail.promotions ?? []).length;
    return {
      views: 0,
      averageRating: rating.average,
      ratingsCount: rating.count,
      itemsCount,
      promotionsCount,
    };
  }

  async analyticsReviews(id: number) {
    // Basic breakdown: count by rating 1..5
    const summary = await this.repo.getRatingSummary(id);
    // Without distribution table, return summary only
    return { summary };
  }

  async analyticsPromotions(id: number) {
    const promos = await this.repo.getPromotionsByRestaurant(id);
    return {
      active: (await this.repo.getActivePromotions(id)).length,
      total: promos.length,
    };
  }
}
