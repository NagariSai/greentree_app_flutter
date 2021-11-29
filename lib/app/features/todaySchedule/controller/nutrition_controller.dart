import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  @override
  void onInit() {
    super.onInit();
    selectedDate = requestDobFormat.format(DateTime.now());
    getNutritionData();
  }

  setCalenderDate(DateTime dateTime) {
    selectedDate = requestDobFormat.format(dateTime);
    getNutritionData();
    update();
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
    currentIndex = index;
    selectedCategoryType = asNutritions[index];
    categoryType = selectedCategoryType.masterCategoryTypeId;
    nutritions = selectedCategoryType.nutritions;
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
}
