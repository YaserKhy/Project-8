import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/widgets/other/title_logo.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBlue,
      body: Column(children: [
        const SizedBox(
          height: 74,
        ),
        const TitleLogo(),
        SizedBox(
          height: 50,
        ),
        Image.asset('assets/images/welcome_words.png'),

          SizedBox(
            height: 200,  // Adjust height based on your GIF size
            child: Image.asset('assets/images/splachingif.gif'),




          ),
      ]),
    );
  }
}
