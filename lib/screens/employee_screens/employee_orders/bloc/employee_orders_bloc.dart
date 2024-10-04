import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';

part 'employee_orders_event.dart';
part 'employee_orders_state.dart';

class EmployeeOrdersBloc
    extends Bloc<EmployeeOrdersEvent, EmployeeOrdersState> {
  int activeStep = 0;
  Map<String, dynamic> itemAndPrice = {};
  EmployeeOrdersBloc() : super(EmployeeOrdersInitial()) {
    on<ChangeIndcatorEvent>((event, emit) {
      emit(ChangeIndcatorState());
    });

    on<GetOrdersEvent>((event, emit) async {
      try {
        log("getting orders");
        emit(LoadingState());
        await GetIt.I.get<SupabaseLayer>().employeeGetOrders();
        emit(SuccessState());
        log('doeneenen');
        log(GetIt.I.get<ItemLayer>().orders.length.toString());
      } catch (e) {
        log("get orders error");
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
