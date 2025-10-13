import type { LatLng, TravelMode, Units } from '../common';

export interface DistanceMatrixDestination {
  id: number;
  location: LatLng;
}

export interface DistanceMatrixOptions {
  mode?: TravelMode;
  units?: Units;
}

export interface DistanceMatrixElementSimplified {
  distanceMeters: number;
  durationSeconds: number;
  status: string;
}

export interface DistanceMatrixResult {
  id: number;
  distanceKm: number;
  durationSec: number;
}

interface GDistance {
  value: number; // meters
  text?: string;
}
interface GDuration {
  value: number; // seconds
  text?: string;
}
interface GElement {
  distance?: GDistance;
  duration?: GDuration;
  status: string;
}
interface GRow {
  elements: GElement[];
}
export interface GoogleDistanceMatrixResponse {
  rows: GRow[];
  status?: string;
}

export function isGoogleDistanceMatrixResponse(
  x: unknown,
): x is GoogleDistanceMatrixResponse {
  if (!x || typeof x !== 'object') return false;
  const rows = (x as any).rows;
  if (!Array.isArray(rows)) return false;
  if (rows.length === 0) return true;
  const first = rows[0];
  return first && Array.isArray(first.elements);
}
