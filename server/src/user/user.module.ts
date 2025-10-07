import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserRepositoryImpl } from './user.repository';
import { UserServiceImpl } from './user.service';

@Module({
  imports: [],
  controllers: [UserController],
  providers: [
    {
      provide: 'UserService',
      useClass: UserServiceImpl,
    },

    {
      provide: 'UserRepository',
      useClass: UserRepositoryImpl,
    },
  ],
  exports: ['UserRepository', 'UserService'],
})
export class UserModule {}
