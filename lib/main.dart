import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:project8/screens/navigation/user_navigation.dart';
import 'package:project8/screens/splach_screen/splach_screen.dart';
import 'package:project8/services/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("31059eb9-e7cf-432e-870e-2d99883fa36b");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplachScreen(),
      // debugShowCheckedModeBanner: false,
      // home: GetIt.I.get<AuthLayer>().box.hasData("customer")
      //     ? const UserNavigation()
      //     : const LoginScreen()
    );
  }
}
