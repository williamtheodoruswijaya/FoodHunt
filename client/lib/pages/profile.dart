import 'package:client/components/navbar.dart';
import 'package:client/components/statCardProfile.dart';
import 'package:client/components/visitedCard.dart';
import 'package:client/features/user/data/user_model.dart';
import 'package:client/pages/restaurant_dummy_data.dart';
import 'package:client/pages/restaurant_swipe_page.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/features/user/data/user_model.dart'; 
import 'package:client/theme/constants.dart';



class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = UserModel(
      userId: 1,
      username: 'admantix',
      name: 'Admantix Pemantik',
      email: 'admantix@example.com',
      bio: 'Food lover and avid reviewer.',
      points: 2500,
      role: 'USER',
      profilePicture: null,
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: Container(
              decoration: BoxDecoration(
                // kalo ga ada image pake primary color,
                color: user.profilePicture == null ? secondary : null,
                image: user.profilePicture != null
                    ? DecorationImage(
                        image: NetworkImage(user.profilePicture!),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter
                      )
                    : null,
              ),
              child: user.profilePicture == null
                  ? Center (
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "No Profile Picture",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    )
                  :null,
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(36),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '@${user.username}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user.bio,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Points Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(
                          '${user.points} points',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Statistics Section
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatCardProfile(
                          icon: Icons.favorite, 
                          label: 'Favorites', 
                          count: '20'
                        ),
                        SizedBox(width: 16),
                        StatCardProfile(
                          icon: Icons.edit_note, 
                          label: 'Total Reviews', 
                          count: '15'
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Visited Restaurants Section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Visited Restaurants',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // list of visited restaurants
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          FoodItem(imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=200&q=80'),
                          FoodItem(imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=200&q=80'),
                          FoodItem(imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=200&q=80'),
                          FoodItem(imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?auto=format&fit=crop&w=200&q=80'),
                          FoodItem(imageUrl: 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?auto=format&fit=crop&w=200&q=80'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}