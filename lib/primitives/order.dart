enum FoodType { taco, burger }

class Order {
  Order({
    required this.name,
    required this.price,
    required this.rating,
    required this.multiplier,
    required this.foodType,
  });

  final String name;
  final double price;
  final double rating;
  final int multiplier;
  final FoodType foodType;
}
