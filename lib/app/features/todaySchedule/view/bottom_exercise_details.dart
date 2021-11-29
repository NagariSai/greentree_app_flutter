import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/views/video_widget.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/bottom_exercise_details_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/add_bottom_duration_exercise.dart';
import 'package:fit_beat/app/features/todaySchedule/view/add_bottom_reps_exercise.dart';
import 'package:fit_beat/app/features/todaySchedule/view/add_bottom_weight_reps_exercise.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomExerciseDetails extends StatelessWidget {
  ExerciseData exercise;
  int index;
  bool fromTodaySchedule;
  var exercisesSpecifications;
  String rest_bw_exercises;
  String rest_bw_sets;
  BottomExerciseDetails(this.exercise, this.index, this.fromTodaySchedule,
      {this.exercisesSpecifications,
      this.rest_bw_exercises,
      this.rest_bw_sets});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomExerciseController>(
        init: BottomExerciseController(
            repository: ApiRepository(apiClient: ApiClient()),
            exercise: exercise,
            index: index,
            rest_bw_exercises: rest_bw_exercises,
            rest_bw_sets: rest_bw_sets,
            fromTodaySchedule: fromTodaySchedule,
            exercisesSpecifications: exercisesSpecifications),
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              height: Get.height * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${exercise.title}",
                              size: 18,
                              color: FF050707,
                              fontWeight: FontWeight.bold,
                              maxLines: 3,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (fromTodaySchedule) {
                                Get.back();
                              } else {
                                _.onDoneClick();
                                Get.back();
                              }
                            },
                            child: CustomText(
                              text: "Done",
                              size: 14,
                              color: FF55B5FE,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 243,
                      padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                      child: VideoWidget(
                        url: exercise?.exerciseVideos.length > 0
                            ? exercise?.exerciseVideos[0].videoUrl
                            : "",
                        currentPage: 1,
                        totalPage: 1,
                        viewCount: 0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomText(
                        text: "Muscle Type",
                        color: FF6D7274,
                        size: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomText(
                        text:
                            "${exercise.exerciseMuscleTypeTitle ?? exercise.exerciseMuscleType.title ?? ""}",
                        color: FF050707,
                        fontWeight: FontWeight.w400,
                        size: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomText(
                        text: "Specification",
                        color: FF6D7274,
                        size: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_.durationList.length > 0)
                      AddBottomDurationExercisePage(
                        exercise: exercise,
                        fromTodaySchedule: fromTodaySchedule,
                        rest_bw_sets: rest_bw_sets,
                        rest_bw_exercises: rest_bw_exercises,
                      )
                    else if (_.repsList.length > 0)
                      AddBottomRepsExercisePage(
                        exercise: exercise,
                        fromTodaySchedule: fromTodaySchedule,
                        rest_bw_sets: rest_bw_sets,
                        rest_bw_exercises: rest_bw_exercises,
                      )
                    else if (_.weightRepsList.length > 0)
                      AddBottomWeightRepsExercisePage(
                        exercise: exercise,
                        fromTodaySchedule: fromTodaySchedule,
                        rest_bw_sets: rest_bw_sets,
                        rest_bw_exercises: rest_bw_exercises,
                      )
                    else
                      Container(),
                    const SizedBox(height: 8),
                    Divider(),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomText(
                        text: "Description",
                        color: FF6D7274,
                        size: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomText(
                        text: "${_.exercise.description ?? ""}",
                        color: FF050707,
                        maxLines: 10,
                        size: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
