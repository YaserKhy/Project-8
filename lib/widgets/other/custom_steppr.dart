import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class CustomSteppr extends StatelessWidget {
  const CustomSteppr({super.key, required this.activeStep, this.onStepReached});
  final int activeStep;
   final Function(int)? onStepReached;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyStepper(
              lineStyle: const LineStyle(
                lineSpace: 0,
                defaultLineColor: Colors.black26,
                finishedLineColor: AppConstants.mainlightBlue,
                lineLength: 70,
                lineType: LineType.normal,
              ),
              activeStep: activeStep,
              activeStepTextColor: Colors.black87,
              finishedStepTextColor: Colors.black87,
              internalPadding: 0,
              showLoadingAnimation: false,
              stepRadius: 13,
              showStepBorder: false,
              steps: [
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 13,
                    backgroundColor: activeStep >= 0
                        ? AppConstants.mainlightBlue
                        : Colors.black26,
                  ),
                  title: 'Waiting',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 13,
                    backgroundColor: activeStep >= 1
                        ? AppConstants.mainlightBlue
                        : Colors.black26,
                  ),
                  title: 'Preparing',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 13,
                    backgroundColor: activeStep >= 2
                        ? AppConstants.mainlightBlue
                        : Colors.black26,
                  ),
                  title: 'Ready',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 13,
                    backgroundColor: activeStep >= 3
                        ? AppConstants.mainlightBlue
                        : Colors.black26,
                  ),
                  title: 'Done',
                ),
              ],
              steppingEnabled: true,
              onStepReached: onStepReached ,
            ),
          ],
        ),
      );
    });
  }
}
