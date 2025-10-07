import { Injectable } from '@nestjs/common';
import { AuthRepository } from './interfaces/iauth.repository';
import { PrismaService } from '../../prisma/prisma.service';
import { Prisma } from '@prisma/client';
import { UserBuilder } from '../user/builder/user.builder';
import { ROLE, User } from '../user/user.entity';

@Injectable()
export class AuthRepositoryImpl implements AuthRepository {
  constructor(private readonly prisma: PrismaService) {}

  async save(user: User, tx?: Prisma.TransactionClient): Promise<User> {
    const prismaClient = tx ?? this.prisma;

    const createdUser = await prismaClient.user.create({
      data: {
        username: user.getUsername(),
        name: user.getName(),
        bio: user.getBio(),
        email: user.getEmail(),
        password: user.getPassword(),
        points: user.getPoints(),
        role: user.getRole(),
      },
    });

    const userBuilder = new UserBuilder(createdUser.username, createdUser.email)
      .setName(createdUser.name)
      .setBio(createdUser.bio)
      .setPassword(createdUser.password)
      .setPoints(createdUser.points)
      .setRole(createdUser.role as ROLE);

    return userBuilder.build();
  }
}
