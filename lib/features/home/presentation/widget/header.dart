import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/core/config/assets/app_images.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
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
        if (state is HomeDataLoaded) {
          // Show loading indicator if user is loading
          if (state.isLoadingUser && state.user == null) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          // Show error if there's a user error
          if (state.userError != null) {
            return Center(
              child: Text(
                state.userError!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Show user data if available
          if (state.user != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppNavigator.push(context, const Scaffold());
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: state.user!.image.isEmpty
                                ? const AssetImage(AppImages.profile)
                                : NetworkImage(state.user!.image)),
                        color: Colors.red,
                        shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColors.secondBackground,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      state.user!.gender == 1 ? 'Men' : 'Women',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
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
                )
              ],
            );
          }
        }

        // Handle legacy states for backwards compatibility
        if (state is HomeLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HomeLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  AppNavigator.push(context, const Scaffold());
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: state.user.image.isEmpty
                              ? const AssetImage(AppImages.profile)
                              : NetworkImage(state.user.image)),
                      color: Colors.red,
                      shape: BoxShape.circle),
                ),
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    state.user.gender == 1 ? 'Men' : 'Women',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
              GestureDetector(
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
              )
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
}
