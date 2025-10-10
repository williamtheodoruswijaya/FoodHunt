import {
  Controller,
  Get,
  Param,
  Query,
  ParseIntPipe,
  Inject,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { RecommendationQueryDto } from './dto/recommendation-query.dto';
import { RestaurantService } from './interfaces/irestaurant.service';

@ApiTags('restaurants')
@Controller('restaurants')
export class RestaurantController {
  constructor(
    @Inject('RestaurantService') private readonly service: RestaurantService,
  ) {}

  @Get('recommendations')
  async recommendations(@Query() query: RecommendationQueryDto) {
    const { lat, lng, maxDistanceKm, limit, useMatrix } = query;
    const data = await this.service.getRecommendations({
      lat,
      lng,
      maxDistanceKm,
      limit,
      useMatrix,
    });
    return data;
  }

  @Get(':id/ratings/summary')
  async ratingSummary(@Param('id', ParseIntPipe) id: number) {
    return this.service.getRatingSummary(id);
  }
}
