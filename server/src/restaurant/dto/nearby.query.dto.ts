import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsNumber, IsOptional, Max, Min } from 'class-validator';

export class NearbyQueryDto {
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
    required: false,
    description: 'Jarak maksimum dalam KM untuk normalisasi',
    default: 10,
  })
  @Type(() => Number)
  @IsOptional()
  @IsNumber()
  maxDistanceKm?: number = 10;

  @ApiProperty({
    required: false,
    description: 'Jumlah maksimum hasil',
    default: 20,
  })
  @Type(() => Number)
  @IsOptional()
  @IsNumber()
  limit?: number = 20;
}
