import { Module } from '@nestjs/common';
import { GoogleMapsService } from './google-maps.service';
import { GOOGLE_MAPS_GATEWAY } from './tokens';
import { MapsController } from './maps.controller';

@Module({
  controllers: [MapsController],
  providers: [
    {
      provide: GOOGLE_MAPS_GATEWAY,
      useClass: GoogleMapsService,
    },
  ],
  exports: [GOOGLE_MAPS_GATEWAY],
})
export class GoogleMapsModule {}
