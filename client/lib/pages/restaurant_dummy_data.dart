import 'package:client/features/restaurant/data/restaurant_model.dart';
import 'package:client/features/item/data/item_model.dart';

final dummyRestaurantSushi = Restaurant(
  id: 1,
  name: "Restoran Sushi",
  description:
      "Restoran sushi autentik dengan bahan-bahan segar langsung dari Jepang. Menyajikan berbagai macam sushi, sashimi, dan makanan Jepang lainnya.",
  rating: 4.8,
  priceRange: "Rp 25.000 - Rp 150.000",
  category: "Japanese",
  locationName: "Jl. Setiabudi No. 45, Bandung",
  imageUrl: "assets/images/sushi.jpg",
);

final dummyMenuSushi = [
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

final dummyRestaurantPadang = Restaurant(
  id: 2,
  name: "Restoran Padang",
  description:
      "Rumah makan Padang yang menyajikan berbagai hidangan khas Minang dengan cita rasa autentik dan bumbu rempah yang kaya.",
  rating: 4.6,
  priceRange: "Rp 20.000 - Rp 80.000",
  category: "Indonesian • Padang",
  locationName: "Jl. Asia Afrika No. 12, Bandung",
  imageUrl: "assets/images/padang.jpg",
);

final dummyMenuPadang = [
  MenuItem(
    id: 6,
    restaurantId: 2,
    name: "Rendang Daging",
    description:
        "Daging sapi empuk dimasak perlahan dengan bumbu rempah khas Minang.",
    price: "Rp 35.000",
    imageUrl: "assets/images/padang.jpg",
  ),
  MenuItem(
    id: 7,
    restaurantId: 2,
    name: "Ayam Pop",
    description:
        "Ayam kampung goreng khas Padang disajikan dengan sambal tomat segar.",
    price: "Rp 28.000",
    imageUrl: "assets/images/padang.jpg",
  ),
  MenuItem(
    id: 8,
    restaurantId: 2,
    name: "Gulai Tunjang",
    description: "Iga sapi lembut dalam kuah santan gurih khas Sumatera Barat.",
    price: "Rp 32.000",
    imageUrl: "assets/images/padang.jpg",
  ),
  MenuItem(
    id: 9,
    restaurantId: 2,
    name: "Sambal Ijo",
    description:
        "Sambal pedas segar khas Padang, pelengkap wajib setiap hidangan.",
    price: "Rp 8.000",
    imageUrl: "assets/images/padang.jpg",
  ),
];

final dummyRestaurantNasiGoreng = Restaurant(
  id: 3,
  name: "Restoran Nasi Goreng",
  description:
      "Nasi goreng khas Indonesia dengan bumbu rempah pilihan dan aroma wok panas yang menggoda. Cocok untuk makan malam cepat dan lezat.",
  rating: 4.7,
  priceRange: "Rp 15.000 - Rp 50.000",
  category: "Indonesian • Fried Rice",
  locationName: "Jl. Dipatiukur No. 21, Bandung",
  imageUrl: "assets/images/nasgor.jpg",
);

final dummyMenuNasiGoreng = [
  MenuItem(
    id: 10,
    restaurantId: 3,
    name: "Nasi Goreng Rempah",
    description: "Nasi goreng dengan rempah khas dan topping telur mata sapi.",
    price: "Rp 25.000",
    imageUrl: "assets/images/nasgor.jpg",
  ),
  MenuItem(
    id: 11,
    restaurantId: 3,
    name: "Nasi Goreng Pete",
    description: "Nasi goreng dengan pete segar dan aroma menggoda.",
    price: "Rp 28.000",
    imageUrl: "assets/images/nasgor.jpg",
  ),
  MenuItem(
    id: 12,
    restaurantId: 3,
    name: "Nasi Goreng Seafood",
    description:
        "Nasi goreng premium dengan udang, cumi, dan bakso ikan pilihan.",
    price: "Rp 35.000",
    imageUrl: "assets/images/nasgor.jpg",
  ),
  MenuItem(
    id: 13,
    restaurantId: 3,
    name: "Nasi Goreng Kampung",
    description:
        "Rasa klasik nasi goreng tradisional dengan cabai rawit dan terasi.",
    price: "Rp 22.000",
    imageUrl: "assets/images/nasgor.jpg",
  ),
];

final List<Restaurant> allDummyRestaurants = [
  dummyRestaurantSushi,
  dummyRestaurantPadang,
  dummyRestaurantNasiGoreng,
];

final Map<int, List<MenuItem>> allDummyMenus = {
  1: dummyMenuSushi,
  2: dummyMenuPadang,
  3: dummyMenuNasiGoreng,
};
