import 'package:flutter/material.dart';
import '../widgets/menu_card.dart';

class DrinkPage extends StatelessWidget {
  const DrinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        MenuCard(
          image: "lib/assets/thai_tea.jpg",
          name: "ชาไทย",
          price: 45,
        ),
        MenuCard(
          image: "lib/assets/green_tea.jpg",
          name: "ชาเขียว",
          price: 50,
        ),
        MenuCard(
          image: "lib/assets/latte.jpg",
          name: "ลาเต้",
          price: 60,
        ),
        MenuCard(
          image: "lib/assets/espresso.jpg",
          name: "เอสเปรสโซ",
          price: 55,
        ),
        MenuCard(
          image: "lib/assets/cocoa.jpg",
          name: "โกโก้",
          price: 50,
        ),
        MenuCard(
          image: "lib/assets/strawberry_smoothie.jpg",
          name: "สมูทตี้สตรอว์เบอร์รี",
          price: 65,
        ),
      ],
    );
  }
}
