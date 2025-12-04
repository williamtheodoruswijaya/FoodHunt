import { ApiProperty } from '@nestjs/swagger';

export class RestaurantSummaryDto {
  @ApiProperty()
  restaurantId: number;

  @ApiProperty()
  name: string;

  @ApiProperty({ required: false, nullable: true })
  description?: string | null;

  @ApiProperty({ required: false, nullable: true })
  address?: string | null;

  @ApiProperty({ required: false, nullable: true })
  latitude?: number | null;

  @ApiProperty({ required: false, nullable: true })
  longitude?: number | null;

  @ApiProperty({ required: false, nullable: true })
  priceRange?: number | null;

  @ApiProperty({ required: false, nullable: true })
  imageUrl?: string | null;

  @ApiProperty({ description: 'Rating rata-rata', default: 0 })
  averageRating: number;

  @ApiProperty({ description: 'Jumlah rating', default: 0 })
  ratingsCount: number;
}
