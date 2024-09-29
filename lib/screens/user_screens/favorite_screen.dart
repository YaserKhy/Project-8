import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/widgets/cards/favorites_item_card.dart';
import 'package:project8/widgets/other/page_title.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageTitle(title: "Favorites"),
              const SizedBox(
                height: 30,
              ),
              FavoritesCard(
                itemImage: Image.asset("assets/images/default_profile_img.png"),
                name: "Cortado",
                price: "20",
                cal: "20",
              ),
              const SizedBox(
                height: 20,
              ),
              FavoritesCard(
                itemImage: Image.asset("assets/images/default_profile_img.png"),
                name: "V60",
                price: "22",
                cal: "4",
              )
            ],
          ),
        ),
      ),
    );
  }
}
