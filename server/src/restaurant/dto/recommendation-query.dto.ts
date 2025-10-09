import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import { IsBoolean, IsNumber, IsOptional, Max, Min } from 'class-validator';

export class RecommendationQueryDto {
  @ApiProperty({ description: 'Latitude user', example: -6.2 })
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  lat: number;

  @ApiProperty({ description: 'Longitude user', example: 106.816666 })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  lng: number;

  @ApiProperty({
    description: 'Jarak maksimum dalam KM untuk normalisasi',
    required: false,
    default: 10,
  })
  @Type(() => Number)
  @IsOptional()
  @IsNumber()
  maxDistanceKm?: number = 10;

  @ApiProperty({
    description: 'Jumlah maksimum hasil',
    required: false,
    default: 20,
  })
  @Type(() => Number)
  @IsOptional()
  @IsNumber()
  limit?: number = 20;

  @ApiProperty({
    description:
      'Flag untuk menggunakan Google Distance Matrix untuk menghitung jarak (opsional sekarang)',
    required: false,
    default: false,
  })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true' || value === true)
  useMatrix?: boolean = false;
}
