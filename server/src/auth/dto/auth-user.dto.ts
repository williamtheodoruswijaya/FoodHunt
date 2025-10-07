import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class AuthUserDto {
  @ApiProperty({
    description: 'Username yang sama dengan username discord',
    format: 'text',
    minimum: 6,
    maximum: 100,
    example: 'admantix',
    required: true,
  })
  @IsString()
  @IsNotEmpty()
  username: string;

  @ApiProperty({
    description: 'Password',
    format: 'text',
    minimum: 8,
    maximum: 100,
    example: 'admin123',
    required: true,
  })
  @IsString()
  @IsNotEmpty()
  password: string;
}

export class AuthUserResponseDto {
  @ApiProperty({
    description: 'JWT Access Token',
    format: 'json',
  })
  accessToken: string;

  static convertToResponse(accessToken: string): AuthUserResponseDto {
    const dto = new AuthUserResponseDto();
    dto.accessToken = accessToken;
    return dto;
  }
}
