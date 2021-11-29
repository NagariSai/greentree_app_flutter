import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/media_widget.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/add_exercise_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/add_duration_exercise.dart';
import 'package:fit_beat/app/features/todaySchedule/view/add_reps_exercise.dart';
import 'package:fit_beat/app/features/todaySchedule/view/weight_reps_exercise.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddExerciseController>(
        init: AddExerciseController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Add your exercise",
              positiveText: "Add",
              onPositiveTap: () {
                _.addExercise();
              },
              negativeText: "Cancel",
              onNegativeTap: () {},
            ),
            body: _.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                    children: [
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextInputContainer(
                          title: "Title",
                          maxLength: 40,
                          maxLines: 2,
                          inputHint: "Exercise Name",
                          onChange: (value) {
                            _.exerciseTitle = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomInputContainer(
                          title: "Muscle Type",
                          fontWeight: FontWeight.bold,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _.getExerciseTypeWidgetList(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomInputContainer(
                          title: "Specification",
                          fontWeight: FontWeight.bold,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              CommonContainer(
                                height: 35,
                                width: Get.width,
                                borderRadius: 40,
                                backgroundColor: FFE0EAEE,
                                child: TabBar(
                                  labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      fontFamily: FontFamily.poppins),
                                  unselectedLabelStyle: TextStyle(
                                      color: FF868A8C,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      fontFamily: FontFamily.poppins),
                                  isScrollable: false,
                                  unselectedLabelColor: FF868A8C,
                                  labelColor: Colors.white,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: CustomTabIndicator(
                                    indicatorHeight: 28.0,
                                    indicatorColor: FF025074,
                                    indicatorRadius: 40,
                                  ),
                                  tabs: _.tabs,
                                  controller: _.tabController,
                                ),
                              ),
                              Container(
                                height: 300,
                                child: TabBarView(
                                  controller: _.tabController,
                                  children: [
                                    AddDurationExercisePage(),
                                    AddRepsExercisePage(),
                                    AddWeightRepsExercisePage(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextInputContainer(
                          minLines: 5,
                          maxLength: 160,
                          maxLines: 7,
                          title: "Description",
                          inputHint: "Write description here...",
                          onChange: (value) {
                            _.description = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomInputContainer(
                          title: "Video",
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Container(
                                height: 239,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: _.urlController,
                                      minLines: 1,
                                      maxLines: 1,
                                      maxLengthEnforced: true,
                                      decoration: new InputDecoration.collapsed(
                                          hintText: "Add video URL",
                                          hintStyle: TextStyle(
                                              color: FFBCC7CC, fontSize: 14)),
                                      keyboardType: TextInputType.url,
                                    ),
                                    const SizedBox(height: 20),
                                    CustomText(
                                      text: "(Or)",
                                      color: FFBDC5C5,
                                      size: 14,
                                    ),
                                    const SizedBox(height: 24),
                                    Container(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          if (_.mediaPathList.isNotEmpty) ...[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: ListView.separated(
                                                itemBuilder:
                                                    (context, position) {
                                                  return MediaWidget(
                                                    mediaFile: _.mediaPathList[
                                                        position],
                                                    onRemove: () =>
                                                        _.removeMedia(position),
                                                  );
                                                },
                                                itemCount:
                                                    _.mediaPathList.length,
                                                shrinkWrap: true,
                                                separatorBuilder:
                                                    (context, position) {
                                                  return SizedBox(
                                                    width: 8,
                                                  );
                                                },
                                                scrollDirection:
                                                    Axis.horizontal,
                                              ),
                                            ),
                                            _.mediaPathList.length < 5
                                                ? SizedBox(
                                                    width: 8,
                                                  )
                                                : SizedBox()
                                          ],
                                          _.mediaPathList.length < 5
                                              ? MediaWidget(
                                                  onTap: () =>
                                                      _.addMedia(context),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )),
          );
        });
  }
}
