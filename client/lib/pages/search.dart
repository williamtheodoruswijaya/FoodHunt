

import 'package:client/components/categoryItem.dart';
import 'package:client/components/foodCard.dart';
import 'package:client/components/navbar.dart';
import 'package:client/theme/constants.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> foodItems = [
      {
        'title': 'Cheeseburger',
        'restaurant': 'Burger Haven',
        'rating': '4.8',
        'reviews': '335+',
        'price': 'Rp 45.000',
        'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=60',
      },
      {
        'title': 'Pepperoni Pizza',
        'restaurant': 'Pizza Hut',
        'rating': '4.5',
        'reviews': '1.2k+',
        'price': 'Rp 120.000',
        'imageUrl': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?auto=format&fit=crop&w=500&q=60',
      },
      {
        'title': 'Salmon Sushi',
        'restaurant': 'Sushi Tei',
        'rating': '4.9',
        'reviews': '500+',
        'price': 'Rp 65.000',
        'imageUrl': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=500&q=60',
      },
      {
        'title': 'Caesar Salad',
        'restaurant': 'Green Salad',
        'rating': '4.2',
        'reviews': '150+',
        'price': 'Rp 35.000',
        'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=500&q=60',
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location + Notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: primary, size: 20),
                          SizedBox(width: 4),
                          Text(
                            'Grand Indonesia, Jakarta',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: primary),
                        ],
                      )
                    ],
                  ),
                  // Notificiation
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(Icons.notifications_none, size: 24, color: primary),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for food or restaurant',
                  prefixIcon: const Icon(Icons.search, color: primary),
                  suffixIcon: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: const Icon(Icons.tune, color:primary),
                  ),
                  filled: true,
                  fillColor: bgLogin,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Banner Promo
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
                              color: primary,
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

              // Categories
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:[
                    CategoryItem(
                      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=150&q=60',
                      label: 'Burger',
                      isSelected: true,
                    ),
                    CategoryItem(
                      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=150&q=60',
                      label: 'Pizza',
                    ),
                    CategoryItem(
                      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=150&q=60',
                      label: 'Sushi',
                    ),
                    CategoryItem(
                      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=150&q=60',
                      label: 'Salad',
                    ),
                    CategoryItem(
                      imageUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=150&q=60',
                      label: 'Taco',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              // Popular
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Popular",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 14, color: primary),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),

              // list popular items
              SizedBox(
                height: 270, // Fixed height is required for horizontal ListView
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 4,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final item = foodItems[index]; 
                    
                    return SizedBox(
                      width: 200,
                      child: FoodCard(
                        // Pass the values from the list
                        title: item['title']!,
                        restaurant: item['restaurant']!,
                        rating: item['rating']!,
                        reviews: item['reviews']!,
                        price: item['price']!,
                        imageUrl: item['imageUrl']!,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}