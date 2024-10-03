import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/models/item_model.dart';

part 'view_item_event.dart';
part 'view_item_state.dart';

class ViewItemBloc extends Bloc<ViewItemEvent, ViewItemState> {
  int quantity = 1;
  ViewItemBloc() : super(ViewItemInitial()) {
    on<IncreaseQuantityEvent>(increaseQuantity);
    on<DecreaseQuantityEvent>(decreaseQuantity);
  }

  FutureOr<void> increaseQuantity(
      IncreaseQuantityEvent event, Emitter<ViewItemState> emit) {
    quantity = event.quantity + 1;
    emit(UpdateQuantityState(quantity: quantity));
  }

  FutureOr<void> decreaseQuantity(
      DecreaseQuantityEvent event, Emitter<ViewItemState> emit) {
    quantity = event.quantity - 1;
    emit(UpdateQuantityState(quantity: quantity));
  }
}
