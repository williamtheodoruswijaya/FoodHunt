export interface RestaurantProps {
  restaurantId: number;
  userId: number;
  name: string;
  description?: string;
  address: string;
  latitude: number;
  longitude: number;
  imageUrl?: string;
  priceRange: number;
  createdAt: Date;
  updatedAt: Date;
}
