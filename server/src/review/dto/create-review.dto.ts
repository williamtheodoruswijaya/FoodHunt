import { ApiProperty } from '@nestjs/swagger';
import {
  Min,
  Max,
  IsOptional,
  IsString,
  IsNumber,
  IsObject,
  IsDate,
} from 'class-validator';
import { UserResponseDto } from '../../user/dto/create-user.dto';
import { User } from '../../user/user.entity';
import { Review } from '../review.entity';

export class CreateReviewDto {
  @ApiProperty({
    description: 'Rating antara 1 sampai 5 untuk restoran',
    minimum: 1,
    maximum: 5,
  })
  @IsNumber()
  @Min(1)
  @Max(5)
  rating: number;

  @ApiProperty({ description: 'Komentar review optional', required: false })
  @IsOptional()
  @IsString()
  comment?: string;
}

export class ReviewResponse {
  @ApiProperty({
    description: 'Review ID',
  })
  @IsNumber()
  reviewId: number;

  @ApiProperty({
    description: 'User ID that gives reviews',
  })
  @IsNumber()
  userId: number;

  @ApiProperty({
    description: 'User Info that gives review based on userID',
  })
  @IsObject()
  User: UserResponseDto;

  @ApiProperty({
    description: 'Restaurant ID that have that reviews',
  })
  @IsNumber()
  restaurantId: number;

  @ApiProperty({
    description: 'Rating of a restaurant',
  })
  @IsNumber()
  rating: number;

  @ApiProperty({
    description: 'Commentar/Masukan buat resto',
  })
  @IsString()
  comment: string;

  @ApiProperty({
    description: 'Date the review are created',
  })
  @IsDate()
  createdAt: Date;

  static convertToResponse(review: Review, user: User): ReviewResponse {
    const dto = new ReviewResponse();
    dto.reviewId = review.getReviewId();
    dto.restaurantId = review.getRestaurantId();
    dto.userId = review.getUserId();
    dto.rating = review.getRating();
    dto.comment = review.getComment();
    dto.createdAt = review.getCreatedAt();
    dto.User = UserResponseDto.convertToResponse(user);
    return dto;
  }
}
