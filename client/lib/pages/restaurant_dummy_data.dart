// lib/pages/restaurant/restaurant_dummy_data.dart
import 'package:client/features/restaurant/data/restaurant_model.dart';
import 'package:client/features/item/data/item_model.dart';

final dummyRestaurant = Restaurant(
  id: 1,
  name: "Sushi Cuy",
  description:
      "Restoran sushi autentik dengan bahan-bahan segar langsung dari Jepang. Menyajikan berbagai macam sushi, sashimi, dan makanan Jepang lainnya.",
  rating: 4.8,
  priceRange: "Rp 25.000 - Rp 150.000",
  category: "Japanese • Sushi • Sashimi",
  locationName: "Jl. Setiabudi No. 45, Bandung",
  imageUrl: "assets/images/sushi_cuy_hero.jpeg",
);

final dummyMenuItems = [
  MenuItem(
    id: 1,
    restaurantId: 1,
    name: "Salmon Sushi",
    description: "Sushi salmon segar dengan nasi premium.",
    price: "Rp 35.000",
    imageUrl: "assets/images/sushi_cuy_menu1.jpeg",
  ),
  MenuItem(
    id: 2,
    restaurantId: 1,
    name: "Tuna Roll",
    description: "Roll tuna segar dengan nori dan nasi Jepang.",
    price: "Rp 40.000",
    imageUrl: "assets/images/sushi_cuy_menu2.jpeg",
  ),
  MenuItem(
    id: 3,
    restaurantId: 1,
    name: "Ebi Tempura",
    description:
        "Udang goreng tepung khas Jepang, renyah di luar, lembut di dalam.",
    price: "Rp 45.000",
    imageUrl: "assets/images/sushi_cuy_menu3.jpeg",
  ),
  MenuItem(
    id: 4,
    restaurantId: 1,
    name: "Miso Soup",
    description: "Sup kedelai hangat dengan potongan tahu dan rumput laut.",
    price: "Rp 20.000",
    imageUrl: "assets/images/sushi_cuy_menu1.jpeg",
  ),
  MenuItem(
    id: 5,
    restaurantId: 1,
    name: "Ocha (Teh Jepang)",
    description: "Teh hijau Jepang klasik, disajikan dingin atau panas.",
    price: "Rp 10.000",
    imageUrl: "assets/images/sushi_cuy_menu2.jpeg",
  ),
];
