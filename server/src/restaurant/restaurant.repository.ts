import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

@Injectable()
export class RestaurantRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findAllBasic() {
    return this.prisma.restaurant.findMany({
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
  }

  async getRatingsAggregateByRestaurantIds(restaurantIds: number[]) {
    if (!restaurantIds.length) return [];
    return this.prisma.review.groupBy({
      by: ['restaurantId'],
      where: { restaurantId: { in: restaurantIds } },
      _avg: { rating: true },
      _count: { rating: true },
    });
  }

  async getRatingSummary(restaurantId: number) {
    const agg = await this.prisma.review.aggregate({
      where: { restaurantId },
      _avg: { rating: true },
      _count: { rating: true },
    });
    return { average: agg._avg.rating ?? 0, count: agg._count.rating };
  }

  async createReview(params: {
    restaurantId: number;
    userId: number;
    rating: number;
    comment?: string;
  }) {
    return this.prisma.review.create({
      data: {
        restaurantId: params.restaurantId,
        userId: params.userId,
        rating: params.rating,
        comment: params.comment ?? null,
      },
    });
  }
}
