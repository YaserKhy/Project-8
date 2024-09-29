import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project8/helpers/db_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetAllItemsEvent>(getItems);
  }

  FutureOr<void> getItems(GetAllItemsEvent event, Emitter<HomeState> emit) {
    try {
      emit(LoadingState());
      getAllItems();
      emit(SuccessState());
    } catch (error) {
      emit(ErrorState(msg: error.toString()));
    }
  }
}
