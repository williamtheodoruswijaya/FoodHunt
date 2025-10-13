import { Injectable } from '@nestjs/common';
import type { GoogleMapsGateway } from './interfaces/igoogle-maps.gateway';
import type { LatLng } from './common';
import type {
  DistanceMatrixDestination,
  DistanceMatrixOptions,
} from './dto/distance-matrix.dto';
import { isGoogleDistanceMatrixResponse } from './dto/distance-matrix.dto';
import type {
  GeolocationRequest,
  GeolocationResult,
} from './dto/geolocation.dto';
import type { GeocodeResult } from './dto/geocoding.dto';

class GoogleMapsApiError extends Error {
  constructor(
    message: string,
    public readonly status?: number,
  ) {
    super(message);
    this.name = 'GoogleMapsApiError';
  }
}

@Injectable()
export class GoogleMapsService implements GoogleMapsGateway {
  private get apiKey(): string {
    const key = process.env.GOOGLE_MAPS_API_KEY;
    if (!key) {
      throw new GoogleMapsApiError(
        'Missing GOOGLE_MAPS_API_KEY environment variable',
      );
    }
    return key;
  }

  async distanceMatrix(
    origin: LatLng,
    destinations: DistanceMatrixDestination[],
    options?: DistanceMatrixOptions,
  ): Promise<Map<number, { distanceKm: number; durationSec: number }>> {
    if (!destinations.length) return new Map();

    const units = options?.units ?? 'metric';
    const mode = options?.mode ?? 'driving';

    const originsParam = `${origin.lat},${origin.lng}`;
    const destinationsParam = destinations
      .map((d) => `${d.location.lat},${d.location.lng}`)
      .join('|');

    const url = `https://maps.googleapis.com/maps/api/distancematrix/json?units=${encodeURIComponent(
      units,
    )}&mode=${encodeURIComponent(mode)}&origins=${encodeURIComponent(
      originsParam,
    )}&destinations=${encodeURIComponent(destinationsParam)}&key=${this.apiKey}`;

    const res = await fetch(url);
    if (!res.ok) {
      throw new GoogleMapsApiError(
        'Distance Matrix request failed',
        res.status,
      );
    }
    const json = (await res.json()) as unknown;
    if (!isGoogleDistanceMatrixResponse(json)) {
      throw new GoogleMapsApiError('Unexpected Distance Matrix response shape');
    }

    const elements = json.rows?.[0]?.elements ?? [];
    const map = new Map<number, { distanceKm: number; durationSec: number }>();
    for (let i = 0; i < Math.min(elements.length, destinations.length); i++) {
      const e = elements[i];
      const id = destinations[i].id;
      const meters = e?.distance?.value ?? null;
      const seconds = e?.duration?.value ?? null;
      if (meters !== null && seconds !== null) {
        map.set(id, { distanceKm: meters / 1000, durationSec: seconds });
      }
    }
    return map;
  }

  async geolocate(request: GeolocationRequest): Promise<GeolocationResult> {
    const url = `https://www.googleapis.com/geolocation/v1/geolocate?key=${this.apiKey}`;
    const res = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(request ?? {}),
    });
    if (!res.ok) {
      throw new GoogleMapsApiError('Geolocation request failed', res.status);
    }
    const json = (await res.json()) as any;
    const lat = json?.location?.lat;
    const lng = json?.location?.lng;
    const accuracy = json?.accuracy;
    if (
      typeof lat !== 'number' ||
      typeof lng !== 'number' ||
      typeof accuracy !== 'number'
    ) {
      throw new GoogleMapsApiError('Unexpected Geolocation response shape');
    }
    return { lat, lng, accuracy };
  }

  async geocode(address: string): Promise<GeocodeResult[]> {
    const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(
      address,
    )}&key=${this.apiKey}`;
    const res = await fetch(url);
    if (!res.ok) {
      throw new GoogleMapsApiError('Geocoding request failed', res.status);
    }
    const json = (await res.json()) as any;
    const results: GeocodeResult[] = Array.isArray(json?.results)
      ? json.results
          .map((r: any) => {
            const loc = r?.geometry?.location;
            if (typeof loc?.lat !== 'number' || typeof loc?.lng !== 'number') {
              return null;
            }
            return {
              formattedAddress: r?.formatted_address ?? '',
              location: { lat: loc.lat, lng: loc.lng },
              placeId: r?.place_id,
              types: Array.isArray(r?.types)
                ? (r.types as string[])
                : undefined,
            } as GeocodeResult;
          })
          .filter(Boolean)
      : [];
    return results;
  }
}
