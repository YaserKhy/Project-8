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
            Text(title,style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(width: 10),
            title != 'Water' && title != 'Best Seller' && title != 'Settings'
            ? const SizedBox.shrink()
            : Container(
              margin: const EdgeInsets.only(top: 1),
              padding: EdgeInsets.zero,
              width: 75,
              color: AppConstants.mainRed,
              height: 1,
            ),
            Flexible(
              child: Image.asset("assets/images/star_line.png",fit: BoxFit.contain),
            ),
          ],
        ),
      )
    );
  }
}