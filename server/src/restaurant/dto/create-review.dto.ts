import { ApiProperty } from '@nestjs/swagger';
import { Min, Max, IsOptional, IsString, IsNumber } from 'class-validator';

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
