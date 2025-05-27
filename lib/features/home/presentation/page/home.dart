import 'package:ecomerce/core/config/assets/app_images.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecomerce/features/home/presentation/widget/categories.dart';
import 'package:ecomerce/features/home/presentation/widget/categories_header.dart';
import 'package:ecomerce/features/home/presentation/widget/header.dart';
import 'package:ecomerce/features/home/presentation/widget/search.dart';
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
    // Fetch user info only when home page is loaded
    context.read<HomeBloc>().add(FetchUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CategoriesHeader(),
            SizedBox(
              height: 10,
            ),
            Categories(),
          ],
        ),
      ),
    );
  }
}
