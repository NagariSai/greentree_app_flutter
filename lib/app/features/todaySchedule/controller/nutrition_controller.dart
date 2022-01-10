import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NutritionController extends GetxController {
  final ApiRepository repository;

  NutritionController({@required this.repository}) : assert(repository != null);

  var selectedDate;
  final requestDobFormat = new DateFormat("yyyy-MM-dd");

  var kCal = 0;
  var kCalIntake = 0;
  var totalProteins = 0.0;
  var totalCarbs = 0.0;
  var totalFats = 0.0;
  var scheduleDate;

  AsNutrition selectedCategoryType;

  int categoryType;

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
  DateTime focusedDay = DateTime.now();

  var userScheduleId;
  bool isLoading = true;
  List<AsNutrition> asNutritions = [];
  List<Nutrition> nutritions = [];

  int currentIndex = 0;
  List<NutritionData> nutritionFoodList = [];
  @override
  void onInit() {
    super.onInit();
    selectedDate = requestDobFormat.format(DateTime.now());
   getNutritionData();
  //  getDefaultNutritionFoodList();
  }


  setCalenderDate(DateTime dateTime) {
    selectedDate = requestDobFormat.format(dateTime);
    getNutritionData();
    update();
  }
  void getDefaultNutritionFoodList() async {
    try {
      isLoading = true;
      var response = await repository.getNutritionData(
          pageNo: 1,
          pageRecord: 1,
          foodType: 1,
          masterCategoryTypeId: 0,
          search: "");
      isLoading = false;
      if (response.status) {
        if (response.data != null &&
            response.data.rows != null &&
            response.data.rows.isNotEmpty) {

          nutritionFoodList.addAll(response.data.rows);
        }
      }

    } catch (e) {
      isLoading = false;


      print("error search ${e.toString()}");
    }
  }
  void getNutritionData() async {
    try {
      kCal = 0;
      kCalIntake = 0;
      asNutritions = [];
      nutritions = [];
      isLoading = true;
      var response = await repository.getScheduleActivityListForNutrition(
          startDate: selectedDate, endDate: selectedDate);
      isLoading = false;
      if (response.status &&
          response.data != null &&
          response.data.length > 0) {
        userScheduleId = response.data[0].userScheduleId;
        asNutritions = response.data[0].asNutritions;
        kCalIntake = response.data[0].completeKcal ?? 0;
        kCal = response.data[0].setKcal ?? 0;
        totalProteins = response.data[0].protein ?? 0;
        totalCarbs = response.data[0].carbs ?? 0;
        totalFats = response.data[0].fat ?? 0;
        selectUnselectCategoryType(currentIndex);
        scheduleDate= new DateFormat("dd MMMM , yyyy").format(response.data[0].scheduleDate);
      }
      print("userScheduleId 1: ${userScheduleId}");
      update();
    } catch (e) {
      isLoading = false;
      asNutritions = [];
      update();
      print("mayday ${e.toString()}");
    }
  }

  deleteNutritionInScheduleActivity(
      var userScheduleId, var userScheduleActivityId) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.deleteScheduleActivity(
          userScheduleId: userScheduleId,
          activityType: 1,
          userScheduleActivityId: userScheduleActivityId);
      Utils.dismissLoadingDialog();
      if (response.status) {
        getNutritionData();
        Utils.showSucessSnackBar(response.message);
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      print("error ${e.toString()}");
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
    }
  }

  selectUnselectCategoryType(int index) {

    print("selectUnselectCategoryType::"+index.toString());
    currentIndex = index;
    selectedCategoryType = asNutritions[index];
    categoryType = selectedCategoryType.masterCategoryTypeId;
    nutritions = selectedCategoryType.nutritions;
    Utils.selectedCat=selectedCategoryType.masterCategoryTypeId;
    print("selected::"+Utils.selectedCat.toString());
   // print(categoryType);
    update();
  }

  bool isEaten = false;

  onChangeOnEaten(bool isEaten, var userScheduleActivityId) async {
    this.isEaten = isEaten;
    update();
    if (isEaten) {
      var result = await DialogUtils.customDialog(
          title: "Delete",
          description: "Have you eaten this food? ",
          firstButtonTitle: "Yes, Eaten",
          secondButtonTitle: "Cancel");
      if (result) {
        try {
          Utils.showLoadingDialog();
          var response = await repository.scheduleActivityComplete(
              userScheduleId: userScheduleId,
              activityType: 1,
              isComplete: 1,
              userScheduleActivityId: userScheduleActivityId);
          Utils.dismissLoadingDialog();
          if (response.status) {
            getNutritionData();
            Utils.showSucessSnackBar(response.message);
          } else {
            Utils.showErrorSnackBar(response.message);
          }
        } catch (e) {
          print("error ${e.toString()}");
          Utils.dismissLoadingDialog();
          Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
        }
      }
    }
  }

  updateKcal() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.scheduleActivityCalories(
          scheduleDate: selectedDate,
          userScheduleId: userScheduleId ?? 0,
          kCal: kCal);
      Utils.dismissLoadingDialog();
      if (response.status) {
        getNutritionData();
        Utils.showSucessSnackBar(response.message);
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  bool isCalExceed = false;

  getNutritionPercentage() {
    isCalExceed = false;
    double percentage = 0.0;
    try {
      percentage = (kCalIntake / kCal).toDouble();
    } catch (e) {
      percentage = 0;
    }
    if (percentage > 1) {
      percentage = 1;
      isCalExceed = true;
    } else if (percentage < 0) {
      percentage = 0;
    }
    return percentage;
  }

  Rx<Map<String, double>> caloriesMap = Rx({
    "protein": 0,
    "carb": 0,
    "fat": 0,
  });

  List<Color> colorList = [
    Colors.lightGreen,
    Colors.purple,
    Colors.deepOrangeAccent,
  ];


  Widget nutritionBody() {

    return new Container(


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
            percent: getNutritionPercentage(),
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "${kCalIntake}",
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
                  text: "${kCal} Kcal",
                  color: FF050707,
                  size: 12,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            progressColor:
            isCalExceed ? FFFF9B91 : FF6BD295,
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
                   // setState(() {
                      kCal = int.parse(result);
                      updateKcal();
                   // });
                  }
                },

                child: CustomText(
                  text: "Set Kcal Limit",
                  size: 13,
                  color: customTextColor,
                ),
              ),
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
                      percent: totalProteins,
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
                      text: totalProteins.toStringAsFixed(1),
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
                      percent: totalCarbs,
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
                      text: totalCarbs.toStringAsFixed(1),
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
                      percent: totalFats,
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
                      text: totalFats.toStringAsFixed(1),
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
        ],

      ),




    );

  }

}
