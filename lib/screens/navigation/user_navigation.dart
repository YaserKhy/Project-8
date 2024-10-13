import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/user_screens/Favorite/bloc/favorite_bloc.dart';
import 'package:project8/screens/user_screens/Favorite/favorite_screen.dart';
import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
import 'package:project8/screens/user_screens/home/home_screen.dart';
import 'package:project8/screens/user_screens/order/bloc/order_bloc.dart';
import 'package:project8/screens/user_screens/order/orders_screen.dart';
import 'package:project8/screens/user_screens/profile_screen.dart';
import 'package:hugeicons/hugeicons.dart';

class UserNavigation extends StatelessWidget {
  const UserNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()..add(GetAllItemsEvent()),),
          BlocProvider(create: (context) => FavoriteBloc()..add(GetFavItemsEvent())),
          BlocProvider(create: (context) => OrderBloc()..add(GetOrdersEvent())),
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
                FavoriteScreen(), // FavoriteScreen can access FavoriteBloc
                OrdersScreen(), // OrdersScreen can access OrdersBloc
                ProfileScreen(), // ProfileScreen can access ProfileBloc
              ],
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: TabBar(
              overlayColor: WidgetStateColor.transparent,
              indicatorColor: Colors.transparent,
              labelColor: AppConstants.mainWhite,
              unselectedLabelColor: AppConstants.unselectedColor,
              dividerColor: Colors.transparent,
              tabs: [
                FaIcon(HugeIcons.strokeRoundedHome09,),
                FaIcon(HugeIcons.strokeRoundedFavourite),
                FaIcon(HugeIcons.strokeRoundedLeftToRightListBullet),
                FaIcon(HugeIcons.strokeRoundedUser,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
