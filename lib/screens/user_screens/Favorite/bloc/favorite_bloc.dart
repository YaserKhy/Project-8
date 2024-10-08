import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/models/item_model.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<GetFavItemsEvent>(getFavItems);
    on<ToggleFavoriteEvent>(toggleFavorite);
  }

  // function to add/delete from/to favorites
  FutureOr<void> toggleFavorite(event, emit) async {
    if (GetIt.I.get<ItemLayer>().favItems.map((item) => item.itemId).contains(event.item.itemId)) {
      await GetIt.I.get<SupabaseLayer>().deleteFromFav(itemId: event.item.itemId);
      await GetIt.I.get<SupabaseLayer>().getFav();
    }
    else {
      await GetIt.I.get<SupabaseLayer>().addToFav(itemId: event.item.itemId);
      await GetIt.I.get<SupabaseLayer>().getFav();
    }
    emit(SuccessState());
  }

  // function to get favorites
  FutureOr<void> getFavItems(event, emit) async {
    try {
      emit(LoadingState());
      await GetIt.I.get<SupabaseLayer>().getFav();
      emit(SuccessState());
    } catch (error) {
      emit(ErrorState(msg: error.toString()));
    }
  }
}
