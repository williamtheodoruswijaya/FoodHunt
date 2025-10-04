import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const FoodHuntApp());
}

class FoodHuntApp extends StatelessWidget {
  const FoodHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodHunt',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
