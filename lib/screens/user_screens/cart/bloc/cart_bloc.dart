import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetAllCartItemsEvent>(getAllCartItems);
    on<PayEvent>(addOrder);
  }

  Future<void> addOrder(PayEvent event, Emitter<CartState> emit) async {
    try {
      log('adding order');
      emit(LoadingState());
      await GetIt.I.get<SupabaseLayer>().addOrder(cartId: event.cartId);
      emit(SuccessState());
      log("done");
    } catch (e) {
      log(e.toString());
      emit(ErrorState(msg: e.toString()));
    }
  }

  Future<void> getAllCartItems(GetAllCartItemsEvent event, Emitter<CartState> emit) async {
    try {
      // log("from bloc1");
      emit(LoadingState());
      await GetIt.I.get<SupabaseLayer>().getCartItems();
      final cart = await GetIt.I.get<SupabaseLayer>().supabase.from('cart').select().match({'customer_id': GetIt.I.get<AuthLayer>().customer!.id, 'is_valid': true});
      // log(message)
      print("LOOOK $cart");
      CartModel currentCart = CartModel.fromJson(cart.first);
      emit(SuccessState(cart: currentCart));
      // log("from bloc2");
    } catch (e) {
      log("error in getallcartitems"+e.toString());
      emit(ErrorState(msg: e.toString()));
    }
  }
}
