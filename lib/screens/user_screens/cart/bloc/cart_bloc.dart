import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/helpers/helper.dart';
import 'package:project8/models/cart_model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  bool isDelivery = false;
  TextEditingController addressController = TextEditingController();
  CartBloc() : super(CartInitial()) {
    on<GetAllCartItemsEvent>(getAllCartItems);
    on<PayEvent>(addOrder);
    on<ToggleDeliveryEvent>(toggleDelivery);
  }

  // function to switch how customer recieve order
  toggleDelivery(ToggleDeliveryEvent event, Emitter<CartState> emit) async {
    isDelivery=!isDelivery;
    emit(ToggleDeliveryState(isDelivery: isDelivery));
  }

  // function to close cart & add order
  Future<void> addOrder(PayEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingState());
      await GetIt.I.get<SupabaseLayer>().addOrder(
        cartId: event.cartId,
        paymentMethod: event.paymentMethod,
        pickupOrDelivery: event.pickupOrDelivery,
        address: addressController.text.isEmpty ? 'pickup' : addressController.text,
        estimatedTime: event.estimatedTime
      );
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  // function to get all items of specific cart
  Future<void> getAllCartItems(GetAllCartItemsEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingState());
      await GetIt.I.get<SupabaseLayer>().getCartItems();
      var cart = await GetIt.I.get<SupabaseLayer>().supabase.from('cart').select().match({'customer_id': GetIt.I.get<AuthLayer>().customer!.id, 'is_valid': true});
      if(cart.isEmpty) {
        await GetIt.I.get<SupabaseLayer>().supabase.from('cart').insert({
          'customer_id': GetIt.I.get<AuthLayer>().customer!.id,
          'total_price': 0,
          'is_valid' : true
        });
      }
      cart = await GetIt.I.get<SupabaseLayer>().supabase.from('cart').select().match({'customer_id': GetIt.I.get<AuthLayer>().customer!.id, 'is_valid': true});
      await getMatchingCartItems();
      GetIt.I.get<ItemLayer>().currentCart = CartModel.fromJson(cart.first);
      emit(SuccessState(cart: GetIt.I.get<ItemLayer>().currentCart));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }
}