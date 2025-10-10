import {
  ConflictException,
  Inject,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { CreateUserDto, UserResponseDto } from '../user/dto/create-user.dto';
import { AuthUserDto, AuthUserResponseDto } from './dto/auth-user.dto';
import * as bcrypt from 'bcrypt';
import { PrismaService } from '../../prisma/prisma.service';
import { UserBuilder } from '../user/builder/user.builder';
import { ROLE } from '../user/user.entity';
import { JwtService } from '@nestjs/jwt';
import { UserRepository } from '../user/interfaces/iuser.repository';
import { AuthService } from './interfaces/iauth.service';
import { AuthRepository } from './interfaces/iauth.repository';

@Injectable()
export class AuthServiceImpl implements AuthService {
  constructor(
    @Inject('AuthRepository') private readonly authRepository: AuthRepository,
    @Inject('UserRepository') private readonly userRepository: UserRepository,
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}
  async register(
    req: CreateUserDto,
    owner?: boolean,
  ): Promise<UserResponseDto> {
    // 1. start transaction
    const createdUserEntity = await this.prisma.$transaction(async (tx) => {
      // 2. check for duplicates user
      const existingUser = await this.userRepository.findByUsername(
        req.username,
      );
      if (existingUser) {
        throw new ConflictException(`Username ${req.username} already exists!`);
      }

      const existingEmail = await this.userRepository.findByEmail(req.email);
      if (existingEmail) {
        throw new ConflictException(`Email ${req.email} already exists!`);
      }

      const hashedPassword = await bcrypt.hash(req.password, 10);

      const userEntity = new UserBuilder(req.username, req.email)
        .setName(req.name)
        .setBio('')
        .setPassword(hashedPassword)
        .setPoints(0);

      if (owner) {
        userEntity.setRole(ROLE.RESTAURANT);
      } else {
        userEntity.setRole(ROLE.USER);
      }

      return await this.authRepository.save(userEntity.build(), tx);
    });

    return UserResponseDto.convertToResponse(createdUserEntity);
  }

  async login(req: AuthUserDto): Promise<AuthUserResponseDto> {
    // 1. find user by username
    const user = await this.userRepository.findByUsername(req.username);
    if (!user) {
      throw new UnauthorizedException('wrong username');
    }

    // 2. check password
    const isPasswordMatching = await bcrypt.compare(
      req.password,
      user.getPassword(),
    );
    if (!isPasswordMatching) {
      throw new UnauthorizedException('wrong password');
    }

    // 3. generate token
    const payload = {
      username: user.getUsername(),
      sub: user.getUserId(),
    };
    const accessToken = await this.jwtService.signAsync(payload, {
      secret: process.env.JWT_SECRET,
      expiresIn: '1h',
    });

    // 4. return access token
    return AuthUserResponseDto.convertToResponse(accessToken);
  }
}
