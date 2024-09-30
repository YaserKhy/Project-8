import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/user_screens/cart_screen.dart';
import 'package:project8/screens/user_screens/favorite_screen.dart';
import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
import 'package:project8/screens/user_screens/home/home_screen.dart';
import 'package:project8/screens/user_screens/orders_screen.dart';
import 'package:project8/screens/user_screens/profile_screen.dart';

class UserNavigation extends StatelessWidget {
  const UserNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc()..add(GetAllItemsEvent()),
          ),
          // BlocProvider(create: (context) => CartBloc()),
          // BlocProvider(create: (context) => FavoriteBloc()),
          // BlocProvider(create: (context) => OrdersBloc()),
          // BlocProvider(create: (context) => ProfileBloc()),
        ],
        child: BottomBar(
          barColor: AppConstants.mainBlue,
          width: context.getWidth(divideBy: 1.15),
          borderRadius: BorderRadius.circular(15),
          body: (context, controller) {
            return const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(), // HomeScreen can access HomeBloc
                CartScreen(), // CartScreen can access CartBloc
                FavoriteScreen(), // FavoriteScreen can access FavoriteBloc
                OrdersScreen(), // OrdersScreen can access OrdersBloc
                ProfileScreen(), // ProfileScreen can access ProfileBloc
              ],
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: TabBar(
              labelColor: AppConstants.mainWhite,
              unselectedLabelColor: AppConstants.unselectedColor,
              dividerColor: Colors.transparent,
              tabs: [
                FaIcon(FontAwesomeIcons.house),
                FaIcon(FontAwesomeIcons.cartShopping),
                FaIcon(FontAwesomeIcons.heart),
                FaIcon(FontAwesomeIcons.list),
                Icon(Icons.person),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
