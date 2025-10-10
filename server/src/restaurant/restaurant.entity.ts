import { RestaurantProps } from './interfaces/irestaurant.entity';

export class Restaurant {
  private restaurantId: number;
  private userId: number;
  private name: string;
  private description?: string;
  private address: string;
  private latitude: number;
  private longitude: number;
  private imageUrl?: string;
  private priceRange: number;
  private createdAt: Date;
  private updatedAt: Date;

  constructor(partial: Partial<RestaurantProps>) {
    Object.assign(this, partial);
  }

  public getRestaurantId(): number {
    return this.restaurantId;
  }

  public getUserId(): number {
    return this.userId;
  }

  public getName(): string {
    return this.name;
  }

  public getDescription(): string {
    return this.description;
  }

  public getAddress(): string {
    return this.address;
  }

  public getLatitude(): number {
    return this.latitude;
  }

  public getLongitude(): number {
    return this.longitude;
  }

  public getImageUrl(): string {
    return this.imageUrl;
  }

  public getPriceRange(): number {
    return this.priceRange;
  }

  public getCreatedAt(): Date {
    return this.createdAt;
  }

  public getUpdatedAt(): Date {
    return this.updatedAt;
  }
}
