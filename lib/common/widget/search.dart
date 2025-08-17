import 'package:ecomerce/config/assets/app_vectors.dart';
import 'package:ecomerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffixIcon;

  const SearchField({
    super.key,
    this.controller,
    this.readOnly = false,
    this.autofocus = false,
    this.onTap,
    this.onSubmitted,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Define the border style once to reuse it
    final OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0), // Your desired radius
      borderSide: const BorderSide(
        color: AppColors.secondBackground,
      ), // Default border color and width
    );

    final OutlineInputBorder focusedRoundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0), // Your desired radius
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 1.5,
      ), // Border color and width when focused
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        autofocus: autofocus,
        onTap: onTap,
        onSubmitted: onSubmitted,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          filled: true,
          fillColor: AppColors.secondBackground,
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.white70),
          border: roundedBorder,
          enabledBorder: roundedBorder,
          focusedBorder:
              focusedRoundedBorder, // You already had this, can customize color/width
          prefixIcon: SvgPicture.asset(
            AppVectors.search,
            fit: BoxFit.none,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
