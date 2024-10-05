import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:project8/screens/splash_screen/splash_screen.dart';
import 'package:project8/services/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['ONE_SIGNAL_APP_ID']!);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineSmall:TextStyle(fontFamily: 'Average', fontSize: 16),
          headlineMedium:TextStyle(fontFamily: 'Average', fontSize: 18),
          
          bodyMedium: TextStyle(fontFamily: "Average", fontSize: 20),
          bodyLarge: TextStyle(fontFamily: "Average", fontSize: 26),

          titleSmall: TextStyle(fontFamily: "Average", fontSize: 14),
          titleMedium: TextStyle(fontFamily: "Average", fontSize: 17, overflow: TextOverflow.ellipsis),
          titleLarge: TextStyle(fontFamily: "Average", fontSize: 22)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
