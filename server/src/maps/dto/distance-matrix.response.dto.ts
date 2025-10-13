import { IsInt, IsNumber } from 'class-validator';

export class DistanceMatrixItemDto {
  @IsInt()
  id!: number;

  @IsNumber()
  distanceKm!: number;

  @IsNumber()
  durationSec!: number;
}
