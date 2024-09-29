import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project8/helpers/db_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetAllItemsEvent>(getItems);
    on<ChangeCategoryEvent>(ChangeCategory);
  }

  FutureOr<void> getItems(
      GetAllItemsEvent event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingState());
      await getAllItems();
      emit(SuccessState(selectedCategory: "All"));
    } catch (error) {
      emit(ErrorState(msg: error.toString()));
    }
  }

  FutureOr<void> ChangeCategory(
      ChangeCategoryEvent event, Emitter<HomeState> emit) {
    emit(SuccessState(selectedCategory: event.category));
  }
}
