import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/timer_dialog_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:simple_timer/simple_timer.dart';

class TimerDialog extends StatelessWidget {
  int durationInSec;
  String title;
  TimerDialog({this.durationInSec, this.title = "Rest B/w Sets"});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimerDialogController>(
        init: TimerDialogController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Get.width / 2,
                        width: Get.width / 2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Get.width / 2)),
                        child: SimpleTimer(
                          duration: Duration(seconds: durationInSec),
                          controller: _.timerController,
                          timerStyle: TimerStyle.ring,
                          onStart: () {},
                          onEnd: () {
                            _.timerController.stop();
                            Get.back();
                          },
                          valueListener: (Duration time) {},
                          backgroundColor: Colors.white,
                          progressIndicatorColor: Colors.green,
                          progressIndicatorDirection:
                              TimerProgressIndicatorDirection.clockwise,
                          progressTextCountDirection:
                              TimerProgressTextCountDirection.count_down,
                          progressTextStyle:
                              TextStyle(color: Colors.black, fontSize: 24),
                          strokeWidth: 24,
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 55,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: CustomText(
                            text: "${title ?? ""}",
                            size: 11,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  RoundedCornerButton(
                    height: 50,
                    width: 94,
                    buttonText: "Skip it",
                    buttonColor: FFFFFFFF,
                    borderColor: FFFFFFFF,
                    fontSize: 14,
                    radius: 52,
                    iconAndTextColor: Colors.black,
                    onPressed: () {
                      _.timerController?.stop();
                      Get.back();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
