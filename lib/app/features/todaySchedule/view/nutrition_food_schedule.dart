import 'dart:ui';

import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class NutritionFoodSchedulePage extends StatefulWidget {
  /*List  <Nutrition>
  myObject;
  NutritionFoodSchedulePage({
    this.myObject
  });*/

  @override
  _NutritionFoodSchedulePageState createState() =>
      _NutritionFoodSchedulePageState();
}

class _NutritionFoodSchedulePageState extends State<NutritionFoodSchedulePage> {
  NutritionController ntController;
  @override
  void initState() {
    ntController = new NutritionController(
        repository: ApiRepository(apiClient: ApiClient()));
    super.initState();
  }

  String finalDate = Utils.getCurrentDate();
  int itemcal = 0;
  List<Nutrition>  selectedntlist;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionController>(
        //init: NutritionController(repository: ApiRepository(apiClient: ApiClient())),
        init: ntController,
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "",
              positiveText: "",
              onPositiveTap: () {},
              onNegativeTap: () {
                Get.back();
              },
              negativeText: "",
            ),
            body: SingleChildScrollView(
              child: Container(
                color: bodybgColor,
                child: Column(children: [
                  Container(
                      child: Column(
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
                            for (var i = 0; i < _.asNutritions.length; i++)
                              if (_.asNutritions[i].masterCategoryTypeId == Utils.selectedCat)

                                buildCircularIndicator( _.asNutritions[i].nutritions),
/*
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
                                  text: "$itemcal",
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
*/
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      for (var i = 0; i < _.asNutritions.length; i++)
                        if (_.asNutritions[i].masterCategoryTypeId ==
                            Utils.selectedCat)
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  textAlign: TextAlign.center,
                                  text: _.asNutritions[i].title,
                                  size: 16,
                                  color: appbgColor,
                                  fontWeight: FontWeight.w800,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  text: _.scheduleDate,
                                  size: 14,
                                  color: appbgColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                      InkWell(
                        onTap: () {
                          setState(() {});
                          Get.toNamed(Routes.selectFoodPage);
                        },
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16.0),
                              child: CustomText(
                                textAlign: TextAlign.center,
                                text: "ADD MORE FOOD",
                                size: 16,
                                color: bodybgColor,
                                fontWeight: FontWeight.w800,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(24), // radius of 10
                                  color: appbgColor // green as background color
                                  )),
                        ),
                      ),
                      for (var i = 0; i < _.asNutritions.length; i++)
                        if (_.asNutritions[i].masterCategoryTypeId ==
                            Utils.selectedCat)
                          Container(
                              color: Colors.white,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(6.0),
                              child: buildCategoryRow(
                                  _.asNutritions[i].nutritions)),
                      SizedBox(
                        height: 18,
                      ),
                      for (var i = 0; i < _.asNutritions.length; i++)
                        if (_.asNutritions[i].masterCategoryTypeId ==
                            Utils.selectedCat)
                      buildnutritionCaloryItems(_.asNutritions[i].nutritions),
                     /* Container(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomText(
                                  text: "Protein",
                                  size: 16,
                                  color: Colors.green,
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text: _.asNutritions[i].nutritions[0]
                                      .nutritionCalory.protein
                                      .toString(),
                                  size: 14,
                                  color: Colors.green,
                                  textAlign: TextAlign.right,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Carbs",
                                  size: 14,
                                  color: Colors.deepOrangeAccent,
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: _.asNutritions[i].nutritions[0]
                                      .nutritionCalory.carbs
                                      .toString(),
                                  size: 14,
                                  color: Colors.deepOrangeAccent,
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomText(
                                  text: "Fat",
                                  size: 16,
                                  textAlign: TextAlign.left,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text: _.asNutritions[i].nutritions[0]
                                      .nutritionCalory.fat
                                      .toString(),
                                  size: 16,
                                  textAlign: TextAlign.left,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),*/
                    ],
                  ))
                ]),
              ),
            ),
          );
        });
  }

  buildCircularIndicator(List<Nutrition> ntlist) {
    selectedntlist = ntlist;
    for (var i = 0; i < ntlist.length; i++) {
      itemcal = ntlist[i].nutritionData.kcal;
    }
    return CircularPercentIndicator(
      backgroundColor: Color.fromRGBO(242, 244, 255, 1),
      //backgroundColor:appbgColor,
      radius: 140.0,
      lineWidth: 6.0,
      percent: getNutritionPercentage(itemcal),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "$itemcal ",
            color: appbgColor,
            size: 18,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 2,
          ),
          CustomText(
            text: "Kcal",
            color: appbgColor,
            size: 16,
          ),
        ],
      ),
      progressColor: appbgColor,
    );
  }

  getNutritionPercentage(itemcal) {
    double percentage = 0.0;
    try {
      percentage = (itemcal / 600).toDouble();
    } catch (e) {
      percentage = 0;
    }
    if (percentage > 1) {
      percentage = 1;
    } else if (percentage < 0) {
      percentage = 0;
    }
    return percentage;
  }

  buildCategoryRow(List<Nutrition> nutritions) {
    return new Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black12, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(left: 12, top: 5, right: 12, bottom: 5),
        child: new Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            child: getCategoryItems(nutritions), onTap: () {}),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                    onTap: () async {},
                    child: Icon(
                      Icons.close,
                      color: FF6BD295,
                    )),
              ],
            ),
          ),
        ]));
  }

  buildRow(List<AsNutrition> asNutritions, letter, name,
      List<Nutrition> nutritions, kCal, index) {
    print("masterCategoryTypeId::" +
        asNutritions[index].masterCategoryTypeId.toString());
    print("Utils.selectedCat::" + Utils.selectedCat.toString());
    // if(asNutritions[index].masterCategoryTypeId==Utils.selectedCat)
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
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            child: getRowItems(
                                asNutritions, name, nutritions, letter),
                            onTap: () {
                              setState(() {});
                              ntController.selectUnselectCategoryType(index);
                              //  List<Nutrition> ntlist = asNutritions[index].nutritions;

                              if (kCal > 0) {
                                Get.toNamed(Routes.selectFoodPage);
                              } else {
                                Utils.showErrorSnackBar(
                                    "Please set Kcal limit first.");
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                    onTap: () async {
                      ntController.selectUnselectCategoryType(index);
                      // selectUnselectCategoryType(index);
                      Get.toNamed(Routes.addFoodNutritionPage);
                      if (kCal > 0) {
                        Get.toNamed(Routes.addFoodNutritionPage);
                      } else {
                        Utils.showErrorSnackBar("Please set Kcal limit first.");
                      }
                    },
                    child: Icon(
                      Icons.close,
                      color: FF6BD295,
                    )),
              ],
            ),
          ),
        ]));
  }
  Widget buildnutritionCaloryItems(List<Nutrition> ntlist) {
    double prtn = 0;
    double carb = 0;
    double fat = 0;
    int qtype = 1;
    print("buildnutritionCaloryItems:"+ntlist.length.toString());
    try {
      for (var i = 0; i < ntlist.length; i++) {

        print("prtn:"+ntlist[i].nutritionData.nutritionCalory.protein.toString());

        prtn = prtn+ntlist[i].nutritionData.nutritionCalory.protein;

        carb = carb+ntlist[i].nutritionData.nutritionCalory.carbs;
        fat = fat+ntlist[i].nutritionData.nutritionCalory.fat;
        qtype = ntlist[i].nutritionData.quantityType;


      }

    } catch (e) {
      print("error  ${e.toString()}");
    }

      return new Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                    text: "Protein",
                    size: 16,
                    color: Colors.green,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText(
                    text: prtn.toString()+ " " + Utils().getQuatityType(qtype),
                    size: 16,
                    color: Colors.green,
                    textAlign: TextAlign.right,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Carbs",
                    size: 16,
                    color: Colors.deepOrangeAccent,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text:carb.toString()+ " " + Utils().getQuatityType(qtype),
                    size: 16,
                    color: Colors.deepOrangeAccent,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                    text: "Fat",
                    size: 16,
                    textAlign: TextAlign.left,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText(
                    text:fat.toString()+ " " + Utils().getQuatityType(qtype),
                    size: 16,
                    textAlign: TextAlign.left,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18,
        ),
      ]);

  }
  Widget getCategoryItems(List<Nutrition> ntlist) {
    String items = "";
    int qty = 0;
    int qtype = 1;

    try {
      for (var i = 0; i < ntlist.length; i++) {
        items = items + ntlist[i].nutritionData.title + ",";
        itemcal = ntlist[i].nutritionData.kcal;
        qty = ntlist[i].nutritionData.quantity;
        qtype = ntlist[i].nutritionData.quantityType;

        if (items.length > 20) items = items.substring(0, 20);
      }

      if (items.endsWith(",")) {
        items = items.substring(0, items.lastIndexOf(","));
      }

      print("itemcal  ${itemcal}");
      // list.add(new Text(items));
    } catch (e) {
      print("error  ${e.toString()}");
    }
    if (items.length > 0) {
      return new Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 4),
          child: CustomText(
            text: "${items}",
            size: 16,
            color: FF050707,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CustomText(
          text: itemcal.toString().trim() + " kcal",
          size: 14,
          color: FF050707,
          maxLines: 1,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 10,
        ),
        CustomText(
          text: qty.toString() + " " + Utils().getQuatityType(qtype),
          size: 14,
          color: FF050707,
          maxLines: 1,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
        ),
      ]);
    }
  }

  Widget getRowItems(List<AsNutrition> asNutritions, String name,
      List<Nutrition> strings, int title) {
    List<Widget> list = [];

    String items = "";
    try {
      print("title::" + title.toString());

      for (var n = 0; n < asNutritions.length; n++) {
        List<Nutrition> ntlist = asNutritions[n].nutritions;

        for (var i = 0; i < ntlist.length; i++) {
          if (ntlist[i].nutritionData.masterCategoryTypeId == title) {
            items = items + ntlist[i].nutritionData.title + ",";
            if (items.length > 20) items = items.substring(0, 20);
            list.add(new Text(items));
            // list.add(new Text(strings[i].nutritionData.title + ","));
          }
        }
      }

      items = items;

      // list.add(new Text(items));
    } catch (e) {
      print("error  ${e.toString()}");
    }
    if (items.length > 0) {
      return new Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 4),
          child: CustomText(
            text: "${name}",
            size: 16,
            color: FF050707,
            maxLines: 2,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 4, right: 0, bottom: 0, top: 0),
          /*  decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(0),
                color:Colors.white
            ),*/
          child: Text(
            items,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ]);
    } else
      return new Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 4),
          child: CustomText(
            text: "${name}",
            size: 16,
            color: FF050707,
            maxLines: 2,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]);
  }
}
