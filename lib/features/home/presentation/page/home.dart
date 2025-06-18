import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/common/widget/search.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecomerce/features/home/presentation/widget/categories.dart';
import 'package:ecomerce/features/home/presentation/widget/categories_header.dart';
import 'package:ecomerce/features/home/presentation/widget/header.dart';
import 'package:ecomerce/features/search/presentation/page/search_page.dart';

import 'package:ecomerce/features/home/presentation/widget/top_selling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(FetchUserInfo());
    context.read<HomeBloc>().add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Header(),
            ),
            SearchField(
              readOnly: true,
              onTap: () {
                AppNavigator.push(context, const SearchPage());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const CategoriesHeader(
              text: "Categories",
            ),
            const SizedBox(
              height: 10,
            ),
            const Categories(),
            const SizedBox(
              height: 10,
            ),
            const CategoriesHeader(
              text: "Top Selling",
            ),
            const TopSelling(),
            const CategoriesHeader(
              text: 'New In',
              color: AppColors.primary,
            ),
            const TopSelling(),
          ],
        ),
      ),
    );
  }
}
