import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { Prisma } from '@prisma/client';
import {
  RestaurantRepository,
  BasicRestaurantRecord,
  RestaurantDetailRecord,
  RatingsAggregate,
  UpdateRestaurantPartial,
} from './interfaces/irestaurant.repository';
import { Restaurant } from './restaurant.entity';

@Injectable()
export class RestaurantRepositoryImpl implements RestaurantRepository {
  constructor(private readonly prisma: PrismaService) {}

  // Utilities
  private toNumberOrNull(v: string | null | undefined): number | null {
    const n = v !== null && v !== undefined ? Number(v) : NaN;
    return Number.isFinite(n) ? n : null;
  }

  // Listing and search
  async paginate(
    page: number,
    size: number,
  ): Promise<{ data: BasicRestaurantRecord[]; total: number }> {
    const skip = (page - 1) * size;
    const [data, total] = await this.prisma.$transaction([
      this.prisma.restaurant.findMany({
        skip,
        take: size,
        orderBy: { createdAt: 'desc' },
        select: {
          restaurantId: true,
          name: true,
          description: true,
          address: true,
          latitude: true,
          longitude: true,
          priceRange: true,
        },
      }),
      this.prisma.restaurant.count(),
    ]);

    // convert lat/lng to numbers
    const mapped: BasicRestaurantRecord[] = data.map((r) => ({
      ...r,
      latitude: this.toNumberOrNull(r.latitude),
      longitude: this.toNumberOrNull(r.longitude),
    }));
    return { data: mapped, total };
  }

  async searchByKeyword(
    keyword: string,
    page: number,
    size: number,
  ): Promise<{ data: BasicRestaurantRecord[]; total: number }> {
    const skip = (page - 1) * size;
    const where: Prisma.RestaurantWhereInput = {
      OR: [
        { name: { contains: keyword, mode: 'insensitive' } },
        { description: { contains: keyword, mode: 'insensitive' } },
        { address: { contains: keyword, mode: 'insensitive' } },
      ],
    };

    const [data, total] = await this.prisma.$transaction([
      this.prisma.restaurant.findMany({
        skip,
        take: size,
        where,
        orderBy: { createdAt: 'desc' },
        select: {
          restaurantId: true,
          name: true,
          description: true,
          address: true,
          latitude: true,
          longitude: true,
          priceRange: true,
        },
      }),
      this.prisma.restaurant.count({ where }),
    ]);

    const mapped: BasicRestaurantRecord[] = data.map((r) => ({
      ...r,
      latitude: this.toNumberOrNull(r.latitude),
      longitude: this.toNumberOrNull(r.longitude),
    }));
    return { data: mapped, total };
  }

  async findAllBasic(): Promise<BasicRestaurantRecord[]> {
    const data = await this.prisma.restaurant.findMany({
      select: {
        restaurantId: true,
        name: true,
        description: true,
        address: true,
        latitude: true,
        longitude: true,
        priceRange: true,
      },
    });
    return data.map<BasicRestaurantRecord>((r) => ({
      ...r,
      latitude: this.toNumberOrNull(r.latitude),
      longitude: this.toNumberOrNull(r.longitude),
    }));
  }

  // Details
  async findDetailById(id: number): Promise<RestaurantDetailRecord | null> {
    const r = await this.prisma.restaurant.findUnique({
      where: { restaurantId: id },
      include: { items: true, promotions: true },
    });
    if (!r) return null;
    return {
      ...r,
      latitude: this.toNumberOrNull(r.latitude),
      longitude: this.toNumberOrNull(r.longitude),
    };
  }

  async getItemsByRestaurant(id: number) {
    return this.prisma.item.findMany({
      where: { restaurantId: id },
      orderBy: { itemId: 'asc' },
    });
  }

  async getPromotionsByRestaurant(id: number) {
    return this.prisma.promotion.findMany({
      where: { restaurantId: id },
      orderBy: { promotionId: 'desc' },
    });
  }

  // Aggregates
  async getRatingsAggregateByRestaurantIds(
    restaurantIds: number[],
  ): Promise<RatingsAggregate[]> {
    if (!restaurantIds.length) return [];
    const res = await this.prisma.review.groupBy({
      by: ['restaurantId'],
      where: { restaurantId: { in: restaurantIds } },
      _avg: { rating: true },
      _count: { rating: true },
    });
    return res as unknown as RatingsAggregate[];
  }

