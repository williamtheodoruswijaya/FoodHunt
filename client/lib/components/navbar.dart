import 'package:client/pages/home_page.dart';
import 'package:client/pages/profile.dart';
import 'package:client/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:client/theme/constants.dart';
import 'package:client/pages/restaurant_swipe_page.dart';
import 'package:client/pages/restaurant_dummy_data.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RestaurantSwipePage(
                allRestaurants: allDummyRestaurants,
                allMenus: allDummyMenus,
                initialIndex: 0,
              ),
            ),
          );
        },
        backgroundColor: primary,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.favorite, color: Colors.white, size: 32),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Standardized to withOpacity
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
            children:[
              IconButton(
                icon: const Icon(Icons.home, color: primary),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              ),
              IconButton(
                icon: const Icon(Icons.search, color: primary),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                }
              ),
              SizedBox(width: 48), // Empty space for the FAB
              IconButton(
                icon: const Icon(Icons.bookmark_add, color: primary),
                onPressed: (){

                }
              ),
              IconButton(
                icon: const Icon(Icons.person, color: primary),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}