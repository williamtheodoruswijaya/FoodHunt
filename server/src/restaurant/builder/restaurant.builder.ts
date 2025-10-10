import { RestaurantProps } from '../interfaces/irestaurant.entity';

export class RestaurantBuilder {
  private props: Partial<RestaurantProps> = {};

  constructor(
    userId: number,
    name: string,
    address: string,
    latitude: number,
    longitude: number,
  ) {
    this.props.userId = userId;
    this.props.name = name;
    this.props.address = address;
    this.props.latitude = latitude;
    this.props.longitude = longitude;
  }

  public setRestaurantId(restaurantId: number) {
    this.props.restaurantId = restaurantId;
    return this;
  }

  public setDescription(description: string) {
    this.props.description = description;
    return this;
  }

  public setImageUrl(imageUrl: string) {
    this.props.imageUrl = imageUrl;
    return this;
  }

  public setPriceRange(priceRange: number) {
    this.props.priceRange = priceRange;
    return this;
  }

  public setCreatedAt(createdAt: Date) {
    this.props.createdAt = createdAt;
    return this;
  }

  public setUpdatedAt(updatedAt: Date) {
    this.props.updatedAt = updatedAt;
    return this;
  }
}
