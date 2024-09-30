import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
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

  Future login({required String email, required String password}) async {
    try {
      log("entered");
      final AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password);
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
      required String phoneNumber}) async {
    try {
      log("otp verify");
      final AuthResponse response = await supabase.auth
          .verifyOTP(email: email, token: otp, type: OtpType.email);
      final id = response.user!.id;
      CustomerModel customer = CustomerModel.fromJson({
        'customer_id': id,
        'email': email,
        'name': name,
        'phone_number': phoneNumber
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
    await GetIt.I.get<SupabaseLayer>().supabase.rpc(
      'fav_item',
      params: {
        'item_id': itemId,
        'customer_id': GetIt.I.get<AuthLayer>().customer?.id
      }
    );
  }

  getFav() async {
    final List<ItemModel> favList = [];
    final List data = await supabase.rpc("get_fav", params: {"id": GetIt.I.get<AuthLayer>().customer?.id});
    for (Map<String, dynamic> element in data) {
      favList.add(ItemModel.fromJson(element));
    }

    GetIt.I.get<ItemLayer>().favItems = favList;

    log(favList.toString());
  }
}
