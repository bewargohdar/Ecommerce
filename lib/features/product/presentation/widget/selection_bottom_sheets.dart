import 'package:ecomerce/common/helper/appbottomsheet/app_bottom_sheet.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:flutter/material.dart';

void showSizeSelectionSheet(
  BuildContext context, {
  required SizeOption currentSize,
  required Function(SizeOption) onSizeSelected,
}) {
  showAppModalBottomSheet(
    context: context,
    title: 'Size',
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter modalSetState) {
        return Column(
          children: SizeOption.values.map((size) {
            bool isSelected = currentSize == size;
            return GestureDetector(
              onTap: () {
                onSizeSelected(size);
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.primary : const Color(0xFF353535),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      size.toString().split('.').last,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    if (isSelected)
                      const Icon(Icons.check, color: Colors.white),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    ),
  );
}

void showColorSelectionSheet(
  BuildContext context, {
  required List<Color> availableColors,
  required Color currentColor,
  required Function(Color) onColorSelected,
}) {
  showAppModalBottomSheet(
    context: context,
    title: 'Color',
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter modalSetState) {
        return Wrap(
          spacing: 20,
          runSpacing: 15,
          children: availableColors.map((color) {
            bool isSelected = currentColor == color;
            return GestureDetector(
              onTap: () {
                onColorSelected(color);
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: AppColors.primary, width: 3)
                      : null,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 22)
                    : null,
              ),
            );
          }).toList(),
        );
      },
    ),
  );
}
