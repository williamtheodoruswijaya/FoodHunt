import { Type } from 'class-transformer';
import {
  IsArray,
  IsBoolean,
  IsNumber,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';

export class CellTowerDto {
  @IsOptional() @IsNumber() cellId?: number;
  @IsOptional() @IsNumber() locationAreaCode?: number;
  @IsOptional() @IsNumber() mobileCountryCode?: number;
  @IsOptional() @IsNumber() mobileNetworkCode?: number;
  @IsOptional() @IsNumber() age?: number;
  @IsOptional() @IsNumber() signalStrength?: number;
  @IsOptional() @IsNumber() timingAdvance?: number;
}

export class WifiAccessPointDto {
  @IsString() macAddress!: string;
  @IsOptional() @IsNumber() signalStrength?: number;
  @IsOptional() @IsNumber() age?: number;
  @IsOptional() @IsNumber() channel?: number;
  @IsOptional() @IsNumber() signalToNoiseRatio?: number;
}

export class GeolocateRequestDto {
  @IsOptional() @IsBoolean() considerIp?: boolean;

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CellTowerDto)
  cellTowers?: CellTowerDto[];

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => WifiAccessPointDto)
  wifiAccessPoints?: WifiAccessPointDto[];
}
