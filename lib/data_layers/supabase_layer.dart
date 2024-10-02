import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/models/cart_item_model.dart';
import 'package:project8/models/customer_model.dart';
import 'package:project8/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLayer {
  final supabase = Supabase.instance.client;

  Future createAccount(
      {required String email, required String password}) async {
    try {
      log("entered");
      final AuthResponse response =
          await supabase.auth.signUp(email: email, password: password);
      log("finished");
      return response;
    } catch (e) {
      log(e.toString());
      return e;
    }
  }

  Future login(
      {required String email,
      required String password,
      required String externalId}) async {
    try {
      log("entered");
      final AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password);

      OneSignal.login(externalId);
      await supabase
          .from('customer')
          .update({'notification_id': externalId}).eq('customer_id', response.user!.id);

      final temp = await supabase
          .from('customer')
          .select()
          .eq('customer_id', response.user!.id);
      GetIt.I.get<AuthLayer>().customer = CustomerModel.fromJson(temp.first);
      GetIt.I
          .get<AuthLayer>()
          .box
          .write('customer', GetIt.I.get<AuthLayer>().customer);
      log("finished");
      return response;
    } catch (e) {
      log(e.toString());
      return e;
    }
  }

  Future verifyOtp(
      {required String email,
      required String otp,
      required String name,
      required String phoneNumber,
      required String externalId}) async {
    try {
      log("otp verify");
      final AuthResponse response = await supabase.auth
          .verifyOTP(email: email, token: otp, type: OtpType.email);
      final id = response.user!.id;
      OneSignal.Notifications.requestPermission(true);
      OneSignal.login(externalId);
      CustomerModel customer = CustomerModel.fromJson({
        'customer_id': id,
        'email': email,
        'name': name,
        'phone_number': phoneNumber,
        'notification_id': externalId
      });
      await supabase.from("customer").insert(customer.toJson());
      GetIt.I.get<AuthLayer>().box.write('customer', customer.toJson());
      GetIt.I.get<AuthLayer>().customer = customer;
      log("finished adding customer to box");
      return response;
    } catch (e) {
      log(e.toString());
      return e;
    }
  }

  addToFav({required String itemId}) async {
    await GetIt.I.get<SupabaseLayer>().supabase.rpc('fav_item', params: {
      'item_id': itemId,
      'customer_id': GetIt.I.get<AuthLayer>().customer?.id
    });
  }

  deleteFromFav({required String itemId}) async {
    log("deleting from fav");
    log(itemId);
    log(GetIt.I.get<AuthLayer>().customer!.id.toString());
    // await GetIt.I.get<SupabaseLayer>().supabase.rpc('unfav', params: {
    //   'item_id': itemId,
    //   'customer_id': GetIt.I.get<AuthLayer>().customer?.id
    // });
    await GetIt.I
        .get<SupabaseLayer>()
        .supabase
        .from('favorite')
        .delete()
        .match({
      'item_id': itemId,
      'customer_id': GetIt.I.get<AuthLayer>().customer!.id
    });
  }

  getFav() async {
    final List<ItemModel> favList = [];
    final List data = await supabase
        .rpc("get_fav", params: {"id": GetIt.I.get<AuthLayer>().customer?.id});
    for (Map<String, dynamic> element in data) {
      favList.add(ItemModel.fromJson(element));
    }

    GetIt.I.get<ItemLayer>().favItems = favList;

    log(favList.toString());
  }

  getCartItems() async {
    log("from supabase layer");

    final List<CartItemModel> cartItems = [];
    final List data = await supabase.from("cart_item").select();
    print(data);
    for (Map<String, dynamic> element in data) {
      cartItems.add(CartItemModel.fromJson(element));
    }
    log("from supabase layer");
    GetIt.I.get<ItemLayer>().cartItems = cartItems;
    log(cartItems.toString());
  }
}
