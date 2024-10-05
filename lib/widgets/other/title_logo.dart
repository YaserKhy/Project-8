import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';

class TitleLogo extends StatelessWidget {
  const TitleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 28),
                Container(
                  width: 137,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: AppConstants.mainRed,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                    )
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/logo_title1.png', width: context.getWidth(), height: 100),
          ],
        ),
      ],
    );
  }
}