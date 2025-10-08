import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsEmail, IsNumber } from 'class-validator';
import { User } from '../user.entity';

export class CreateUserDto {
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
    description: 'Nama User (mo lengkap, panggilan, bebas)',
    format: 'text',
    minimum: 6,
    maximum: 100,
    example: 'William Theodorus',
    required: true,
  })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({
    description: 'Email',
    format: 'email',
    minimum: 6,
    maximum: 100,
    example: 'admantix@gmail.com',
    required: true,
  })
  @IsEmail()
  @IsNotEmpty()
  email: string;

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

export class UserResponseDto {
  @ApiProperty({
    description: 'User ID',
    format: 'number',
    example: '1',
  })
  userId: number;

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
    description: 'Nama User (mo lengkap, panggilan, bebas)',
    format: 'text',
    minimum: 6,
    maximum: 100,
    example: 'William Theodorus',
    required: true,
  })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({
    description: 'Email',
    format: 'email',
    minimum: 6,
    maximum: 100,
    example: 'admantix@gmail.com',
    required: true,
  })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiProperty({
    description: 'Bio',
    format: 'text',
    minimum: 6,
    maximum: 100,
    example: 'admantix',
    required: true,
  })
  @IsString()
  @IsNotEmpty()
  bio: string;

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

  @ApiProperty({
    description: 'User current points',
    format: 'number',
    example: 0,
    required: true,
  })
  @IsNumber()
  @IsNotEmpty()
  points: number;

  @ApiProperty({
    description: 'Date time account was created',
    format: 'date',
    example: '2017-07-10T00:00:00.000Z',
  })
  createdAt: Date;

  @ApiProperty({
    description: 'Date time account was updated',
    format: 'date',
    example: '2017-07-10T00:00:00.000Z',
  })
  updatedAt: Date;

  static convertToResponse(user: User): UserResponseDto {
    const dto = new UserResponseDto();
    dto.userId = user.getUserId();
    dto.username = user.getUsername();
    dto.name = user.getName();
    dto.email = user.getEmail();
    dto.bio = user.getBio();
    dto.points = user.getPoints();
    dto.password = user.getPassword();
    dto.createdAt = new Date();
    dto.updatedAt = new Date();
    return dto;
  }
}
