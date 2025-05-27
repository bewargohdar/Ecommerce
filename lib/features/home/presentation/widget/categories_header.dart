import 'package:ecomerce/features/category/presentation/screen/category.dart';
import 'package:flutter/material.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color ?? Colors.white),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CategoryPage();
              }));
            },
            child: const Text(
              "See all",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
