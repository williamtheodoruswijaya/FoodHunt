import { ApiProperty } from '@nestjs/swagger';
import {
  IsArray,
  IsDateString,
  IsNotEmpty,
  IsOptional,
  IsString,
  Max,
  Min,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';

export class CreateRestaurantDto {
  @ApiProperty() @IsString() @IsNotEmpty() name: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  description?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString() address?: string;
  @ApiProperty({ description: 'Latitude as number' })
  @Type(() => Number)
  lat: number;
  @ApiProperty({ description: 'Longitude as number' })
  @Type(() => Number)
  lng: number;
  @ApiProperty({ required: false, minimum: 1, maximum: 5 })
  @IsOptional()
  @Type(() => Number)
  @Min(1)
  @Max(5)
  priceRange?: number;
}

export class UpdateRestaurantDto {
  @ApiProperty({ required: false }) @IsOptional() @IsString() name?: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  description?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString() address?: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @Type(() => Number)
  lat?: number;
  @ApiProperty({ required: false })
  @IsOptional()
  @Type(() => Number)
  lng?: number;
  @ApiProperty({ required: false, minimum: 1, maximum: 5 })
  @IsOptional()
  @Type(() => Number)
  @Min(1)
  @Max(5)
  priceRange?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsString() imageUrl?: string;
}

export class MenuItemDto {
  @ApiProperty() @IsString() name: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  description?: string;
  @ApiProperty() @IsString() price: string;
}

export class UpsertMenuDto {
  @ApiProperty({ type: [MenuItemDto] })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => MenuItemDto)
  items: MenuItemDto[];
}

export class CreatePromotionDto {
  @ApiProperty() @IsString() title: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  description?: string;
  @ApiProperty() @IsDateString() startDate: string;
  @ApiProperty() @IsDateString() endDate: string;
}

export class UpdatePromotionDto {
  @ApiProperty({ required: false }) @IsOptional() @IsString() title?: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  description?: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @IsDateString()
  startDate?: string;
  @ApiProperty({ required: false })
  @IsOptional()
  @IsDateString()
  endDate?: string;
}
