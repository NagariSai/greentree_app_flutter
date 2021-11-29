import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/exercise_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calender_view.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'exercise_row.dart';

class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(
        init: ExerciseController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CustomCalenderView(
                    selectedDate: (selectedDate) {
                      //print(Utils.convertDateIntoDisplayString(selectedDate));
                      _.setCalenderDate(selectedDate);
                    },
                  ),
                  Divider(
                    thickness: 4,
                    color: dividerColor,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.selectExercisePage);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add,
                            color: FF55B5FE,
                            size: 16,
                          ),
                          CustomText(
                            text: "Add Exercise",
                            color: FF55B5FE,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _.asExercises != null && _.asExercises.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _.asExercises.length,
                              itemBuilder: (BuildContext context, int index) {
                                ExerciseData exercise =
                                    _.asExercises[index].exerciseData;

                                return ExerciseRow(
                                  index: index,
                                  exercise: exercise,
                                  rest_bw_exercises:
                                      _.asExercises[index].rest_bw_exercises,
                                  rest_bw_sets:
                                      _.asExercises[index].rest_bw_sets,
                                  userScheduleId:
                                      _.asExercises[index].userScheduleId,
                                  userScheduleActivityId: _.asExercises[index]
                                      .userScheduleActivityId,
                                  fromTodaySchedule: true,
                                  exercisesSpecifications: _.asExercises[index]
                                      .userScheduleActivitySpecifications,
                                );
                              })
                          : Container(
                              height: Get.height * 0.2,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: CustomText(
                                    text:
                                        "You have to enroll with the coach to manage Exercise schedule by coach.",
                                    color: FF6D7274,
                                    size: 14,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                ],
              ),
            ),
          );
        });
  }
}
