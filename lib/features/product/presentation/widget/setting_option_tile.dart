import 'package:ecomerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class SettingOptionTile extends StatelessWidget {
  final String title;
  final Widget child;
  const SettingOptionTile(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          child,
        ],
      ),
    );
  }
}
