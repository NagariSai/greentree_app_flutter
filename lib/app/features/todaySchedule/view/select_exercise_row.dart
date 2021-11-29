import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_exercise_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/bottom_exercise_details.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class SelectExerciseRow extends StatefulWidget {
  int index;
  SelectExerciseRow({this.index});

  @override
  _SelectExerciseRowState createState() => _SelectExerciseRowState();
}

class _SelectExerciseRowState extends State<SelectExerciseRow> {
  bool isAddClick = false;
  ExerciseData exercise;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectExerciseController>(builder: (_) {
      exercise = _.exerciseList[widget.index];

      String exercisesSpecificationsStr = "";
      if (exercise.exercisesSpecifications != null &&
          exercise.exercisesSpecifications.length > 0) {
        for (int i = 0; i < exercise.exercisesSpecifications.length; i++) {
          if (exercise.exercisesSpecifications[i].specificationType == 1) {
            exercisesSpecificationsStr +=
                exercise.exercisesSpecifications[i].setVal1 + " | ";
          } else if (exercise.exercisesSpecifications[i].specificationType ==
              2) {
            exercisesSpecificationsStr += " ${i + 1} X" +
                exercise.exercisesSpecifications[i].setVal1 +
                " | ";
          } else if (exercise.exercisesSpecifications[i].specificationType ==
              3) {
            exercisesSpecificationsStr +=
                "${exercise.exercisesSpecifications[i].setVal1} X ${exercise.exercisesSpecifications[i].setVal2} | ";
          }
        }
      }

      return InkWell(
        onTap: () {
          Get.bottomSheet(
            BottomExerciseDetails(exercise, widget.index, false),
            isScrollControlled: true,
            ignoreSafeArea: false,
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 86,
                      width: 80,
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://png.pngtree.com/png-clipart/20190630/original/pngtree-vector-excercise-icon-png-image_4155854.jpg",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Image.asset(
                          Assets.backgroundBanner,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          CustomText(
                            text: "${exercise.title}",
                            size: 16,
                            color: FF050707,
                            fontWeight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CustomText(
                                      text:
                                          "${exercise.exerciseMuscleTypeTitle}",
                                      size: 13,
                                      color: FF55B5FE,
                                    ),
                                    CustomText(
                                      text: " | ${exercise.duration} Min",
                                      size: 13,
                                      color: FF6D7274,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() async {
                                    if (!exercise.isAddClick) {
                                      Get.bottomSheet(
                                        BottomExerciseDetails(
                                            exercise, widget.index, false),
                                        isScrollControlled: true,
                                        ignoreSafeArea: false,
                                      );
                                    } else {
                                      bool isRemove =
                                          await DialogUtils.customDialog(
                                              title: "Remove",
                                              description:
                                                  "Would you like to remove this exercise from list?",
                                              firstButtonTitle: "Ok",
                                              secondButtonTitle: "Cancle");

                                      if (isRemove) {
                                        isAddClick = !exercise.isAddClick;
                                        exercise.isAddClick = isAddClick;
                                        _.onAddRemoveClick(isAddClick,
                                            exercise.exerciseId, widget.index);
                                      }
                                    }
                                  });
                                },
                                child: !exercise.isAddClick
                                    ? Icon(
                                        Icons.add_circle_outline,
                                        color: FF6BD295,
                                      )
                                    : Image.asset(
                                        Assets.tick,
                                        height: 24,
                                        width: 24,
                                      ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            text: "${exercisesSpecificationsStr ?? ""}",
                            size: 12,
                            color: FF6D7274,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
