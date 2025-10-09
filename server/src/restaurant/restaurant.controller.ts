import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Query,
  UseGuards,
  ParseIntPipe,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { RestaurantService } from './restaurant.service';
import { RecommendationQueryDto } from './dto/recommendation-query.dto';
import { CreateReviewDto } from './dto/create-review.dto';
import { JwtAuthGuard } from '../common/guards/jwt.guards';
import { Auth } from '../common/decorators/user.decorator';
import { User } from '../user/user.entity';

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

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post(':id/ratings')
  async rateRestaurant(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: CreateReviewDto,
    @Auth() user: User,
  ) {
    const created = await this.service.addReview({
      restaurantId: id,
      userId: user.getUserId(),
      rating: body.rating,
      comment: body.comment,
    });
    return created;
  }
}
