import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/fl_chart/fl_chart.dart';
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

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  void initState() {
    super.initState();
  }

  String finalDate = Utils.getCurrentDate();

  bool viewVisible = false;

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
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
                            if (viewVisible)
                              hideWidget();
                            else
                              showWidget();
                          },
                          child: Text(finalDate, //title
                              textAlign: TextAlign.center,
                              style: TextStyle(color: customTextColor)),
                        ),
                      ],
                    ),
                  ],
                ),
                _.isLoading
                    ? Container(
                        height: Get.height * 0.2,
                        child: Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [
                          const SizedBox(height: 16),
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
                                  backgroundColor:
                                      Color.fromRGBO(242, 244, 255, 1),
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
                                      width: 70,
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
                                      width: 60,
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
                                      width: 50,
                                      animation: true,
                                      lineHeight: 3.0,
                                      animationDuration: 1500,
                                      percent: _.totalFats,
                                      center: Text(""),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.red,
                                    ),
                                  ),
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
                          /*for (var i = 0; i < _.asNutritions.length; i++)
                                buildRow(_.asNutritions[i]
                                .masterCategoryTypeId,
                                _.asNutritions[i].title, _.nutritions,
                                _.kCal, _.selectUnselectCategoryType(i),
                                i),*/

                          Container(
                            color: bodybgColor,
                            height: 400,
                            child: _.asNutritions.length > 0
                                ? ListView.builder(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
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
                                          margin: EdgeInsets.only(
                                              left: 8, right: 8, bottom: 8),
                                          child: Card(
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 4,
                                                  top: 4),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (categoryType.title
                                                      .endsWith("Breakfast"))
                                                    InkWell(
                                                      child: Image.asset(
                                                        Assets.breakfastIcon,
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  if (categoryType.title
                                                      .endsWith("Lunch"))
                                                    InkWell(
                                                      child: Image.asset(
                                                        Assets.lunchIcon,
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  if (categoryType.title.endsWith("Snack 1") ||
                                                      categoryType.title
                                                          .endsWith(
                                                              "Snack 2") ||
                                                      categoryType.title
                                                          .endsWith("Snack 3"))
                                                    InkWell(
                                                      child: Image.asset(
                                                        Assets.snacksIcon,
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  if (categoryType.title
                                                      .endsWith("Dinner"))
                                                    InkWell(
                                                      child: Image.asset(
                                                        Assets.dinnerIcon,
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  Container(
                                                      height: 50,
                                                      child: VerticalDivider(
                                                          color: FF6D7274)),
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                                 CustomText(
                                                            text:
                                                                "${categoryType.title}",
                                                            size: 16,
                                                            color: FF050707,
                                                            maxLines: 2,
                                                            fontWeight:
                                                                FontWeight.w600,

                                                          ),

                                                         SizedBox(
                                                            height: 10,
                                                          ),
                                                          getTextWidgets(
                                                              _.nutritions,
                                                              categoryType
                                                                  .masterCategoryTypeId),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () async {
                                                        _.selectUnselectCategoryType(
                                                            index);
                                                        if (_.kCal > 0) {
                                                          //Get.toNamed(Routes.selectFoodPage);
                                                          Get.toNamed(Routes
                                                              .addFoodNutritionPage);
                                                        } else {
                                                          Utils.showErrorSnackBar(
                                                              "Please set Kcal limit first.");
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color: FF6BD295,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container(),
                          ),


                          Container(
                            height: Get.height * 0.08,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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

  Widget getTextWidgets1(List<Nutrition> strings, String title) {
    return new Row(
        children:
            strings.map((item) => new Text(item.nutritionData.title)).toList());
  }

  Widget getCategoryTitle(
      AsNutrition categoryType, List<Nutrition> nutritions) {
    return new
    Row(


      children: [

    Padding(
    padding:const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8) ),
        if (categoryType.title.endsWith("Breakfast"))
          InkWell(
            child: Image.asset(
              Assets.breakfastIcon,
              height: 50,
              width: 50,
            ),
          ),
        if (categoryType.title.endsWith("Lunch"))
          InkWell(
            child: Image.asset(
              Assets.lunchIcon,
              height: 50,
              width: 50,
            ),
          ),
        if (categoryType.title.endsWith("Snack 1") ||
            categoryType.title.endsWith("Snack 2") ||
            categoryType.title.endsWith("Snack 3"))
          InkWell(
            child: Image.asset(
              Assets.snacksIcon,
              height: 50,
              width: 50,
            ),
          ),
        if (categoryType.title.endsWith("Dinner"))
          InkWell(
            child: Image.asset(
              Assets.dinnerIcon,
              height: 50,
              width: 50,
            ),
          ),
        Container(height: 50, child: VerticalDivider(color: FF6D7274)),
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
                getTextWidgets(nutritions, categoryType.masterCategoryTypeId),
              ],
            ),
          ),
        ),
        InkWell(
            onTap: () async {
              //   _.selectUnselectCategoryType(i);
              Get.toNamed(Routes.addFoodNutritionPage);
              /*if (_.kCal > 0) {

                          Get.toNamed(Routes.addFoodNutritionPage);
                        } else {
                          Utils.showErrorSnackBar(
                              "Please set Kcal limit first.");
                        }*/
            },
            child: Icon(
              Icons.add_circle_outline,
              color: FF6BD295,
            )),
Divider(color: Colors.white,thickness: 2,)
      ],

    );
  }
  buildRow(letter, name, List<Nutrition> nutritions,kCal,selectUnselectCategoryType(i),index) {
    return new Card(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (name.endsWith("Breakfast"))
                  InkWell(
                    child: Image.asset(
                      Assets.breakfastIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                if (name.endsWith("Lunch"))
                  InkWell(
                    child: Image.asset(
                      Assets.lunchIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                if (name.endsWith("Snack 1") ||
                    name.endsWith("Snack 2") ||
                    name.endsWith("Snack 3"))
                  InkWell(
                    child: Image.asset(
                      Assets.snacksIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                if (name.endsWith("Dinner"))
                  InkWell(
                    child: Image.asset(
                      Assets.dinnerIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                Container(
                    height: 50, child: VerticalDivider(color: FF6D7274)),
                Expanded(

                  child: Container(

                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "${name}",
                          size: 16,
                          color: FF050707,
                          maxLines: 2,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        getTextWidgets(nutritions, letter),
                      ],
                    ),
                  ),
                ),
                InkWell(
                    onTap: () async {
                         selectUnselectCategoryType(index);
                      Get.toNamed(Routes.addFoodNutritionPage);
                      if (kCal > 0) {

                            Get.toNamed(Routes.addFoodNutritionPage);
                          } else {
                            Utils.showErrorSnackBar(
                                "Please set Kcal limit first.");
                          }
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      color: FF6BD295,
                    )),

        /*  new ListTile(

            leading:

           Image.asset(
                Assets.breakfastIcon,
                height: 50,
                width: 50,
              ),


            title: new Text(name),
            subtitle: getTextWidgets(strings, letter),
            trailing: new Icon(
              Icons.add_circle_outline,
              color: FF6BD295,
            ),
          ),*/
        ],
      ),
    ),
    ]
    )
    );

  }

  Widget getTextWidgets(List<Nutrition> strings, int title) {
    List<Widget> list = [];
    try {
      for (var i = 0; i < strings.length; i++) {
        if (strings[i].nutritionData.masterCategoryTypeId == title)
          list.add(new Text(strings[i].nutritionData.title + ","));
      }
    } catch (e) {
      print("error  ${e.toString()}");
    }

    return new Row(children: list);
  }


  Widget getCateogryWidgets(
      AsNutrition categoryType, List<Nutrition> nutritions) {

    try {

        print("cat::" + categoryType.title);
        return new Row (
            children: [


                 Padding(
                  padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (categoryType.title.endsWith("Breakfast"))
                        InkWell(
                          child: Image.asset(
                            Assets.breakfastIcon,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      if (categoryType.title.endsWith("Lunch"))
                        InkWell(
                          child: Image.asset(
                            Assets.lunchIcon,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      if (categoryType.title.endsWith("Snack 1") ||
                          categoryType.title.endsWith("Snack 2") ||
                          categoryType.title.endsWith("Snack 3"))
                        InkWell(
                          child: Image.asset(
                            Assets.snacksIcon,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      if (categoryType.title.endsWith("Dinner"))
                        InkWell(
                          child: Image.asset(
                            Assets.dinnerIcon,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      Container(
                          height: 50, child: VerticalDivider(color: FF6D7274)),
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
                              getTextWidgets(nutritions, categoryType.masterCategoryTypeId),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            //   _.selectUnselectCategoryType(i);
                            Get.toNamed(Routes.addFoodNutritionPage);
                            /*if (_.kCal > 0) {

                            Get.toNamed(Routes.addFoodNutritionPage);
                          } else {
                            Utils.showErrorSnackBar(
                                "Please set Kcal limit first.");
                          }*/
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            color: FF6BD295,
                          )),
                    ],
                  ),
                )



  ]
        );

    } catch (e) {
      print("error  ${e.toString()}");
    }

    //return new Row(children: list);
  }
  Widget getCateogryWidgets1(
      List<AsNutrition> asNutritions, List<Nutrition> nutritions) {
    List<Widget> list = [];
    try {
      for (var i = 0; i < asNutritions.length; i++) {
        AsNutrition categoryType = asNutritions[i];
        print("cat::" + categoryType.title);
        list.add(new Container(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (categoryType.title.endsWith("Breakfast"))
                    InkWell(
                      child: Image.asset(
                        Assets.breakfastIcon,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  if (categoryType.title.endsWith("Lunch"))
                    InkWell(
                      child: Image.asset(
                        Assets.lunchIcon,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  if (categoryType.title.endsWith("Snack 1") ||
                      categoryType.title.endsWith("Snack 2") ||
                      categoryType.title.endsWith("Snack 3"))
                    InkWell(
                      child: Image.asset(
                        Assets.snacksIcon,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  if (categoryType.title.endsWith("Dinner"))
                    InkWell(
                      child: Image.asset(
                        Assets.dinnerIcon,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  Container(
                      height: 50, child: VerticalDivider(color: FF6D7274)),
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
                          getTextWidgets(nutritions, categoryType.masterCategoryTypeId),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                     //   _.selectUnselectCategoryType(i);
                        Get.toNamed(Routes.addFoodNutritionPage);
                         /*if (_.kCal > 0) {

                          Get.toNamed(Routes.addFoodNutritionPage);
                        } else {
                          Utils.showErrorSnackBar(
                              "Please set Kcal limit first.");
                        }*/
                      },
                      child: Icon(
                        Icons.add_circle_outline,
                        color: FF6BD295,
                      )),
                ],
              ),
            )
               // child: getCategoryTitle(categoryType, nutritions)),
          ),
        ));
      }
    } catch (e) {
      print("error  ${e.toString()}");
    }

    return new Row(children: list);
  }
}
