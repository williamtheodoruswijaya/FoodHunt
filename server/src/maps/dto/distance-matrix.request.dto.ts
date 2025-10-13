import { Type } from 'class-transformer';
import {
  IsArray,
  IsIn,
  IsInt,
  IsNumber,
  IsOptional,
  ValidateNested,
} from 'class-validator';
import type { TravelMode, Units } from '../common';

export class LatLngDto {
  @IsNumber()
  lat!: number;

  @IsNumber()
  lng!: number;
}

export class DestinationDto {
  @IsInt()
  id!: number;

  @ValidateNested()
  @Type(() => LatLngDto)
  location!: LatLngDto;
}

export class DistanceMatrixOptionsDto {
  @IsOptional()
  @IsIn(['driving', 'walking', 'bicycling', 'transit'])
  mode?: TravelMode;

  @IsOptional()
  @IsIn(['metric', 'imperial'])
  units?: Units;
}

export class DistanceMatrixRequestDto {
  @ValidateNested()
  @Type(() => LatLngDto)
  origin!: LatLngDto;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => DestinationDto)
  destinations!: DestinationDto[];

  @IsOptional()
  @ValidateNested()
  @Type(() => DistanceMatrixOptionsDto)
  options?: DistanceMatrixOptionsDto;
}
