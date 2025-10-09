import { Injectable, BadRequestException } from '@nestjs/common';
import { RestaurantRepository } from './restaurant.repository';

export interface RecommendationResult {
  restaurantId: number;
  name: string;
  description?: string | null;
  address?: string | null;
  latitude?: string | null;
  longitude?: string | null;
  priceRange?: number | null;
  averageRating: number;
  ratingsCount: number;
  distanceKm: number | null;
  score: number;
}

@Injectable()
export class RestaurantService {
  constructor(private readonly repo: RestaurantRepository) {}

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
      lat: r.latitude ? parseFloat(r.latitude) : NaN,
      lng: r.longitude ? parseFloat(r.longitude) : NaN,
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

  async getRatingSummary(restaurantId: number) {
    return this.repo.getRatingSummary(restaurantId);
  }

  async addReview(params: {
    restaurantId: number;
    userId: number;
    rating: number;
    comment?: string;
  }) {
    return this.repo.createReview(params);
  }
}
