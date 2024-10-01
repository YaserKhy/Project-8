import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  int activeStep = 0;
  OrderBloc() : super(OrderInitial()) {
    on<ChangeIndcatorEvent>((event, emit) {
      emit(ChangeIndcatorState());
    });
  }
}
