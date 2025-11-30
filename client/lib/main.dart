<<<<<<< HEAD
import 'package:client/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
=======
import 'package:client/pages/home_page.dart';
import 'package:client/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/features/auth/providers/auth_provider.dart';
>>>>>>> 0ddd53b317aaf25081d9e52f67939705001ccfd8

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodHunt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: LoginPage(),
=======
      // ganti aja jadi LoginPage kalo mau liat halaman login
      home: ProfilePage(),
>>>>>>> 0ddd53b317aaf25081d9e52f67939705001ccfd8
    );
  }
}
