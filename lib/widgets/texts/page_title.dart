import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/images/red_stars.png"),
        Center(child: Text(title, style: Theme.of(context).textTheme.headlineLarge)),
      ],
    );
  }
}