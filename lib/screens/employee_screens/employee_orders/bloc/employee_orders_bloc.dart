
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
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
        emit(LoadingState());
        await GetIt.I.get<SupabaseLayer>().employeeGetOrders();
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
    on<ChangeStatusEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await GetIt.I.get<SupabaseLayer>().employeeGetOrders();
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
