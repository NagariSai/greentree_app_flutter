import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_exercise_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/select_exercise_row.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SelectExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectExerciseController>(
        init: SelectExerciseController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Select Exercise",
              positiveText: "Add",
              onPositiveTap: () {
                if (_.input.isNotEmpty) {
                  _.addExerciseInScheduleActivity();
                } else {
                  Utils.showErrorSnackBar("Select atleast one exercise");
                }
              },
              onNegativeTap: () {
                Get.back();
              },
              negativeText: "Cancel",
            ),
            body: _.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: NormalTextField(
                          controller: _.searchController,
                          bgColor: settingBgColor,
                          showPrefixIcon: true,
                          hintColor: descriptionColor,
                          hintText: "Search Exercise…",
                          endIcon: Icons.close,
                          showIcon:
                              _.searchController.text.length > 0 ? true : false,
                          onIconTap: () {
                            _.onClearSearch();
                          },
                          onChanged: (String text) {
                            _.onSearchChange();
                          },
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        height: 50,
                        child: ListView.separated(
                          itemCount: _.exerciseTypeList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            var data = _.exerciseTypeList[position];
                            return GestureDetector(
                              onTap: () {
                                _.onExerciseTypeSelect(data);
                              },
                              child: Chip(
                                shape: data.exerciseMuscleTypeId ==
                                        _.selectedExerciseType
                                            .exerciseMuscleTypeId
                                    ? null
                                    : StadiumBorder(
                                        side: BorderSide(color: borderColor)),
                                label: Text(data.title),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                labelStyle: TextStyle(
                                    fontSize: 14,
                                    color: data.exerciseMuscleTypeId ==
                                            _.selectedExerciseType
                                                .exerciseMuscleTypeId
                                        ? Colors.white
                                        : titleBlackColor),
                                backgroundColor: data.exerciseMuscleTypeId ==
                                        _.selectedExerciseType
                                            .exerciseMuscleTypeId
                                    ? FF025074
                                    : Colors.white,
                              ),
                            );
                          },
                          separatorBuilder: (context, position) {
                            return SizedBox(
                              width: 8,
                            );
                          },
                        ),
                      ),
                      Divider(
                        thickness: 4,
                        color: dividerColor,
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.addExercisePage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              CustomText(
                                text: "${_.addedCount}",
                                color: FF55B5FE,
                                size: 16,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: FF55B5FE,
                                    size: 16,
                                  ),
                                  CustomText(
                                    text: "Add Your Exercise",
                                    color: FF55B5FE,
                                    size: 16,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _.isSearching
                          ? Center(child: CircularProgressIndicator())
                          : _.exerciseList.length > 0
                              ? Flexible(
                                  fit: FlexFit.loose,
                                  child: LazyLoadScrollView(
                                    onEndOfPage: () => _.loadNextFeed(),
                                    isLoading: _.feedLastPage,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: _.exerciseList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          ExerciseData exercise =
                                              _.exerciseList[index];
                                          return SelectExerciseRow(
                                              index: index);
                                        }),
                                  ),
                                )
                              : Center(
                                  child: CustomText(
                                    text: "No Data Found",
                                  ),
                                )
                    ],
                  ),
          );
        });
  }
}
