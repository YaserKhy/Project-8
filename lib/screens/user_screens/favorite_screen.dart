import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/widgets/other/page_title.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PageTitle(title: "Favorites")
            ],
          ),
        ),
      ),
    );
  }
}