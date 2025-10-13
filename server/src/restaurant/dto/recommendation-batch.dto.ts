import { Type } from 'class-transformer';
import {
  IsArray,
  IsInt,
  IsNumber,
  IsOptional,
  ValidateNested,
} from 'class-validator';

export class LatLngDto {
  @IsNumber() lat!: number;
  @IsNumber() lng!: number;
}

export class RecommendationBatchDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => LatLngDto)
  origins!: LatLngDto[];

  @IsOptional() @IsNumber() maxDistanceKm?: number;
  @IsOptional() @IsInt() limit?: number;
}
