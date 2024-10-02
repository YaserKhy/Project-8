import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/supabase_layer.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetAllCartItemsEvent>(getAllCartItems);
  }

  Future<void> getAllCartItems(
      GetAllCartItemsEvent event, Emitter<CartState> emit) async {
    try {
      log("from bloc1");
      emit(LoadingState());
      await GetIt.I.get<SupabaseLayer>().getCartItems();
      emit(SuccessState());
      log("from bloc2");
    } catch (e) {
      log(e.toString());
      emit(ErrorState(msg: e.toString()));
    }
  }
}
