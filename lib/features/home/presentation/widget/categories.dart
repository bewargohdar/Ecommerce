import 'package:ecomerce/core/config/assets/app_images.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (contetx, index) {
          return Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(AppImages.profile))),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("text",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
      ),
    );
  }
}
