import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class SearchUserDto {
  @ApiPropertyOptional({
    description: 'Find user by username',
    example: 'john.doe',
  })
  @IsOptional()
  @IsString()
  username?: string;

  @ApiPropertyOptional({
    description: 'Find user by email',
    example: 'john.doe@gmail.com',
  })
  @IsOptional()
  @IsString()
  email?: string;
}
