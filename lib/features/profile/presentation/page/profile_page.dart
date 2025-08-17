import 'package:ecomerce/config/theme/app_color.dart';
import 'package:ecomerce/features/profile/domain/entity/user.dart';
import 'package:ecomerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecomerce/features/profile/presentation/widgets/profile_menu_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.background,
      body: BlocSelector<ProfileBloc, ProfileState, UserEntity?>(
        selector: (state) => state.currentUser,
        builder: (context, currentUser) {
          if (currentUser == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3D58),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: currentUser.image.isNotEmpty
                            ? NetworkImage(currentUser.image)
                            : null,
                        child: currentUser.image.isEmpty
                            ? const Icon(Icons.person,
                                size: 30, color: Colors.white)
                            : null,
                      ),
                      // Reduced spacing
                      const SizedBox(width: 12),
                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${currentUser.firstName} ${currentUser.lastName}',
                              style: const TextStyle(
                                // Reduced font size
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            // Reduced spacing
                            const SizedBox(height: 2),
                            Text(
                              currentUser.email,
                              style: const TextStyle(
                                // Reduced font size
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            // Reduced spacing
                            const SizedBox(height: 2),
                            Text(
                              currentUser.phone,
                              style: const TextStyle(
                                // Reduced font size
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Edit Button
                      BlocSelector<ProfileBloc, ProfileState, bool>(
                        selector: (state) => state.isEditing,
                        builder: (context, isEditing) {
                          return TextButton(
                            onPressed: () {
                              context.read<ProfileBloc>().add(
                                    const ToggleEditModeEvent(),
                                  );
                            },
                            child: Text(
                              isEditing ? 'Save' : 'Edit',
                              style: const TextStyle(
                                color: AppColors.primary,
                                // Reduced font size
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Reduced spacing
                const SizedBox(height: 16),
                // Menu Options
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ProfileMenuItem(
                        icon: Icons.location_on,
                        title: 'Address',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Navigate to Address')),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.favorite,
                        title: 'Wishlist',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Navigate to Wishlist')),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.payment,
                        title: 'Payment',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Navigate to Payment')),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.help,
                        title: 'Help',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Navigate to Help')),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.support,
                        title: 'Support',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Navigate to Support')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Sign Out Button
                Container(
                  color: AppColors.background,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(
                            const SignOutEvent(),
                          );
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.red,
                        // Reduced font size
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      // Reduced margin
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        tileColor: const Color(0xFF3A3D58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Icon(
          icon,
          color: Colors.white,
          // Reduced icon size
          size: 20,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            // Reduced font size
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          // Reduced icon size
          size: 14,
        ),
      ),
    );
  }
}
