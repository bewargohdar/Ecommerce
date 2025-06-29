import 'package:ecomerce/core/config/assets/app_vectors.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/cart/presentation/page/cart_page.dart';
import 'package:ecomerce/features/category/presentation/screen/category.dart';
import 'package:ecomerce/features/home/presentation/page/home.dart';
import 'package:ecomerce/features/profile/presentation/page/profile_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 67,
          child: ColoredBox(
            color: AppColors.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: tabs.map((tab) => _TabItem(tab: tab)).toList(),
            ),
          ),
        ),
        body: pages[activeTab],
      ),
    );
  }

  List<Widget> get pages => <Widget>[
        const HomePage(),
        const CategoryPage(),
        const CartPage(),
        const ProfilePage(),
      ];

  List<_TabItemConst> get tabs => <_TabItemConst>[
        _TabItemConst(
          icon: AppVectors.home,
          isActive: activeTab == 0,
          onTap: () => setState(() => activeTab = 0),
        ),
        _TabItemConst(
          icon: AppVectors.notification,
          isActive: activeTab == 1,
          onTap: () => setState(() => activeTab = 1),
        ),
        _TabItemConst(
          icon: AppVectors.cart,
          isActive: activeTab == 2,
          onTap: () => setState(() => activeTab = 2),
        ),
        _TabItemConst(
          icon: AppVectors.profile,
          isActive: activeTab == 3,
          onTap: () => setState(() => activeTab = 3),
        ),
      ];
}

class _TabItem extends StatelessWidget {
  const _TabItem({required this.tab});

  final _TabItemConst tab;

  @override
  Widget build(BuildContext context) {
    final color = tab.isActive ? AppColors.primary : Colors.grey;
    return InkWell(
      onTap: tab.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            tab.icon,
            height: 24,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _TabItemConst {
  const _TabItemConst({
    required this.icon,
    required this.isActive,
    this.onTap,
  });

  final String icon;
  final bool isActive;
  final Function()? onTap;
}
