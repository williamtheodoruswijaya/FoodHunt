import { Module } from '@nestjs/common';
import { RestaurantController } from './restaurant.controller';
import { RestaurantServiceImpl } from './restaurant.service';
import { RestaurantRepositoryImpl } from './restaurant.repository';
import { ReviewModule } from '../review/review.module';

@Module({
  imports: [ReviewModule],
  controllers: [RestaurantController],
  providers: [
    {
      provide: 'RestaurantService',
      useClass: RestaurantServiceImpl,
    },
    {
      provide: 'RestaurantRepository',
      useClass: RestaurantRepositoryImpl,
    },
  ],
  exports: ['RestaurantService', 'RestaurantRepository'],
})
export class RestaurantModule {}
