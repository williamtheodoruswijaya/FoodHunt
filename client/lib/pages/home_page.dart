import 'package:flutter/material.dart';
import 'package:client/pages/restaurant_dummy_data.dart';
import 'package:client/pages/restaurant_detail_page.dart';
import 'package:client/widgets/restaurant_card.dart';
import 'package:client/pages/restaurant_swipe_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurants = allDummyRestaurants;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => RestaurantSwipePage(
                    allRestaurants: allDummyRestaurants,
                    allMenus: allDummyMenus,
                    initialIndex: 0,
                  ),
            ),
          );
        },
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.favorite, color: Colors.white),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.help_outline, color: Colors.grey),
                Icon(Icons.help_outline, color: Colors.grey),
                SizedBox(width: 48), // ruang kosong buat FAB
                Icon(Icons.help_outline, color: Colors.grey),
                Icon(Icons.help_outline, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lokasi & Profil
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.pinkAccent,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Grand Indonesia, Jakarta",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const CircleAvatar(
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

              //Promo
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2E5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Celebrate 9.9 with us!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Enjoy a special discount on your ramen",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
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
              ),

              const SizedBox(height: 24),

              // Popular resto
              const Text(
                "Popular",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // list resto
              Column(
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
                                    (_) => RestaurantDetailPage(
                                      restaurant: r,
                                      menuItems: allDummyMenus[r.id] ?? [],
                                    ),
                              ),
                            );
                          },
                          child: RestaurantCard(restaurant: r),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
