import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:http/http.dart' as http;
sendNotification() async {
  var url = Uri.parse('https://api.onesignal.com/notifications?c=push');
  final String? extrnalId = GetIt.I.get<AuthLayer>().customer?.notificationId;
  try {
    await http.post(url,
        body: jsonEncode({
          "app_id": "31059eb9-e7cf-432e-870e-2d99883fa36b",
          "contents": {
            "en": "Yor orrder is ready to pick",
          },
          "target_channel": "push",
          "include_aliases": {
            "external_id": [extrnalId]
          }
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic YzE5NjEwZmMtY2IwMC00YjVhLTliOWEtOWMyNTE4ZGE5MmMy"
        });
  } catch (e) {
    print(e.toString());
  }
}