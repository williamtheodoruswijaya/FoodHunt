import { Body, Controller, Get, Inject, Post, Query } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { GOOGLE_MAPS_GATEWAY } from './tokens';
import type { GoogleMapsGateway } from './interfaces/igoogle-maps.gateway';
import { DistanceMatrixRequestDto } from './dto/distance-matrix.request.dto';
import { GeolocateRequestDto } from './dto/geolocation.request.dto';
import { WebResponse } from '../common/model/web.response';
import type { GeocodeResult } from './dto/geocoding.dto';
import type { GeolocationResult } from './dto/geolocation.dto';
import { DistanceMatrixItemDto } from './dto/distance-matrix.response.dto';

@ApiTags('maps')
@Controller('maps')
export class MapsController {
  constructor(
    @Inject(GOOGLE_MAPS_GATEWAY) private readonly maps: GoogleMapsGateway,
  ) {}

  @Get('geocode')
  async geocode(
    @Query('address') address: string,
  ): Promise<WebResponse<GeocodeResult[]>> {
    if (!address || address.trim() === '') {
      return { errors: 'address is required' };
    }
    const data = await this.maps.geocode(address);
    return { data };
  }

  @Post('geolocate')
  async geolocate(
    @Body() body: GeolocateRequestDto,
  ): Promise<WebResponse<GeolocationResult>> {
    const data = await this.maps.geolocate(body as any);
    return { data };
  }

  @Post('distance-matrix')
  async distanceMatrix(
    @Body() body: DistanceMatrixRequestDto,
  ): Promise<WebResponse<DistanceMatrixItemDto[]>> {
    const map = await this.maps.distanceMatrix(
      body.origin,
      body.destinations,
      body.options,
    );
    const data = Array.from(map.entries()).map(([id, v]) => ({ id, ...v }));
    return { data };
  }
}
