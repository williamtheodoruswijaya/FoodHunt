import { RestaurantSummaryDto } from '../dto/restaurant-summary.dto';

export class RestaurantSummaryBuilder {
  private dto: Partial<RestaurantSummaryDto> = {};

  constructor(id: number, name: string) {
    this.dto.restaurantId = id;
    this.dto.name = name;
    this.dto.averageRating = 0;
    this.dto.ratingsCount = 0;
  }

  description(v?: string | null) {
    this.dto.description = v ?? null;
    return this;
  }
  address(v?: string | null) {
    this.dto.address = v ?? null;
    return this;
  }
  latitude(v?: number | null) {
    this.dto.latitude = v ?? null;
    return this;
  }
  longitude(v?: number | null) {
    this.dto.longitude = v ?? null;
    return this;
  }
  priceRange(v?: number | null) {
    this.dto.priceRange = v ?? null;
    return this;
  }
  averageRating(v: number) {
    this.dto.averageRating = v;
    return this;
  }
  ratingsCount(v: number) {
    this.dto.ratingsCount = v;
    return this;
  }

  build(): RestaurantSummaryDto {
    return this.dto as RestaurantSummaryDto;
  }
}
