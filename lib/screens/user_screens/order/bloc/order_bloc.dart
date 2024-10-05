import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/supabase_layer.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  int activeStep = 0;
  Map<String,dynamic> itemAndPrice = {};
  OrderBloc() : super(OrderInitial()) {
    on<ChangeIndcatorEvent>((event, emit) {
      emit(ChangeIndcatorState());
    });

    on<GetOrdersEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await GetIt.I.get<SupabaseLayer>().getOrders();
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
