import { Module } from '@nestjs/common';
import { RestaurantController } from './restaurant.controller';
import { RestaurantServiceImpl } from './restaurant.service';
import { RestaurantRepositoryImpl } from './restaurant.repository';

@Module({
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
