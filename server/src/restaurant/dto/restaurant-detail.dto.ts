import { ApiProperty } from '@nestjs/swagger';
import { RestaurantSummaryDto } from './restaurant-summary.dto';

export class ItemResponseDto {
  @ApiProperty() itemId: number;
  @ApiProperty() name: string;
  @ApiProperty({ required: false }) description?: string | null;
  @ApiProperty() price: string;
}

export class PromotionResponseDto {
  @ApiProperty() promotionId: number;
  @ApiProperty() title: string;
  @ApiProperty({ required: false }) description?: string | null;
  @ApiProperty() startDate: Date;
  @ApiProperty() endDate: Date;
}

export class RestaurantDetailDto extends RestaurantSummaryDto {
  @ApiProperty({ type: [ItemResponseDto] })
  items: ItemResponseDto[];

  @ApiProperty({ type: [PromotionResponseDto] })
  promotions: PromotionResponseDto[];
}

export class RatingSummaryDto {
  @ApiProperty({ default: 0 }) average: number;
  @ApiProperty({ default: 0 }) count: number;
}
