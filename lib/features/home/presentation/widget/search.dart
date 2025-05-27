import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/core/config/assets/app_vectors.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the border style once to reuse it
    final OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0), // Your desired radius
      borderSide: const BorderSide(
        color: AppColors.background,
      ), // Default border color and width
    );

    final OutlineInputBorder focusedRoundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0), // Your desired radius
      borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0), // Border color and width when focused
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        readOnly: true,
        onTap: () {
          AppNavigator.push(context,
              const Scaffold(body: Center(child: Text("Search Page"))));
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          border: roundedBorder,
          enabledBorder: roundedBorder,

          focusedBorder:
              focusedRoundedBorder, // You already had this, can customize color/width
          prefixIcon: SvgPicture.asset(
            AppVectors.search,
            fit: BoxFit.none,
          ),
          hintText: 'search',
        ),
      ),
    );
  }
}
