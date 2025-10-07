import { JwtModule } from '@nestjs/jwt';
import { Module } from '@nestjs/common';
import { PassportModule } from '@nestjs/passport';
import { AuthController } from './auth.controller';
import { AuthServiceImpl } from './auth.service';
import { AuthRepositoryImpl } from './auth.repository';
import { JwtStrategy } from './strategies/jwt.strategy';
import { UserModule } from '../user/user.module';

@Module({
  imports: [
    UserModule,
    PassportModule,
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      signOptions: { expiresIn: '1h' },
    }),
  ],
  controllers: [AuthController],
  providers: [
    {
      provide: 'AuthService',
      useClass: AuthServiceImpl,
    },
    {
      provide: 'AuthRepository',
      useClass: AuthRepositoryImpl,
    },
    JwtStrategy,
  ],
  exports: ['AuthService'],
})
export class AuthModule {}
