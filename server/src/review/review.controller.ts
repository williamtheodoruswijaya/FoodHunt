import {
  Body,
  Controller,
  Delete,
  Get,
  Inject,
  Param,
  ParseIntPipe,
  Post,
  UseGuards,
} from '@nestjs/common';
import { ReviewService } from './interfaces/ireview.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { WebResponse } from '../common/model/web.response';
import { CreateReviewDto, ReviewResponse } from './dto/create-review.dto';
import { User } from '../user/user.entity';
import { Auth } from '../common/decorators/user.decorator';
import { JwtAuthGuard } from '../common/guards/jwt.guards';

@ApiTags('Review')
@Controller('reviews')
export class ReviewController {
  constructor(
    @Inject('ReviewService') private readonly reviewService: ReviewService,
  ) {}

  @Post('create/:id')
  @UseGuards(JwtAuthGuard)
  @ApiOperation({
    summary: 'Create a review with id params as the restaurant id',
  })
  @ApiResponse({
    status: 201,
    description: 'Review Created Succesfully',
    type: WebResponse<ReviewResponse>,
  })
  async create(
    @Body() createReviewDto: CreateReviewDto,
    @Auth() user: User,
    @Param('id', ParseIntPipe) id: number,
  ): Promise<WebResponse<ReviewResponse>> {
    const review = await this.reviewService.create(createReviewDto, user, id);
    return {
      data: review,
    };
  }

  @Get('restaurant/:id')
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Get a review on a specific restaurant' })
  @ApiResponse({
    status: 200,
    description: 'Get a review on a specific restaurant',
    type: WebResponse<ReviewResponse[]>,
  })
  async getReviews(
    @Param('id', ParseIntPipe) id: number,
  ): Promise<WebResponse<ReviewResponse[]>> {
    const reviews = await this.reviewService.getReviews(id);
    return {
      data: reviews,
    };
  }

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Get review based on review Id (kalau butuh)' })
  @ApiResponse({
    status: 200,
    description: 'Get a specific review using id',
    type: WebResponse<ReviewResponse>,
  })
  async findById(
    @Param('id', ParseIntPipe) id: number,
  ): Promise<WebResponse<ReviewResponse>> {
    const review = await this.reviewService.findById(id);
    return {
      data: review,
    };
  }

  @Delete('remove/:id')
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Delete a review using a review Id' })
  @ApiResponse({
    status: 200,
    description: 'Delete a review using id',
    type: WebResponse<string>,
  })
  async delete(
    @Param('id', ParseIntPipe) id: number,
    @Auth() user: User,
  ): Promise<WebResponse<string>> {
    const status = await this.reviewService.delete(id, user);
    return {
      data: status,
    };
  }
}
