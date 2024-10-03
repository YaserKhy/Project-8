import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:project8/screens/splach_screen/splach_screen.dart';
import 'package:project8/services/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['ONE_SIGNAL']!);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
            headlineSmall:TextStyle(
            fontFamily: 'Average', fontSize: 17, fontWeight: FontWeight.w500) ,
        headlineLarge: TextStyle(
            fontFamily: 'Average', fontSize: 26, fontWeight: FontWeight.w500),
      )),
      debugShowCheckedModeBanner: false,
      home: const SplachScreen(),
      // home: GetIt.I.get<AuthLayer>().box.hasData("customer")
      //     ? const UserNavigation()
      //     : const LoginScreen()
    );
  }
}
