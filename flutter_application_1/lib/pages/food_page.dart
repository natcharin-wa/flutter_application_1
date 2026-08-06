import 'package:flutter/material.dart';
import '../widgets/menu_card.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        MenuCard(
          image: "lib/assets/fried_rice.jpg",
          name: "ข้าวผัดกุ้ง",
          price: 65,
        ),
        MenuCard(
          image: "lib/assets/basil_pork.jpg",
          name: "ผัดกะเพรา",
          price: 60,
        ),
        MenuCard(
          image: "lib/assets/chicken_rice.jpg",
          name: "ข้าวมันไก่",
          price: 55,
        ),
        MenuCard(
          image: "lib/assets/red_pork_rice.jpg",
          name: "ข้าวหมูแดง",
          price: 60,
        ),
        MenuCard(
          image: "lib/assets/pad_see_ew.jpg",
          name: "ผัดซีอิ๊ว",
          price: 55,
        ),
        MenuCard(
          image: "lib/assets/rad_na.jpg",
          name: "ราดหน้า",
          price: 60,
        ),
      ],
    );
  }
}
