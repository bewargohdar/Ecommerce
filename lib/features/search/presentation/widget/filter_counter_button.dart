import 'package:ecomerce/config/assets/app_vectors.dart';
import 'package:ecomerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterCounterButton extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  final bool isSelected;

  const FilterCounterButton({
    super.key,
    required this.count,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondBackground,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppVectors.filterActive,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 14,
            ),
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
