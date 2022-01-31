import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/coach_list_model.dart';
import 'package:fit_beat/app/features/coach/controller/coach_list_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coach_list_row.dart';

class CoachList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: "Coach",
        /*positiveText: "My Plan & coach",
        onPositiveTap: () {},*/
      ),
      body: GetBuilder<CoachListController>(builder: (_) {
        return _.isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: NormalTextField(
                        controller: _.searchController,
                        bgColor: settingBgColor,
                        showPrefixIcon: true,
                        hintColor: descriptionColor,
                        hintText: "Search Coach..",
                        isEndIconImage: true,
                        endIconImage: Assets.ic_filter,
                        showIcon: true,
                        onIconTap: () {
                          Utils.dismissKeyboard();
                          Get.toNamed(Routes.coachFilterUserPage);
                        },
                        onChanged: (String text) {},
                      ),
                    ),
                    Container(
                      height: 50,
                      child: ListView.separated(
                        itemCount: _.filterFitnessCategoryList.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          var data = _.filterFitnessCategoryList[position];
                          return GestureDetector(
                            onTap: () {
                              _.getFilteredCoach(position);
                            },
                            child: Chip(
                              shape: _.selectedFitensssCategory != null &&
                                      _.selectedFitensssCategory
                                              .fitnessCategoryId ==
                                          _.filterFitnessCategoryList[position]
                                              .fitnessCategoryId
                                  ? null
                                  : StadiumBorder(
                                      side: BorderSide(color: borderColor)),
                              label: Text(data.title),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: _.selectedFitensssCategory != null &&
                                          _.selectedFitensssCategory
                                                  .fitnessCategoryId ==
                                              _
                                                  .filterFitnessCategoryList[
                                                      position]
                                                  .fitnessCategoryId
                                      ? FF050707
                                      : titleBlackColor),
                              backgroundColor: _.selectedFitensssCategory !=
                                          null &&
                                      _.selectedFitensssCategory
                                              .fitnessCategoryId ==
                                          _.filterFitnessCategoryList[position]
                                              .fitnessCategoryId
                                  ? FFB2C8D2
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
                      thickness: 1,
                      color: dividerColor,
                    ),
                    _.coachList.length > 0
                        ? Expanded(
                            child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: GridView.builder(
                              itemCount: _.coachList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio:
                                          Get.width / (Get.height / 1.6)),
                              itemBuilder: (BuildContext context, index) {
                                Coach coach = _.coachList[index];
                                return CoachListRow(
                                  coach: coach,
                                );
                              },
                            ),
                          ))
                        : Expanded(
                            child: Center(
                                child: CustomText(text: "No Data Found.")))
                  ],
                ),
              );
      }),
    );
  }
}
