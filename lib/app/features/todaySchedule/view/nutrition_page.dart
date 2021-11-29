import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calender_view.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'nutrition_food_row.dart';

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionController>(
        init: NutritionController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              child: Column(children: [
                CustomCalenderView(
                  isNutritionPage: true,
                  selectedDate: (selectedDate) {
                    _.setCalenderDate(selectedDate);
                  },
                ),
                Divider(
                  thickness: 4,
                  color: dividerColor,
                ),
                _.isLoading
                    ? Container(
                        height: Get.height * 0.2,
                        child: Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(242, 244, 255, 1),
                                  ),
                                ),
                                CircularPercentIndicator(
                                  backgroundColor:
                                      Color.fromRGBO(242, 244, 255, 1),
                                  radius: 140.0,
                                  lineWidth: 8.0,
                                  percent: _.getNutritionPercentage(),
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: "${_.kCalIntake}",
                                        color: FF050707,
                                        size: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      CustomText(
                                        text: "of",
                                        color: FF6D7274,
                                        size: 11,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      CustomText(
                                        text: "${_.kCal} Kcal",
                                        color: FF050707,
                                        size: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  progressColor:
                                      _.isCalExceed ? FFFF9B91 : FF6BD295,
                                ),
                                Positioned.fill(
                                  bottom: -10,
                                  right: 0,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () async {
                                        String result =
                                            await DialogUtils.setKCalDialog();
                                        if (result != null && result != "") {
                                          setState(() {
                                            _.kCal = int.parse(result);
                                            _.updateKcal();
                                          });
                                        }
                                      },
                                      child: CustomText(
                                        text: "Set Kcal Limit",
                                        size: 14,
                                        color: FF55B5FE,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    text: "Protein",
                                    size: 14,
                                    color: FF050707,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: FF8DA310.withOpacity(0.4)),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: _.totalProteins.toStringAsFixed(1),
                                      style: TextStyle(
                                          color: FF8DA310,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " g",
                                          style: TextStyle(
                                            color: FF93999B,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  CustomText(
                                    text: "Carbs",
                                    size: 14,
                                    color: FF050707,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: FF8C186D.withOpacity(0.4)),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: _.totalCarbs.toStringAsFixed(1),
                                      style: TextStyle(
                                          color: FF8C186D,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " g",
                                          style: TextStyle(
                                            color: FF93999B,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  CustomText(
                                    text: "Fat",
                                    size: 14,
                                    color: FF050707,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: FFFF7666.withOpacity(0.4)),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: _.totalFats.toStringAsFixed(1),
                                      style: TextStyle(
                                          color: FFFF7666,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " g",
                                          style: TextStyle(
                                            color: FF93999B,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Divider(
                            color: FFB0B8BB,
                          ),
                          Container(
                            height: 60,
                            child: _.asNutritions.length > 0
                                ? ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _.asNutritions.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      AsNutrition categoryType =
                                          _.asNutritions[index];
                                      return InkWell(
                                        onTap: () {
                                          _.selectUnselectCategoryType(index);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 8),
                                          child: Chip(
                                            label:
                                                Text("${categoryType.title}"),
                                            shape: StadiumBorder(
                                                side: BorderSide(
                                                    color: FFBCC7CC)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            labelStyle: TextStyle(
                                                fontSize: 14,
                                                color: categoryType
                                                            .masterCategoryTypeId ==
                                                        _.selectedCategoryType
                                                            .masterCategoryTypeId
                                                    ? Colors.white
                                                    : FF050707),
                                            backgroundColor: categoryType
                                                        .masterCategoryTypeId ==
                                                    _.selectedCategoryType
                                                        .masterCategoryTypeId
                                                ? FF025074
                                                : Colors.white,
                                          ),
                                        ),
                                      );
                                    })
                                : Container(),
                          ),
                          _.asNutritions.length > 0
                              ? Divider(
                                  color: FFB0B8BB,
                                )
                              : Container(),
                          _.asNutritions.length > 0
                              ? InkWell(
                                  onTap: () {
                                    if (_.kCal > 0) {
                                      Get.toNamed(Routes.selectFoodPage);
                                    } else {
                                      Utils.showErrorSnackBar(
                                          "Please set Kcal limit first.");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: FF55B5FE,
                                          size: 16,
                                        ),
                                        CustomText(
                                          text:
                                              "Add ${_.selectedCategoryType?.title ?? ""}",
                                          color: FF55B5FE,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 16),
                          _.nutritions.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _.nutritions.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    NutritionData asNutritions =
                                        _.nutritions[index].nutritionData;
                                    var isSelf = asNutritions.isSystem == 0
                                        ? true
                                        : false;
                                    var isDone = _.nutritions[index].isDone;
                                    return NutritionFoodRow(
                                      isSelf: isSelf,
                                      asNutritions: asNutritions,
                                      userScheduleActivityId: _
                                          .nutritions[index]
                                          .userScheduleActivityId,
                                      userScheduleId:
                                          _.nutritions[index].userScheduleId,
                                      isDone: isDone,
                                      index: index,
                                    );
                                  })
                              : Container(
                                  height: Get.height * 0.1,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: CustomText(
                                        text:
                                            "You have to enroll with the coach to manage nutrition schedule by coach.",
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
                      )
              ]),
            ),
          );
        });
  }
}
