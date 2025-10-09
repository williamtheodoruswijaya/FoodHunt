import { Injectable } from '@nestjs/common';
import { UserRepository } from './interfaces/iuser.repository';
import { ROLE, User } from './user.entity';
import { PrismaService } from '../../prisma/prisma.service';
import { UserBuilder } from './builder/user.builder';

@Injectable()
export class UserRepositoryImpl implements UserRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findById(id: number): Promise<User | null> {
    // step 1: define & execute query
    const userFromDb = await this.prisma.user.findUnique({
      where: { userId: id },
    });

    // step 2: handle if not found
    if (!userFromDb) {
      return null;
    }

    // step 3: convert to entity and return (using builder)
    const userBuilder = new UserBuilder(userFromDb.username, userFromDb.email)
      .setUserId(userFromDb.userId)
      .setName(userFromDb.name)
      .setRole(userFromDb.role as ROLE)
      .setPoints(userFromDb.points);

    if (userFromDb.password) {
      userBuilder.setPassword(userFromDb.password);
    }
    if (userFromDb.bio) {
      userBuilder.setBio(userFromDb.bio);
    }

    return userBuilder.build();
  }

  async findByEmail(email: string): Promise<User | null> {
    const userFromDb = await this.prisma.user.findUnique({
      where: { email: email },
    });

    if (!userFromDb) {
      return null;
    }

    const userBuilder = new UserBuilder(userFromDb.username, userFromDb.email)
      .setUserId(userFromDb.userId)
      .setName(userFromDb.name)
      .setPoints(userFromDb.points)
      .setRole(userFromDb.role as ROLE);
    if (userFromDb.password) {
      userBuilder.setPassword(userFromDb.password);
    }
    if (userFromDb.bio) {
      userBuilder.setBio(userFromDb.bio);
    }
    return userBuilder.build();
  }

  async findByUsername(username: string): Promise<User | null> {
    const userFromDb = await this.prisma.user.findUnique({
      where: { username: username },
    });

    if (!userFromDb) {
      return null;
    }

    const userBuilder = new UserBuilder(userFromDb.username, userFromDb.email)
      .setUserId(userFromDb.userId)
      .setName(userFromDb.name)
      .setPoints(userFromDb.points)
      .setRole(userFromDb.role as ROLE);
    if (userFromDb.password) {
      userBuilder.setPassword(userFromDb.password);
    }
    if (userFromDb.bio) {
      userBuilder.setBio(userFromDb.bio);
    }
    return userBuilder.build();
  }

  async findManyByIds(userIds: number[]): Promise<User[]> {
    if (userIds.length === 0) {
      return [];
    }

    const usersFromDb = await this.prisma.user.findMany({
      where: {
        userId: {
          in: userIds,
        },
      },
    });

    return usersFromDb.map((dbUser) =>
      new UserBuilder(dbUser.username, dbUser.email)
        .setUserId(dbUser.userId)
        .setName(dbUser.name)
        .setRole(dbUser.role as ROLE)
        .setBio(dbUser.bio)
        .setPassword(dbUser.password)
        .setPoints(dbUser.points)
        .build(),
    );
  }
}
