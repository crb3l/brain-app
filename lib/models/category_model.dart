import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: 'Attention',
        iconPath: 'assets/icons/attention.svg',
        boxColor: const Color(0xFFef7c29),
      ),
    );

    categories.add(
      CategoryModel(
        name: 'Memory',
        iconPath: 'assets/icons/memory.svg',
        boxColor: const Color(0xff69b64f),
      ),
    );

    categories.add(
      CategoryModel(
        name: 'Thinking',
        iconPath: 'assets/icons/sharpness.svg',
        boxColor: const Color(0xff30b4c9),
      ),
    );

    return categories;
  }
}
