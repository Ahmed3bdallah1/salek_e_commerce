import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomStepperWidget extends StatefulWidget {
  final int status;
  const CustomStepperWidget({super.key, required this.status});

  @override
  State<CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: EasyStepper(
        activeStep: widget.status,
        activeStepBackgroundColor: Colors.yellow,
        enableStepTapping: false,
        lineStyle: const LineStyle(
            lineLength: 60,
            lineSpace: 0,
            lineType: LineType.dashed,
            defaultLineColor: Colors.white,
            finishedLineColor: Colors.green),
        activeStepTextColor: Colors.black87,
        finishedStepTextColor: Colors.black87,
        internalPadding: 0,
        // showLoadingAnimation: true,
        stepRadius: 12,
        // showStepBorder: false,
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              radius: 12,
              backgroundColor: widget.status >= 0 ? Colors.green : Colors.white,
              child: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              )),
            ),
            title: 'Waiting'.tr,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 12,
              backgroundColor: widget.status >= 1 ? Colors.green : Colors.white,
              child: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              )),
            ),
            title: 'Order Received'.tr,
            topTitle: true,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 12,
              backgroundColor: widget.status >= 2 ? Colors.green : Colors.white,
              child: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              )),
            ),
            title: 'Preparing'.tr,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 12,
              backgroundColor: widget.status == 3 ? Colors.green : Colors.white,
            ),
            title: 'Delivered'.tr,
            topTitle: true,
          ),
        ],
      ),
    );
  }
}
