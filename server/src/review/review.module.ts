import { Module } from '@nestjs/common';
import { ReviewController } from './review.controller';
import { ReviewServiceImpl } from './review.service';
import { ReviewRepositoryImpl } from './review.repository';
import { UserModule } from '../user/user.module';

@Module({
  imports: [UserModule],
  controllers: [ReviewController],
  providers: [
    {
      provide: 'ReviewService',
      useClass: ReviewServiceImpl,
    },

    {
      provide: 'ReviewRepository',
      useClass: ReviewRepositoryImpl,
    },
  ],
  exports: ['ReviewRepository', 'ReviewService'],
})
export class ReviewModule {}
