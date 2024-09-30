import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/helpers/db_functions.dart';
import 'package:project8/models/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ItemModel> favorites = [];
  HomeBloc() : super(HomeInitial()) {
    on<GetAllItemsEvent>(getItems);
    on<ChangeCategoryEvent>(changeCategory);
    on<ToggleFavoriteEvent>(toggleFavorite);
  }

  FutureOr<void> getItems(
      GetAllItemsEvent event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingState());
      // Fetch items and assign them to the allItems list
      await getAllItems();
      GetIt.I.get<ItemLayer>().items; // Assuming this returns a list of items
      emit(SuccessState(
          selectedCategory: "All",
          items: GetIt.I.get<ItemLayer>().items,
          favorites: favorites));
      print(GetIt.I.get<ItemLayer>().items.length);
    } catch (error) {
      emit(ErrorState(msg: error.toString()));
    }
  }

  FutureOr<void> changeCategory(
      ChangeCategoryEvent event, Emitter<HomeState> emit) {
    if (state is SuccessState) {
      final successState = state as SuccessState;
      emit(SuccessState(
        selectedCategory: event.category,
        items: successState.items,
        favorites: favorites,
      ));
    }
  }

  Future<void> toggleFavorite(
      ToggleFavoriteEvent event, Emitter<HomeState> emit) async {
    if (favorites.contains(event.item)) {
      
      favorites.remove(event.item);
    } else {
      await GetIt.I.get<SupabaseLayer>().supabase.rpc('fav_item', params: {
        'item_id': event.item.itemId,
        'customer_id': GetIt.I.get<AuthLayer>().customer?.id
      });
      favorites.add(event.item);
    }
    if (state is SuccessState) {
      final successState = state as SuccessState;
      emit(SuccessState(
        selectedCategory: successState.selectedCategory,
        items: successState.items,
        favorites: favorites,
      ));
    }
  }
}
