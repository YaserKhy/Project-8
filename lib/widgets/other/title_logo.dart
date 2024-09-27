import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

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
                const SizedBox(height: 16),
                Container(
                  width: 150,
                  height: 45,
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
            Image.asset('assets/images/logo_title1.png', width: 385, height: 71),
          ],
        ),
      ],
    );
  }
}