import 'package:client/components/navbar.dart';
import 'package:client/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/pages/restaurant_detail_page.dart';
import 'package:client/widgets/restaurant_card.dart';
import 'package:client/features/restaurant/provider/restaurant_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendations = ref.watch(restaurantRecommendationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: recommendations.when(
        data:
            (restaurants) =>
                CustomFloatingActionButton(restaurants: restaurants),
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primary, size: 20),
                      SizedBox(width: 4),
                      Text(
                        "Grand Indonesia, Jakarta",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                "What are you going to eat today?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              _buildPromo(),

              const SizedBox(height: 24),

              const Text(
                "Popular",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              recommendations.when(
                loading: () => const Center(child: CircularProgressIndicator()),

                error:
                    (err, _) => Text(
                      "Failed to load restaurants: $err",
                      style: const TextStyle(color: Colors.red),
                    ),

                data: (restaurants) {
                  return Column(
                    children:
                        restaurants.map((r) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            RestaurantDetailPage(restaurant: r),
                                  ),
                                );
                              },
                              child: RestaurantCard(restaurant: r),
                            ),
                          );
                        }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Promo
  Widget _buildPromo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2E5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Celebrate 9.9 with us!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Enjoy a special discount on your ramen",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                SizedBox(height: 8),
                Text(
                  "Claim your voucher here!",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            "assets/images/ramen.jpg",
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
