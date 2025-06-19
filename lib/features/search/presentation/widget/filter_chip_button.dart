import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class FilterChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool hasDropdown;

  const FilterChipButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.hasDropdown = false,
  }) : super(key: key);

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down,
                  color: Colors.white, size: 16),
            ]
          ],
        ),
      ),
    );
  }
}
