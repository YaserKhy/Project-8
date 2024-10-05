import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

sendNotification({required String? extrnalId}) async {
  var url = Uri.parse('https://api.onesignal.com/notifications?c=push');

  try {
    await http.post(url,
        body: jsonEncode({
          "app_id": dotenv.env['ONE_SIGNAL_APP_ID'],
          "contents": {"en": "Your order is ready to pick"},
          "target_channel": "push",
          "include_aliases": {
            "external_id": [extrnalId]
          }
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic ${dotenv.env['ONE_SIGNAL_KEY']}"
        });
  } catch (e) {
    return e;
  }
}
