import 'dart:ui';

class CategoryCartModel {
  final int id;
  final String image, title, address;
  final double price;
  final List<String> tags;
  final Color color;

  CategoryCartModel({
    required this.id,
    required this.image,
    required this.title,
    required this.address,
    required this.price,
    required this.tags,
    required this.color,
  });
}
