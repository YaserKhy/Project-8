import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class CustomTapbar extends StatelessWidget {
  const CustomTapbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
        unselectedLabelStyle: TextStyle(
            color: AppConstants.unselectedColor,
            fontSize: 25,
            fontFamily: "Average"),
        labelStyle: TextStyle(
            color: AppConstants.mainBlue, fontSize: 25, fontFamily: "Average"),
        indicatorColor: AppConstants.mainBlue,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [Tab(text: "In progress"), Tab(text: "done")]);
  }
}
