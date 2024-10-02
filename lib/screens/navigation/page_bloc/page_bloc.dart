import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:project8/screens/user_screens/cart/cart_screen.dart';
import 'package:project8/screens/user_screens/Favorite/favorite_screen.dart';
import 'package:project8/screens/user_screens/home/home_screen.dart';
import 'package:project8/screens/user_screens/order/orders_screen.dart';
import 'package:project8/screens/user_screens/profile_screen.dart';
part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  final List<Widget> pages = [const HomeScreen(), const CartScreen(), const FavoriteScreen(), const OrdersScreen(), const ProfileScreen()];
  int currentPage = 0;
  PageBloc() : super(PageInitial()) {
    on<ChangePageEvent>((event, emit) {
      currentPage = event.index;
      emit(ShowState(index: event.index));
    });
  }
}
