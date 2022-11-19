import 'package:flutter/material.dart';
import 'package:stream_timer/constants/colors.dart';
import 'package:stream_timer/primitives/order.dart';

class FoodOrderCard extends StatelessWidget {
  const FoodOrderCard({
    super.key,
    required this.title,
    required this.price,
    required this.multiplier,
    required this.rating,
    required this.iconBgColor,
    required this.foodType,
  });

  final String title;
  final double price;
  final int multiplier;
  final double rating;
  final int iconBgColor;
  final FoodType foodType;

  @override
  Widget build(BuildContext context) {
    String iconPath = "";
    if (foodType == FoodType.burger) {
      iconPath = "assets/icons/hamburger.png";
    } else if (foodType == FoodType.taco) {
      iconPath = "assets/icons/taco.png";
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_border, color: AppColors.grey),
                  Text(
                    rating.toString(),
                    style: const TextStyle(fontSize: 16, color: AppColors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$$price",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${multiplier}x",
                style: const TextStyle(fontSize: 18, color: AppColors.grey),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(iconBgColor),
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(child: Image.asset(iconPath)),
            ),
          ),
        ),
      ],
    );
  }
}
