import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;
  final Color? color;
  final double? radius;
  const BasicAppButton(
      {required this.onPressed,
      this.title = '',
      this.height,
      this.width,
      this.content,
      this.color,
      this.radius,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          minimumSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
        ),
        child: content ??
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400),
            ));
  }
}
