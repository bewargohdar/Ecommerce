import 'package:flutter/material.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  const CustomBackButton({
    Key? key,
    this.onPressed,
    this.size = 50,
    this.backgroundColor = AppColors.secondBackground,
    this.iconColor = Colors.white,
    this.icon = Icons.arrow_back_ios_new,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        icon: Icon(icon, size: size * 0.3, color: iconColor),
        padding: EdgeInsets.zero,
        splashRadius: size * 0.4,
      ),
    );
  }
}
