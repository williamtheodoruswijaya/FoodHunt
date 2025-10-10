import { Controller, Get, Param, Query, ParseIntPipe } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { RestaurantService } from './restaurant.service';
import { RecommendationQueryDto } from './dto/recommendation-query.dto';

@ApiTags('restaurants')
@Controller('restaurants')
export class RestaurantController {
  constructor(private readonly service: RestaurantService) {}

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
