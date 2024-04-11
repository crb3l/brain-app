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
        boxColor: Color(0xff92A3FD),
      ),
    );

    categories.add(
      CategoryModel(
        name: 'Memory',
        iconPath: 'assets/icons/memory.svg',
        boxColor: Color(0xffC58BF2),
      ),
    );

    categories.add(
      CategoryModel(
        name: 'Sharpness',
        iconPath: 'assets/icons/sharpness.svg',
        boxColor: Color(0xff92A3FD),
      ),
    );

    return categories;
  }
}
