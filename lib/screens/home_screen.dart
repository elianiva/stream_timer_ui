import 'package:flutter/material.dart';
import 'package:stream_timer/primitives/order.dart';
import 'package:stream_timer/widgets/countdown_display.dart';
import 'package:stream_timer/widgets/order_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final List<Order> orders = [
    Order(
      name: "BBQ Burger",
      price: 3.49,
      rating: 4.29,
      multiplier: 1,
      foodType: FoodType.burger,
    ),
    Order(
      name: "Fish Taco",
      price: 5.39,
      rating: 4.29,
      multiplier: 2,
      foodType: FoodType.taco,
    ),
    Order(
      name: "Chicked Burger",
      price: 3.49,
      rating: 4.29,
      multiplier: 1,
      foodType: FoodType.burger,
    ),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final now = DateTime.now();
  late final end = DateTime(now.year, now.month, now.day, now.hour + 10, now.minute, now.second + 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        toolbarHeight: 64,
        leading: const Icon(Icons.arrow_back),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.phone_enabled),
          ),
        ],
        title: const Center(
          child: Text(
            "Order Details",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CountdownDisplay(end: end),
            OrderList(orders: widget.orders),
          ],
        ),
      ),
    );
  }
}
