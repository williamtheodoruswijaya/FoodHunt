import type { LatLng } from '../common';

export interface GeocodeResult {
  formattedAddress: string;
  location: LatLng;
  placeId?: string;
  types?: string[];
}
