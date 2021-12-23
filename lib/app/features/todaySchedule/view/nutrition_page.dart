import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
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
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'nutrition_food_row.dart';

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();


}

class _NutritionPageState extends State<NutritionPage> {



  /*void _updateMyItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final String item = asNutritions.removeAt(oldIndex);
    _.asNutritions.insert(newIndex, item);
  }*/
  String finalDate = Utils.getCurrentDate();

  bool viewVisible = false ;
  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionController>(
        init: NutritionController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return SingleChildScrollView(
            child: Container(

              color: bodybgColor,
              child: Column(children: [
                  Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,
                    child: CustomCalenderView(

                  isNutritionPage: true,
                  selectedDate: (selectedDate) {
                    _.setCalenderDate(selectedDate);
                  },

                ),
                  ),

                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Column(
                      children: [
                        TextButton(

                          onPressed: () {
                            if(viewVisible)
                              hideWidget();
                            else
                              showWidget();
                          },

                          child: Text(

                              finalDate, //title
                              textAlign: TextAlign.center,

                              style: TextStyle(color:customTextColor)
                          ),

                        ),

                      ],
                    ),

                 /*   Column(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black45,
                          size: 24,
                        ),
                      ],
                    )*/
                  ],
                ),

                _.isLoading
                    ? Container(
                        height: Get.height * 0.2,
                        child: Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [

                          const SizedBox(height: 16),
                        /*  Row(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Column(
                                children: [

                                  RichText(
                                    text: TextSpan(
                                      text: "0",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),

                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  CustomText(
                                    text: "EATEN",
                                    size: 14,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              Column(
                                  children: [
                                Container(


                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  //width: double.infinity,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 140,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // color: Color.fromRGBO(242, 244, 255, 1),
                                          color: Colors.white,
                                        ),
                                      ),
                                      CircularPercentIndicator(
                                        backgroundColor: Color.fromRGBO(242, 244, 255, 1),
                                        radius: 140.0,
                                        lineWidth: 4.0,
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
                                   *//* Positioned.fill(
                                        top: -15,
                                        right: -15,

                                        child: Align(
                                          alignment: Alignment.topRight,
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
                                              color: customTextColor,
                                            ),
                                          ),
                                        ),
                                      )*//*
                                    ],
                                  ),
                                ),
                                 ],
                              ),
                              Column(
                                children: [


                                  RichText(
                                    text: TextSpan(
                                      text: "0",

                                      style: TextStyle(
                                          color: Colors.black54,

                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),

                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  CustomText(
                                    text: "BURNED",
                                    size: 14,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              )
                            ],
                          ),*/

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                   // color: Color.fromRGBO(242, 244, 255, 1),
                                    color: Colors.white,
                                  ),
                                ),
                                CircularPercentIndicator(
                                  backgroundColor: Color.fromRGBO(242, 244, 255, 1),
                                  radius: 140.0,
                                  lineWidth: 4.0,
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
                                  top: -15,
                                  right: -5,
                                  child: Align(
                                    alignment: Alignment.topRight,
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
                                        size: 13,
                                        color: customTextColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Column(
                                children: [
                                  CustomText(
                                    text: "PROTEIN",
                                    size: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: new LinearPercentIndicator(
                                      // width: MediaQuery.of(context).size.width - 50,
                                      width:  70,
                                      animation: true,
                                      lineHeight: 3.0,
                                      animationDuration: 1500,
                                      percent: _.totalProteins,
                                      center: Text(""),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.green,
                                    ),
                                  ),
                                 /* Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green.withOpacity(0.8)),
                                  ),*/
                                SizedBox(
                                    height: 3,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: _.totalProteins.toStringAsFixed(1),
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " g",
                                          style: TextStyle(
                                            color: Colors.green,
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
                                    text: "CARBS",
                                    size: 14,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: new LinearPercentIndicator(
                                      // width: MediaQuery.of(context).size.width - 50,
                                      width:  60,
                                      animation: true,
                                      lineHeight: 3.0,
                                      animationDuration: 1500,
                                      percent: _.totalCarbs,
                                      center: Text(""),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.orangeAccent,
                                    ),
                                  ),
                               /*   Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orangeAccent.withOpacity(0.8)),
                                  ),*/
                                 SizedBox(
                                    height: 3,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: _.totalCarbs.toStringAsFixed(1),
                                      style: TextStyle(
                                          color: Colors.orangeAccent,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " g",
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
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
                                    text: "FAT",
                                    size: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: new LinearPercentIndicator(
                                     // width: MediaQuery.of(context).size.width - 50,
                                      width:  50,
                                      animation: true,
                                      lineHeight: 3.0,
                                      animationDuration: 1500,
                                      percent: _.totalFats,
                                      center: Text(""),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.red,
                                    ),
                                  ),
                               /*   Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.withOpacity(0.8)),
                                  ),*/
                                  SizedBox(
                                    height: 3,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: _.totalFats.toStringAsFixed(1),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.poppins),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " g",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 13,
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
                            height: 18,
                          ),


                          Container(
                            color:bodybgColor,
                            height: 300,
                            child: _.asNutritions.length > 0

                                ? ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    vertical:  8),
                                scrollDirection: Axis.vertical,
                                itemCount: _.asNutritions.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  AsNutrition categoryType =
                                  _.asNutritions[index];
                                  return InkWell(
                                    onTap: () {
                                      _.selectUnselectCategoryType(index);
                                      if (_.kCal > 0) {
                                        Get.toNamed(Routes.selectFoodPage);
                                      } else {
                                        Utils.showErrorSnackBar(
                                            "Please set Kcal limit first.");
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4,top:4),
                                          child: Row(

                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              if(categoryType.title.endsWith("Breakfast"))
                                                InkWell(
                                                  child: Image.asset(
                                                    Assets.breakfastIcon,
                                                    height: 50,
                                                    width: 50,
                                                  ),

                                                ),
                                              if(categoryType.title.endsWith("Lunch"))
                                                InkWell(
                                                  child: Image.asset(
                                                    Assets.lunchIcon,
                                                    height: 50,
                                                    width: 50,
                                                  ),

                                                ),
                                              if(categoryType.title.endsWith("Snack 1") || categoryType.title.endsWith("Snack 2")  || categoryType.title.endsWith("Snack 3") )
                                                InkWell(
                                                  child: Image.asset(
                                                    Assets.snacksIcon,
                                                    height: 50,
                                                    width: 50,
                                                  ),

                                                ),
                                              if(categoryType.title.endsWith("Dinner"))
                                                InkWell(
                                                  child: Image.asset(
                                                    Assets.dinnerIcon,
                                                    height: 50,
                                                    width: 50,
                                                  ),

                                                ),

                                              Container(height: 50,child: VerticalDivider(color: FF6D7274)),
                                              Expanded(

                                                child: Container(
                                                  margin: EdgeInsets.only(left: 10),

                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      CustomText(
                                                        text: "${categoryType.title}",
                                                        size: 16,
                                                        color: FF050707,
                                                        maxLines: 2,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      /*  if( _.nutritions.length > 0 /*&& _.nutritions[0].nutritionData.foodType==1*/ )


                                                             NutritionFoodRow(
                                                            isSelf: false,
                                                            asNutritions: _.nutritions[0].nutritionData,
                                                            userScheduleActivityId: _
                                                                .nutritions[index]
                                                                .userScheduleActivityId,
                                                            userScheduleId:
                                                            _.nutritions[index].userScheduleId,
                                                            isDone: true,
                                                            index: index,
                                                            ),

                                                      Row(
                                                            children: [
                                                              CustomText(
                                                                text:"Recommended | ",
                                                                size: 13,
                                                                color: FF6D7274,
                                                              ),
                                                              CustomText(
                                                                text:"100 kcal ",
                                                                size: 13,
                                                                color: Colors.lightBlue,
                                                              ),
                                                            ],
                                                          )*/
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () async {
                                                    _.selectUnselectCategoryType(index);
                                                    if (_.kCal > 0) {
                                                      //Get.toNamed(Routes.selectFoodPage);
                                                      Get.toNamed(Routes.addFoodNutritionPage);
                                                    } else {
                                                      Utils.showErrorSnackBar(
                                                          "Please set Kcal limit first.");
                                                    }


                                                  },
                                                  child:
                                                  Icon(
                                                    Icons.add_circle_outline,
                                                    color: FF6BD295,
                                                  )

                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      /*   margin: EdgeInsets.only(right: 8),
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
                                          ),*/
                                    ),
                                  );

                                  /*  return
                                         Container(
                                          margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                          child: Card(
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [

                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CustomText(
                                                            text: "${categoryType.title}",
                                                            size: 16,
                                                            color: FF050707,
                                                            maxLines: 2,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              CustomText(
                                                                text:"Recommended 100 kcal ",
                                                                size: 13,
                                                                color: FF6D7274,
                                                              ),

                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {

                                                       // openFoodDetailPageDialog(_);

                                                    },
                                                    child:
                                                         Icon(
                                                      Icons.add_circle_outline,
                                                      color: FF6BD295,
                                                    )

                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );*/

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
                                   /* if (_.kCal > 0) {
                                      Get.toNamed(Routes.selectFoodPage);
                                    } else {
                                      Utils.showErrorSnackBar(
                                          "Please set Kcal limit first.");
                                    }*/
                                  },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                  /*    child: Row(
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
                                    ),*/
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

                               :Container(
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