  async getRatingSummary(restaurantId: number) {
    const agg = await this.prisma.review.aggregate({
      where: { restaurantId },
      _avg: { rating: true },
      _count: { rating: true },
    });
    return { average: agg._avg.rating ?? 0, count: agg._count.rating };
  }

  async getOwnerUserId(restaurantId: number): Promise<number | null> {
    const r = await this.prisma.restaurant.findUnique({
      where: { restaurantId },
      select: { userId: true },
    });
    return r?.userId ?? null;
  }

  // Owner actions
  async create(entity: Restaurant, tx?: Prisma.TransactionClient) {
    const prisma = tx ?? this.prisma;
    const created = await prisma.restaurant.create({
      data: {
        userId: entity.getUserId(),
        name: entity.getName(),
        description: entity.getDescription(),
        address: entity.getAddress(),
        latitude: String(entity.getLatitude()),
        longitude: String(entity.getLongitude()),
        priceRange: entity.getPriceRange() ?? null,
      },
    });
    return created;
  }

  async update(
    id: number,
    partial: UpdateRestaurantPartial,
    tx?: Prisma.TransactionClient,
  ) {
    const prisma = tx ?? this.prisma;
    const updated = await prisma.restaurant.update({
      where: { restaurantId: id },
      data: {
        name: partial.name,
        description: partial.description,
        address: partial.address,
        latitude: partial.lat !== undefined ? String(partial.lat) : undefined,
        longitude: partial.lng !== undefined ? String(partial.lng) : undefined,
        priceRange: partial.priceRange,
        ...(partial.imageUrl ? { imageUrl: partial.imageUrl } : {}),
      },
    });
    return updated;
  }

  async upsertMenu(
    id: number,
    items: { name: string; description?: string; price: string }[],
    tx?: Prisma.TransactionClient,
  ) {
    const prisma = tx ?? this.prisma;
    await prisma.item.deleteMany({ where: { restaurantId: id } });
    if (!items?.length) return [];
    const created = await Promise.all(
      items.map((it) =>
        prisma.item.create({
          data: {
            restaurantId: id,
            name: it.name,
            description: it.description,
            price: it.price,
          },
        }),
      ),
    );
    return created;
  }

  async setPhoto(id: number, imageUrl: string, tx?: Prisma.TransactionClient) {
    const prisma = tx ?? this.prisma;
    return prisma.restaurant.update({
      where: { restaurantId: id },
      data: { imageUrl },
    });
  }

  async remove(id: number, tx?: Prisma.TransactionClient) {
    const prisma = tx ?? this.prisma;
    await prisma.promotion.deleteMany({ where: { restaurantId: id } });
    await prisma.item.deleteMany({ where: { restaurantId: id } });
    await prisma.restaurant.delete({ where: { restaurantId: id } });
  }

  // Promotions
  async createPromotion(
    restaurantId: number,
    dto: {
      title: string;
      description?: string;
      startDate: Date;
      endDate: Date;
    },
    tx?: Prisma.TransactionClient,
  ) {
    const prisma = tx ?? this.prisma;
    return prisma.promotion.create({
      data: {
        restaurantId,
        title: dto.title,
        description: dto.description,
        startDate: dto.startDate,
        endDate: dto.endDate,
      },
    });
  }

  async updatePromotion(
    _restaurantId: number,
    promoId: number,
    dto: Partial<{
      title: string;
      description?: string;
      startDate: Date;
      endDate: Date;
    }>,
    tx?: Prisma.TransactionClient,
  ) {
    const prisma = tx ?? this.prisma;
    return prisma.promotion.update({
      where: { promotionId: promoId },
      data: { ...dto },
    });
  }

  async deletePromotion(
    _restaurantId: number,
    promoId: number,
    tx?: Prisma.TransactionClient,
  ) {
    const prisma = tx ?? this.prisma;
    await prisma.promotion.delete({ where: { promotionId: promoId } });
  }

  async getActivePromotions(restaurantId: number) {
    const now = new Date();
    return this.prisma.promotion.findMany({
      where: { restaurantId, startDate: { lte: now }, endDate: { gte: now } },
      orderBy: { startDate: 'desc' },
    });
  }

  async getFeaturedPromotions() {
    const now = new Date();
    return this.prisma.promotion.findMany({
      where: { startDate: { lte: now }, endDate: { gte: now } },
      orderBy: { startDate: 'desc' },
      take: 20,
    });
  }
}
