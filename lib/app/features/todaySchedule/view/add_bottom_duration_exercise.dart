import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/bottom_exercise_details_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/timer_dialog.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddBottomDurationExercisePage extends StatelessWidget {
  ExerciseData exercise;
  bool fromTodaySchedule;
  String rest_bw_exercises;
  String rest_bw_sets;
  AddBottomDurationExercisePage(
      {this.exercise,
      this.fromTodaySchedule,
      this.rest_bw_exercises,
      this.rest_bw_sets});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomExerciseController>(builder: (_) {
      // _.restSetController.text = exercise?.restBwSets ?? "";
      // _.restExerciseController.text = exercise?.restBwExercises ?? "";

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Add your sets",
              color: FF6D7274,
              size: 14,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            Container(
              height: 140,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._.durationList.map((specification) {
                      var index = _.durationList.indexOf(specification);
                      return Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            CustomText(
                              text: "${index + 1}.",
                              color: FF6D7274,
                              size: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            const SizedBox(width: 20),
                            Container(
                              width: 100,
                              height: 36,
                              decoration: BoxDecoration(
                                color: fromTodaySchedule
                                    ? specification.isExerciseStarted != 0
                                        ? FF6BD295
                                        : Colors.white
                                    : Colors.white,
                                border: Border.all(
                                    color: FFBCC7CC, // set border color
                                    width: 1.0), // set border width
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), // set rounded corner radius
                              ),
                              child: TextField(
                                controller: specification.textEditingController,
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    hintText: '0 Sets',
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, bottom: 10)),
                              ),
                            ),
                            Spacer(),
                            fromTodaySchedule
                                ? specification.isExerciseStarted == 0
                                    ? InkWell(
                                        onTap: () {
                                          _.durationList[index]
                                              .isExerciseStarted = 1;
                                          Get.find<BottomExerciseController>()
                                              .update();
                                        },
                                        child: Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(36)),
                                              border:
                                                  Border.all(color: FF6BD295)),
                                          child: Center(
                                            child: CustomText(
                                              text: "Start",
                                              color: FF6BD295,
                                              size: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : specification.isExerciseStarted == 1
                                        ? InkWell(
                                            onTap: () {
                                              _.durationList[index]
                                                  .isExerciseStarted = 2;
                                              Get.find<
                                                      BottomExerciseController>()
                                                  .update();

                                              Get.find<
                                                      BottomExerciseController>()
                                                  .updateSpecificationStatus(_
                                                      .durationList[index]
                                                      .user_schedule_activity_specification_id);

                                              int durationInSec = 0;
                                              String title = "";
                                              if (_.durationList.length - 1 ==
                                                  index) {
                                                title = "Rest B/w exercises";
                                                var parts = rest_bw_exercises
                                                    .split(':');
                                                if (parts.length > 1) {
                                                  durationInSec =
                                                      int.parse(parts[0]) +
                                                          int.parse(parts[1]);
                                                } else {
                                                  durationInSec =
                                                      int.parse(parts[0]);
                                                }
                                              } else {
                                                title = "Rest B/w Sets";
                                                var parts =
                                                    rest_bw_sets.split(':');
                                                if (parts.length > 1) {
                                                  durationInSec =
                                                      int.parse(parts[0]) +
                                                          int.parse(parts[1]);
                                                } else {
                                                  durationInSec =
                                                      int.parse(parts[0]);
                                                }
                                              }
                                              Get.dialog(
                                                TimerDialog(
                                                    durationInSec:
                                                        durationInSec,
                                                    title: title),
                                              );
                                            },
                                            child: Container(
                                              height: 36,
                                              width: 36,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(36)),
                                                  border: Border.all(
                                                      color: FF6BD295)),
                                              child: Center(
                                                child: CustomText(
                                                  text: "Done",
                                                  color: FF6BD295,
                                                  size: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        : CommonContainer(
                                            height: 36,
                                            width: 36,
                                            borderRadius: 36,
                                            backgroundColor: FF6BD295,
                                            child: Center(
                                                child: Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )),
                                          )
                                : InkWell(
                                    onTap: () {
                                      _.removeDuration(specification);
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: FF025074,
                                    ),
                                  )
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            fromTodaySchedule
                ? Container()
                : Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        _.addDuration();
                      },
                      child: Icon(
                        Icons.add_circle_outline,
                        color: FF55B5FE,
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Rest b/w sets",
                          color: FF6D7274,
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        TextField(
                          controller: _.restSetController,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: 'In Sec',
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, bottom: 10)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Rest b/w exercises",
                          color: FF6D7274,
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        TextField(
                          controller: _.restExerciseController,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: 'In Sec',
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, bottom: 10)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
