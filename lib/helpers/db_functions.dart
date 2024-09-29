import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

getAllItems() async {
  final itemsAsMap = await Supabase.instance.client.from("item").select();
  GetIt.I.get<ItemLayer>().items = itemsAsMap.map((item) {
    ItemModel newItem = ItemModel.fromJson(item);
    return newItem;
  }).toList();
}
