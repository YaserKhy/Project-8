// helper functions here
import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/models/item_model.dart';

Map<String, List<ItemModel>> groupItemsByCategory(List<ItemModel> items) {
  Map<String, List<ItemModel>> groupedItems = {};
  for (var item in items) {
    if (!groupedItems.containsKey(item.category)) {
      groupedItems[item.category] = [];
    }
    groupedItems[item.category]!.add(item);
  }
  return groupedItems;
}

List<ItemModel> getBestSellers() {
  final bestSellers = GetIt.I.get<ItemLayer>().items;
  return bestSellers..take(4).toList();
}

getMatchingCartItems() async {
  await GetIt.I.get<SupabaseLayer>().getCartItems();
  GetIt.I.get<ItemLayer>().matchingCartItems =
      GetIt.I.get<ItemLayer>().cartItems.where((cartItem) {
    return GetIt.I
        .get<ItemLayer>()
        .items
        .any((item) => item.itemId == cartItem.itemId);
  }).toList();
}
