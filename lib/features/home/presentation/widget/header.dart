import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/core/config/assets/app_images.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/auth/domain/entity/user_entity.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/assets/app_vectors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _profileImage(state.user, context),
              _gender(state.user),
              _card(context)
            ],
          );
        }
        if (state is HomeError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _profileImage(UserEntity user, BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const Scaffold());
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: user.image.isEmpty
                    ? const AssetImage(AppImages.profile)
                    : NetworkImage(user.image)),
            color: Colors.red,
            shape: BoxShape.circle),
      ),
    );
  }

  Widget _gender(UserEntity user) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Text(
          user.gender == 1 ? 'Men' : 'Women',
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const Scaffold());
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
            color: AppColors.primary, shape: BoxShape.circle),
        child: SvgPicture.asset(
          AppVectors.bag,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
