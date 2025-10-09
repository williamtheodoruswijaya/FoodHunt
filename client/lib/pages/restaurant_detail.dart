// lib/pages/restaurant/restaurant_detail_page.dart
import 'package:flutter/material.dart';

// Model data restoran
class Restaurant {
  final String name;
  final String description;
  final double rating;
  final String priceRange;
  final String category;
  final String photoUrl;
  final int totalReviews;
  final String distance;
  final List<MenuCategory> categories;
  final List<MenuItem> menuItems;
  final List<Review> reviews;

  Restaurant({
    required this.name,
    required this.description,
    required this.rating,
    required this.priceRange,
    required this.category,
    required this.photoUrl,
    required this.totalReviews,
    required this.distance,
    required this.categories,
    required this.menuItems,
    required this.reviews,
  });
}

class MenuCategory {
  final String name;

  MenuCategory({required this.name});
}

class MenuItem {
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final String category;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

class Review {
  final String userName;
  final int rating;
  final String comment;
  final String date;

  Review({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class RestaurantDetailPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Restaurant restaurant;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = "Sushi";

    restaurant = Restaurant(
      name: 'Sushi Cuy',
      description:
          'Restoran sushi autentik dengan bahan-bahan segar langsung dari Jepang. Menyajikan berbagai macam sushi, sashimi, dan makanan Jepang lainnya dengan cita rasa yang otentik dan pelayanan terbaik.',
      rating: 4.8,
      priceRange: 'Rp 25.000 - Rp 150.000',
      category: 'Japanese • Sushi • Sashimi',
      photoUrl: 'assets/images/sushi_cuy_hero.jpeg',
      totalReviews: 1247,
      distance: '0.8 km',
      categories: [
        MenuCategory(name: 'Sushi'),
        MenuCategory(name: 'Sashimi'),
        MenuCategory(name: 'Roll'),
        MenuCategory(name: 'Appetizer'),
        MenuCategory(name: 'Minuman'),
      ],
      menuItems: [
        MenuItem(
          name: 'Salmon Sushi (2 pcs)',
          description: 'Sushi salmon segar dengan nasi sushi premium',
          price: 'Rp 35.000',
          imageUrl: 'assets/images/sushi_cuy_menu1.jpeg',
          category: 'Sushi',
        ),
        MenuItem(
          name: 'Tuna Sushi (2 pcs)',
          description: 'Sushi tuna premium dengan tekstur lembut',
          price: 'Rp 45.000',
          imageUrl: 'assets/images/sushi_cuy_menu2.jpeg',
          category: 'Sushi',
        ),
        MenuItem(
          name: 'Ebi Sushi (2 pcs)',
          description: 'Sushi udang matang yang manis dan segar',
          price: 'Rp 30.000',
          imageUrl: 'assets/images/sushi_cuy_menu3.jpeg',
          category: 'Sushi',
        ),
        MenuItem(
          name: 'California Roll (8 pcs)',
          description: 'Roll dengan kepiting, alpukat, dan mentimun',
          price: 'Rp 65.000',
          imageUrl: 'assets/images/sushi_cuy_menu1.jpeg',
          category: 'Roll',
        ),
        MenuItem(
          name: 'Salmon Sashimi (5 pcs)',
          description: 'Potongan salmon segar tanpa nasi',
          price: 'Rp 75.000',
          imageUrl: 'assets/images/sushi_cuy_menu2.jpeg',
          category: 'Sashimi',
        ),
        MenuItem(
          name: 'Gyoza (6 pcs)',
          description: 'Pangsit Jepang isi daging dan sayuran',
          price: 'Rp 25.000',
          imageUrl: 'assets/images/sushi_cuy_menu3.jpeg',
          category: 'Appetizer',
        ),
      ],
      reviews: [
        Review(
          userName: 'Andi Pratama',
          rating: 5,
          comment:
              'Sushi terbaik di Jakarta! Salmon sashimi-nya sangat segar dan pelayanannya cepat. Pasti akan pesan lagi!',
          date: '2 hari yang lalu',
        ),
        Review(
          userName: 'Sari Dewi',
          rating: 5,
          comment:
              'California roll-nya enak banget! Porsinya juga pas dan harganya reasonable untuk kualitas segini.',
          date: '5 hari yang lalu',
        ),
        Review(
          userName: 'Rizky Aditya',
          rating: 4,
          comment:
              'Makanannya enak, tapi pengiriman agak lama dari estimasi. Overall masih recommended sih!',
          date: '1 minggu yang lalu',
        ),
        Review(
          userName: 'Maya Sinta',
          rating: 5,
          comment:
              'Gyoza-nya crispy dan juicy! Sushi salmon juga fresh banget. Packaging rapi dan aman.',
          date: '1 minggu yang lalu',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Status Bar (simulasi)
          SliverAppBar(
            backgroundColor: Colors.amber[300],
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '9:41',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.signal_cellular_4_bar,
                      size: 16,
                      color: Colors.black,
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.wifi, size: 16, color: Colors.black),
                    SizedBox(width: 2),
                    Icon(Icons.battery_full, size: 16, color: Colors.black),
                  ],
                ),
              ],
            ),
            pinned: true,
            elevation: 0,
            toolbarHeight: 32,
          ),

          // Header
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('←', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Detail Restoran',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bagikan ke teman!')),
                    );
                  },
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Icon(Icons.share, size: 18)),
                  ),
                ),
              ],
            ),
            pinned: true,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.1),
          ),

          // Hero Image
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Image.asset(
                  restaurant.photoUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant.distance} dari lokasi Anda',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Restaurant Info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant.category,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Rating & Ulasan
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${restaurant.rating}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${restaurant.totalReviews} ulasan)',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price Range
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      restaurant.priceRange,
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    restaurant.description,
                    style: TextStyle(color: Colors.grey[700], height: 1.6),
                  ),
                  const SizedBox(height: 24),

                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${restaurant.rating}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Rating',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${restaurant.totalReviews}+',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Ulasan',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                restaurant.distance.split(' ')[0],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'KM',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Menu Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🍽️ Menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Category Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: restaurant.categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(category.name),
                            selected: category.name == selectedCategory,
                            onSelected: (bool selected) {
                              if (selected) {
                                setState(() {
                                  selectedCategory = category.name;
                                });
                              }
                            },
                            selectedColor: Colors.orange[300],
                            checkmarkColor: Colors.white,
                            labelStyle: TextStyle(
                              color: category.name == selectedCategory
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Menu Items (tanpa tombol +)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurant.menuItems.length,
                    itemBuilder: (context, index) {
                      final item = restaurant.menuItems[index];
                      if (item.category != selectedCategory) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        height: 1.4,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.price,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ❌ TOMBOL + DIHAPUS
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Reviews Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
                bottom: 16, // tidak perlu space untuk cart
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '⭐ Ulasan Pelanggan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurant.reviews.length,
                    itemBuilder: (context, index) {
                      final review = restaurant.reviews[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          review.userName[0],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      review.userName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (i) => Icon(
                                          i < review.rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  review.comment,
                                  style: const TextStyle(height: 1.5),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  review.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // ❌ BOTTOM NAVIGATION (CART) DIHAPUS
    );
  }
}
