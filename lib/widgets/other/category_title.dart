import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';

class CategoryTitle extends StatelessWidget {
  final String title;
  const CategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: context.getWidth(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Average",
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            title!='Water' ? const SizedBox.shrink() : Container(margin: EdgeInsets.zero, padding: EdgeInsets.zero,width: 75,color: AppConstants.mainRed,height: 1,),
            Expanded(child: Image.asset("assets/images/star_line.png"))
          ],
        ),
      ),
    );
  }
}