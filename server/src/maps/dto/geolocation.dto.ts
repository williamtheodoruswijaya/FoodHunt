import type { LatLng } from '../common';

export interface CellTower {
  cellId?: number;
  locationAreaCode?: number;
  mobileCountryCode?: number;
  mobileNetworkCode?: number;
  age?: number;
  signalStrength?: number;
  timingAdvance?: number;
}

export interface WifiAccessPoint {
  macAddress: string;
  signalStrength?: number;
  age?: number;
  channel?: number;
  signalToNoiseRatio?: number;
}

export interface GeolocationRequest {
  considerIp?: boolean;
  cellTowers?: CellTower[];
  wifiAccessPoints?: WifiAccessPoint[];
}

export interface GeolocationResponse {
  location: LatLng & { accuracy: number };
}

export interface GeolocationResult {
  lat: number;
  lng: number;
  accuracy: number; // meters
}
