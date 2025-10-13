import type { LatLng } from '../common';
import type {
  DistanceMatrixDestination,
  DistanceMatrixOptions,
} from '../dto/distance-matrix.dto';
import type {
  GeolocationRequest,
  GeolocationResult,
} from '../dto/geolocation.dto';
import type { GeocodeResult } from '../dto/geocoding.dto';

export interface GoogleMapsGateway {
  distanceMatrix(
    origin: LatLng,
    destinations: DistanceMatrixDestination[],
    options?: DistanceMatrixOptions,
  ): Promise<Map<number, { distanceKm: number; durationSec: number }>>;

  geolocate(request: GeolocationRequest): Promise<GeolocationResult>;

  geocode(address: string): Promise<GeocodeResult[]>;
}
