import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final favList = GetIt.I.get<ItemLayer>().favItems;

  FavoriteBloc() : super(FavoriteInitial()) {
    on<AddToFavEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await GetIt.I.get<SupabaseLayer>().addToFav(itemId: event.itemId);
        await GetIt.I.get<SupabaseLayer>().getFav();
        final favList = GetIt.I.get<ItemLayer>().favItems;
        emit(SuccessState(favList: favList));
      } catch (error) {
        emit(ErrorState(msg: error.toString()));
      }
    });

    on<GetFavItemsEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await GetIt.I.get<SupabaseLayer>().getFav();
        final favList = GetIt.I.get<ItemLayer>().favItems;
        emit(SuccessState(favList: favList));
      } catch (error) {
        emit(ErrorState(msg: error.toString()));
      }
    });
  }
}
