import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String iconPath;

  Category({required this.id, required this.title, required this.iconPath});
}

class Donut {
  final String id;
  final String categoryId; // Added to relate to Category.id
  final String title;
  final String subtitle;
  final double price;
  final String imagePath;
  final Color backgroundColor;
  final Color titleColor;
  final List<Ingredient> ingredients;
  final String description;

  Donut({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
    required this.backgroundColor,
    required this.titleColor,
    required this.ingredients,
    required this.description,
  });
}

class Ingredient {
  final String name;
  final String amount;
  final double percentage;
  final Color color;

  Ingredient({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
  });
}
