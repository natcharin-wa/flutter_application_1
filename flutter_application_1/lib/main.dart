import 'package:flutter/material.dart';

import 'pages/food_page.dart';
import 'pages/dessert_page.dart';
import 'pages/drink_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(const ICTCafeApp());
}

class ICTCafeApp extends StatelessWidget {
  const ICTCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ICT Cafe',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ICT Cafe"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.restaurant),
                text: "อาหารคาว",
              ),
              Tab(
                icon: Icon(Icons.cake),
                text: "ของหวาน",
              ),
              Tab(
                icon: Icon(Icons.local_drink),
                text: "เครื่องดื่ม",
              ),
              Tab(
                icon: Icon(Icons.info),
                text: "เกี่ยวกับ",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FoodPage(),
            DessertPage(),
            DrinkPage(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.store),
                label: const Text("ข้อมูลร้าน ICT Cafe"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
