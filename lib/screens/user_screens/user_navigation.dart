import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/user_screens/cart_screen.dart';
import 'package:project8/screens/user_screens/favorite_screen.dart';
import 'package:project8/screens/user_screens/home_screen.dart';
import 'package:project8/screens/user_screens/orders_screen.dart';
import 'package:project8/screens/user_screens/profile_screen.dart';

class UserNavigation extends StatelessWidget {
  const UserNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: BottomBar(
        barColor: AppConstants.mainBlue,
        width: context.getWidth(divideBy: 1.15),
        borderRadius: BorderRadius.circular(15),
        // hideOnScroll: false,
        body: (context, controller) {
          return const TabBarView(
            children: [
              HomeScreen(),
              CartScreen(),
              FavoriteScreen(),
              OrdersScreen(),
              ProfileScreen()
            ]
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: TabBar(
            labelColor: AppConstants.mainWhite,
            unselectedLabelColor: AppConstants.unselectedColor,
            dividerColor: Colors.transparent,
            tabs: [
              // to be modified later << NOTICE >>
              FaIcon(FontAwesomeIcons.house),
              FaIcon(FontAwesomeIcons.cartShopping),
              FaIcon(FontAwesomeIcons.heart),
              FaIcon(FontAwesomeIcons.list),
              Icon(Icons.person),
            ]
          ),
        )
      ),
    );
  }
}