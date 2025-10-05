import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsEmail } from 'class-validator';

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
