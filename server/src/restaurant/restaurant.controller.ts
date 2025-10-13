import {
  Body,
  Controller,
  Delete,
  Get,
  Inject,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { RecommendationQueryDto } from './dto/recommendation-query.dto';
import { RestaurantService } from './interfaces/irestaurant.service';
import { PaginationQueryDto } from './dto/pagination.dto';
import { SearchQueryDto } from './dto/search.query.dto';
import { NearbyQueryDto } from './dto/nearby.query.dto';
import { WebResponse } from '../common/model/web.response';
import { Paging } from '../common/model/paging.model';
import {
  CreatePromotionDto,
  CreateRestaurantDto,
  UpdatePromotionDto,
  UpdateRestaurantDto,
  UpsertMenuDto,
} from './dto/restaurant-owner.dto';
import { JwtAuthGuard } from '../common/guards/jwt.guards';
import { Auth } from '../common/decorators/user.decorator';
import { User } from '../user/user.entity';

@ApiTags('restaurants')
@Controller('restaurants')
export class RestaurantController {
  constructor(
    @Inject('RestaurantService') private readonly service: RestaurantService,
  ) {}

  // Search & List
  @Get()
  async list(@Query() q: PaginationQueryDto): Promise<WebResponse<any>> {
    const { data, total } = await this.service.list(q);
    const paging: Paging = {
      size: q.size ?? 10,
      total_page: Math.ceil(total / (q.size ?? 10)),
      current_page: q.page ?? 1,
    };
    return { data, paging };
  }

  @Get('search')
  async search(
    @Query() query: SearchQueryDto & PaginationQueryDto,
  ): Promise<WebResponse<any>> {
    const { data, total } = await this.service.search(query.keyword, query);
    const paging: Paging = {
      size: query.size ?? 10,
      total_page: Math.ceil(total / (query.size ?? 10)),
      current_page: query.page ?? 1,
    };
    return { data, paging };
  }

  @Get('nearby')
  async nearby(@Query() query: NearbyQueryDto): Promise<WebResponse<any>> {
    const data = await this.service.nearby({
      lat: query.lat,
      lng: query.lng,
      maxDistanceKm: query.maxDistanceKm,
      limit: query.limit,
    });
    return { data };
  }

  // Recommendations
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
    return { data };
  }

  @Get('recommendations/trending')
  async trending(): Promise<WebResponse<any>> {
    const data = await this.service.trending();
    return { data };
  }

  @Get('recommendations/nearest')
  async nearest(
    @Query('lat') lat: number,
    @Query('lng') lng: number,
    @Query('k') k?: number,
  ): Promise<WebResponse<any>> {
    const data = await this.service.nearest({
      lat: Number(lat),
      lng: Number(lng),
      k: k ? Number(k) : undefined,
    });
    return { data };
  }

  // Details
  @Get(':id')
  async detail(@Param('id', ParseIntPipe) id: number) {
    const data = await this.service.detail(id);
    return { data };
  }

  @Get(':id/ratings/summary')
  async ratingSummary(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.getRatingSummary(id) };
  }

  @Get(':id/reviews')
  async reviews(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.getReviews(id) };
  }

  @Get(':id/menu')
  async menu(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.getMenu(id) };
  }

  @Get(':id/promotions')
  async promos(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.getPromotions(id) };
  }

  // Owner actions
  @Post('create')
  @UseGuards(JwtAuthGuard)
  async create(@Body() body: CreateRestaurantDto, @Auth() user: User) {
    const data = await this.service.create(body, user.getUserId());
    return { data };
  }

  @Patch('update/:id')
  @UseGuards(JwtAuthGuard)
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: UpdateRestaurantDto,
    @Auth() user: User,
  ) {
    const data = await this.service.update(id, body, user.getUserId());
    return { data };
  }

  @Patch('menu/:id')
  @UseGuards(JwtAuthGuard)
  async upsertMenu(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: UpsertMenuDto,
    @Auth() user: User,
  ) {
    const data = await this.service.upsertMenu(id, body, user.getUserId());
    return { data };
  }

  @Patch('photo/:id')
  @UseGuards(JwtAuthGuard)
  async setPhoto(
    @Param('id', ParseIntPipe) id: number,
    @Body('imageUrl') imageUrl: string,
    @Auth() user: User,
  ) {
    const data = await this.service.setPhoto(id, imageUrl, user.getUserId());
    return { data };
  }

  @Delete('remove/:id')
  @UseGuards(JwtAuthGuard)
  async remove(@Param('id', ParseIntPipe) id: number, @Auth() user: User) {
    const data = await this.service.remove(id, user.getUserId());
    return { data };
  }

  // Promotions
  @Post(':id/promotions/create')
  @UseGuards(JwtAuthGuard)
  async createPromo(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: CreatePromotionDto,
    @Auth() user: User,
  ) {
    const data = await this.service.createPromotion(id, body, user.getUserId());
    return { data };
  }

  @Patch(':id/promotions/update/:promoId')
  @UseGuards(JwtAuthGuard)
  async updatePromo(
    @Param('id', ParseIntPipe) id: number,
    @Param('promoId', ParseIntPipe) promoId: number,
    @Body() body: UpdatePromotionDto,
    @Auth() user: User,
  ) {
    const data = await this.service.updatePromotion(
      id,
      promoId,
      body,
      user.getUserId(),
    );
    return { data };
  }

  @Delete(':id/promotions/remove/:promoId')
  @UseGuards(JwtAuthGuard)
  async removePromo(
    @Param('id', ParseIntPipe) id: number,
    @Param('promoId', ParseIntPipe) promoId: number,
    @Auth() user: User,
  ) {
    const data = await this.service.deletePromotion(
      id,
      promoId,
      user.getUserId(),
    );
    return { data };
  }

  @Get(':id/promotions/active')
  async activePromos(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.activePromotions(id) };
  }

  @Get('promotions/featured')
  async featuredPromos() {
    return { data: await this.service.featuredPromotions() };
  }

  @Post('recommendations/batch')
  async batchRecommendations(
    @Body()
    body: import('./dto/recommendation-batch.dto').RecommendationBatchDto,
  ) {
    const { origins, maxDistanceKm, limit } = body;
    const results = await Promise.all(
      (origins ?? []).map((o) =>
        this.service.getRecommendations({
          lat: o.lat,
          lng: o.lng,
          maxDistanceKm,
          limit,
          useMatrix: true,
        }),
      ),
    );
    return { data: results };
  }

  // Analytics
  @Get(':id/analytics/overview')
  async analyticsOverview(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.analyticsOverview(id) };
  }

  @Get(':id/analytics/reviews')
  async analyticsReviews(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.analyticsReviews(id) };
  }

  @Get(':id/analytics/promotions')
  async analyticsPromotions(@Param('id', ParseIntPipe) id: number) {
    return { data: await this.service.analyticsPromotions(id) };
  }
}
