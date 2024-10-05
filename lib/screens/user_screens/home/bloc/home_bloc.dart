import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/helpers/db_functions.dart';
import 'package:project8/helpers/helper.dart';
import 'package:project8/models/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ItemModel> favorites = [];
  HomeBloc() : super(HomeInitial()) {
    on<GetAllItemsEvent>(getItems);
    on<ChangeCategoryEvent>(changeCategory);
  }

  // function to get all ONZE items
  FutureOr<void> getItems(GetAllItemsEvent event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingState());
      await getAllItems();
      await GetIt.I.get<SupabaseLayer>().getFav();
      await GetIt.I.get<SupabaseLayer>().getCartItems();
      getMatchingCartItems();
      emit(SuccessState(selectedCategory: "All"));
    } catch (error) {
      emit(ErrorState(msg: error.toString()));
    }
  }

  // function to switch category
  FutureOr<void> changeCategory(ChangeCategoryEvent event, Emitter<HomeState> emit) {
    emit(SuccessState(selectedCategory: event.category));
  }
}