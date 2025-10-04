import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Location + profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.pinkAccent),
                      SizedBox(width: 6),
                      Text(
                        "Grand Indonesia, Jakarta",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/100?img=12',
                    ), // contoh foto
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🔹 Greeting
              const Text(
                "What are you going to eat today?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 🔹 Promo card
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Celebrate 9.9 with us!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Enjoy a special discount on your ramen\nClaim your voucher here!",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image(
                      image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3480/3480597.png',
                      ),
                      width: 70,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 🔹 Popular section
              const Text(
                "Popular",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 🔸 Restaurant Card 1
              _buildRestaurantCard(
                image:
                    'https://images.unsplash.com/photo-1553621042-f6e147245754',
                name: 'Sushi Cuy!',
                location: 'Mall Grand Indonesia, Floor LG. F12',
                rating: 4.3,
                category: 'Japanese',
              ),

              const SizedBox(height: 16),

              // 🔸 Restaurant Card 2
              _buildRestaurantCard(
                image:
                    'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
                name: "Let's Eat!",
                location: 'Mall Grand Indonesia, Floor G. A12',
                rating: 4.8,
                category: 'Western',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard({
    required String image,
    required String name,
    required String location,
    required double rating,
    required String category,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(rating.toStringAsFixed(1)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(location, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
