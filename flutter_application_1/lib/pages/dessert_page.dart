import 'package:flutter/material.dart';
import '../widgets/menu_card.dart';

class DessertPage extends StatelessWidget {
  const DessertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        MenuCard(
          image: "lib/assets/bingsu.jpg",
          name: "บิงซู",
          price: 89,
        ),
        MenuCard(
          image: "lib/assets/honey_toast.jpg",
          name: "ฮันนี่โทสต์",
          price: 99,
        ),
        MenuCard(
          image: "lib/assets/chocolate_cake.jpg",
          name: "เค้กช็อกโกแลต",
          price: 75,
        ),
        MenuCard(
          image: "lib/assets/cheesecake.jpg",
          name: "ชีสเค้ก",
          price: 85,
        ),
        MenuCard(
          image: "lib/assets/ice_cream.jpg",
          name: "ไอศกรีม",
          price: 45,
        ),
        MenuCard(
          image: "lib/assets/crepe_cake.jpg",
          name: "เครปเค้ก",
          price: 80,
        ),
      ],
    );
  }
}
