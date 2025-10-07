import { UserResponseDto } from './dto/create-user.dto';
import { SearchUserDto } from './dto/search-user.dto';
import {
  BadRequestException,
  Inject,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { UserService } from './interfaces/iuser.service';
import { UserRepository } from './interfaces/iuser.repository';

@Injectable()
export class UserServiceImpl implements UserService {
  constructor(
    @Inject('UserRepository') private readonly userRepository: UserRepository,
  ) {}

  async search(searchDto: SearchUserDto): Promise<UserResponseDto> {
    const { username, email } = searchDto;
    if (username) {
      return this.findByUsername(username);
    }
    if (email) {
      return this.findByEmail(email);
    }

    throw new BadRequestException('Either username or email must be provided');
  }

  async findById(userId: number): Promise<UserResponseDto> {
    // 1. Check if userID is valid
    if (!userId || userId <= 0) {
      throw new BadRequestException('User ID tidak valid.');
    }

    // 2. Call repository layer
    const foundedUser = await this.userRepository.findById(userId);
    if (!foundedUser) {
      throw new NotFoundException(`User dengan ID ${userId} tidak ditemukan.`);
    }

    // 3. Convert entity to response
    return UserResponseDto.convertToResponse(foundedUser);
  }

  async findByUsername(username: string): Promise<UserResponseDto> {
    // 1. Check if username is valid
    if (!username) {
      throw new BadRequestException('Username tidak boleh kosong.');
    }

    // 2. Call repository layer
    const foundedUser = await this.userRepository.findByUsername(username);
    if (!foundedUser) {
      throw new NotFoundException(
        `User dengan username ${username} tidak ditemukan.`,
      );
    }

    // 3. Convert entity to response
    return UserResponseDto.convertToResponse(foundedUser);
  }

  async findByEmail(email: string): Promise<UserResponseDto> {
    // 1. Check if email is valid
    if (!email) {
      throw new BadRequestException('Email tidak boleh kosong.');
    }

    // 2. Call repository layer
    const foundedUser = await this.userRepository.findByEmail(email);
    if (!foundedUser) {
      throw new NotFoundException(
        `User dengan email ${email} tidak ditemukan.`,
      );
    }

    // 3. Convert entity to response
    return UserResponseDto.convertToResponse(foundedUser);
  }
}
