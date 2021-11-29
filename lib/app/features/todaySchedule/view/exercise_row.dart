import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/exercise_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/bottom_exercise_details.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class ExerciseRow extends StatelessWidget {
  ExerciseData exercise;
  int index;
  var userScheduleId;
  var userScheduleActivityId;
  bool fromTodaySchedule;
  var exercisesSpecifications;
  String rest_bw_exercises;
  String rest_bw_sets;

  ExerciseRow(
      {this.exercise,
      this.rest_bw_exercises,
      this.rest_bw_sets,
      this.userScheduleId,
      this.userScheduleActivityId,
      this.fromTodaySchedule = false,
      this.exercisesSpecifications,
      this.index});

  @override
  Widget build(BuildContext context) {
    String exercisesSpecificationsStr = "";
    if (exercisesSpecifications != null && exercisesSpecifications.length > 0) {
      for (int i = 0; i < exercisesSpecifications.length; i++) {
        if (exercisesSpecifications[i].specificationType == 1) {
          exercisesSpecificationsStr +=
              exercisesSpecifications[i].setVal1 + " | ";
        } else if (exercisesSpecifications[i].specificationType == 2) {
          exercisesSpecificationsStr +=
              " ${i + 1} X" + exercisesSpecifications[i].setVal1 + " | ";
        } else if (exercisesSpecifications[i].specificationType == 3) {}

        exercisesSpecificationsStr += exercisesSpecifications[i].setVal1 +
            " X " +
            exercisesSpecifications[i].setVal2 +
            " | ";
      }
    }

    return InkWell(
      onTap: () {
        Get.bottomSheet(
          BottomExerciseDetails(
            exercise,
            index,
            fromTodaySchedule,
            rest_bw_sets: rest_bw_sets,
            rest_bw_exercises: rest_bw_exercises,
            exercisesSpecifications: exercisesSpecifications,
          ),
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
                          text: "${exercise.title ?? ""}",
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
                                        "${exercise.exerciseMuscleType.title ?? ""}",
                                    size: 13,
                                    color: FF55B5FE,
                                  ),
                                ],
                              ),
                            ),
                            exercise.isSystem == 0
                                ? InkWell(
                                    onTap: () async {
                                      var result = await DialogUtils.customDialog(
                                          title: "Delete",
                                          description:
                                              "Are you sure you want to Delete this exercise? ",
                                          firstButtonTitle: "Yes, Delete",
                                          secondButtonTitle: "Cancel");

                                      if (result) {
                                        Get.find<ExerciseController>()
                                            .deleteExerciseInScheduleActivity(
                                                userScheduleId,
                                                userScheduleActivityId);
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      color: FFD890D5,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: "${exercisesSpecificationsStr ?? ""}",
                          size: 12,
                          color: FF6D7274,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: exercise.isSystem == 0 ? "By me" : "By coach",
                          size: 12,
                          color: exercise.isSystem == 0 ? FFD890D5 : FF6BD295,
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
  }
}
