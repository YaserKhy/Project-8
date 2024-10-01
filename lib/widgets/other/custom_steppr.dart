import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/screens/user_screens/order/bloc/order_bloc.dart'
    as order_bloc;

class CustomSteppr extends StatelessWidget {
  const CustomSteppr({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => order_bloc.OrderBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<order_bloc.OrderBloc>();
        int activeStep = bloc.activeStep;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<order_bloc.OrderBloc, order_bloc.OrderState>(
                builder: (context, state) {
                  return EasyStepper(
                    lineStyle: const LineStyle(
                      lineSpace: 0,
                      defaultLineColor: Colors.black26,
                      finishedLineColor: AppConstants.mainlightBlue,
                      lineLength: 100,
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
                        title: 'Delivered',
                      ),
                    ],
                    steppingEnabled: true,
                    onStepReached: (index) => activeStep = index,
                  );
                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: AppConstants.green,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    activeStep = activeStep + 1;
                    bloc.add(order_bloc.ChangeIndcatorEvent());
                  },
                  child: const Text("Done"))
            ],
          ),
        );
      }),
    );
  }
}
