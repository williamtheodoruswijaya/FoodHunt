import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { LoggerMiddleware } from './common/middleware/logger.middleware';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from '../prisma/prisma.module';
import { RestaurantModule } from './restaurant/restaurant.module';
import { ReviewModule } from './review/review.module';

@Module({
  imports: [
    ThrottlerModule.forRoot([
      {
        ttl: 60, // Waktu dalam detik (60 detik)
        limit: 10, // Batas 10 request per 60 detik dari satu IP
      },
    ]),
    PrismaModule,
    AuthModule,
    UserModule,
    RestaurantModule,
    ReviewModule,
  ],
  controllers: [],
  providers: [
    {
      provide: 'APP_GUARD',
      useClass: ThrottlerGuard,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LoggerMiddleware).forRoutes('*'); // Terapkan ke semua route
  }
}
