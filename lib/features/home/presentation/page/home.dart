import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecomerce/features/home/presentation/widget/categories.dart';
import 'package:ecomerce/features/home/presentation/widget/categories_header.dart';
import 'package:ecomerce/features/home/presentation/widget/header.dart';
import 'package:ecomerce/features/home/presentation/widget/search.dart';
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
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Header(),
            ),
            SearchField(),
            SizedBox(
              height: 10,
            ),
            CategoriesHeader(
              text: "Categories",
            ),
            SizedBox(
              height: 10,
            ),
            Categories(),
            SizedBox(
              height: 10,
            ),
            CategoriesHeader(
              text: "Top Selling",
            ),
            TopSelling(),
            CategoriesHeader(
              text: 'New In',
              color: AppColors.primary,
            ),
            TopSelling(),
          ],
        ),
      ),
    );
  }
}
