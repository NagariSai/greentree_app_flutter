import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectFoodController extends GetxController {
  final ApiRepository repository;

  SelectFoodController({@required this.repository})
      : assert(repository != null);

  var selectedFoodType;

  bool isLoading = true;
  bool isSearching = false;

  TextEditingController searchController = TextEditingController();

  var pageNo = 1;
  var pageRecord = 10;

  List<NutritionData> nutritionFoodList = [];

  bool isAddClick = false;
  int addedCount = 0;
  var userScheduleId;
  var scheduleDate;
  var masterCategoryId;
  var kCal;
  bool feedLastPage = false;

  List<NutritionScheduleActivityInput> input = [];

  @override
  void onInit() {
    super.onInit();
    selectedFoodType = foodDataMap[0];
    userScheduleId = Get.find<NutritionController>().userScheduleId ?? 0;
    scheduleDate = Get.find<NutritionController>().selectedDate;
    masterCategoryId = Get.find<NutritionController>().categoryType;
    kCal = Get.find<NutritionController>().kCal;
    getNutritionFoodList();
    print("onInit"+"getNutritionFoodList");

  }

  List foodDataMap = [
    /*{"id": -1, "name": "All", "color": primaryColor, "isSelected": true},*/
    {"id": 1, "name": "Veg", "color": foodVegColor, "isSelected": false},
    {"id": 2, "name": "Nonveg", "color": foodNonVegColor, "isSelected": false},
    {"id": 3, "name": "Eggetarian", "color": foodEggColor, "isSelected": false},
    {"id": 4, "name": "Vegan", "color": foodVeganColor, "isSelected": false},
  ];

  selectUnselectFoodType(int index) {
    selectedFoodType = foodDataMap[index];
    onSearchChange();
    update();
  }

  List<Color> colorList = [
    Colors.lightGreen,
    Colors.purple,
    Colors.deepOrangeAccent,
  ];

  Rx<Map<String, double>> caloriesMap = Rx({
    "protein": 0,
    "carb": 0,
    "fat": 0,
  });

  double getCalories() {
    /*
    1 gram of carbohydrates = 4 kilocalories.
    1 gram of protein = 4 kilocalories.
    1 gram of fat = 9 kilocalories.
    In addition to carbohydrates, protein and fat, alcohol can also provide energy (1 gram alcohol = 7 kilocalories)
    */

    final protein = caloriesMap.value["protein"];
    final carb = caloriesMap.value["carb"];
    final fat = caloriesMap.value["fat"];

    final kcal = (protein * 4) + (carb * 4) + (fat * 9);
    return kcal;
  }

  void getNutritionFoodList() async {
    try {
      isLoading = true;
      String search = searchController.text.toString().trim();
      var response = await repository.getNutritionData(
          pageNo: pageNo,
          pageRecord: pageRecord,
          foodType: selectedFoodType['id'],
          masterCategoryTypeId: Utils.selectedCat,
          search: search);
      isLoading = false;
      if (response.status) {
        if (response.data != null &&
            response.data.rows != null &&
            response.data.rows.isNotEmpty) {
          if (pageNo == 1) {
            nutritionFoodList.clear();
          }
          nutritionFoodList.addAll(response.data.rows);
        } else {
          feedLastPage = true;
        }
      }
      update();
    } catch (e) {
      isLoading = false;
      feedLastPage = false;
      update();
      print("error search ${e.toString()}");
    }
  }



  void loadNextFeed() {
    print("loadNextFeed");
    pageNo++;
    getNutritionFoodList();
  }

  onSearchChange() async {
    try {
      isSearching = true;
      feedLastPage = false;
      pageNo = 1;
      update();
      var response = await repository.getNutritionData(
          pageNo: pageNo,
          pageRecord: pageRecord,
          foodType: selectedFoodType['id'],
          masterCategoryTypeId: 0,
          search: searchController.text.toString());
      isLoading = false;
      if (response.status) {
        if (response.data != null &&
            response.data.rows != null &&
            response.data.rows.isNotEmpty) {
          if (pageNo == 1) {
            nutritionFoodList.clear();
          }
          nutritionFoodList.addAll(response.data.rows);
        } else {
          feedLastPage = true;
        }
      }
      isSearching = false;
      update();
    } catch (e) {
      isSearching = false;
      update();
    }
  }

  onClearSearch() {
    searchController.text = "";
    feedLastPage = false;
    onSearchChange();
  }

  onAddRemoveClick(bool isAddClick, var nutritionId, int index) {
    // isAddClick = !isAddClick;
    print("index : $index");
    bool isDuplicate = false;
    if (isAddClick) {
      for (int i = 0; i < input.length; i++) {
        if (input[i].nutritionId == nutritionId) {
          isDuplicate = true;
          break;
        }
      }
      if (!isDuplicate) {
        addedCount += 1;
        input.add(NutritionScheduleActivityInput(
            nutritionId: nutritionId,
            userScheduleActivityId: 0,
            isDeleted: 0,
            quantity: nutritionFoodList[index].quantity,
            masterCategoryId: masterCategoryId));
      }
    } else {
      addedCount -= 1;
      print("input 1: ${input.length}");
      input.removeWhere((item) => item.nutritionId == nutritionId);
    }
    update();
    print("input 2: ${input.length}");
  }

  updateUi() {
    update();
  }

  addNutritionInScheduleActivity() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.addScheduleActivityForNutrition(
          userScheduleId: userScheduleId,
          isKcal: 0,
          scheduleDate: scheduleDate,
          nutritions: input,
          masterCategoryTypeId: masterCategoryId,
          setKcal: kCal);
      Utils.dismissLoadingDialog();
      if (response.status) {
        Get.find<NutritionController>().getNutritionData();
        Get.back();
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

class NutritionScheduleActivityInput {
  NutritionScheduleActivityInput(
      {this.userScheduleActivityId,
      this.nutritionId,
      this.isDeleted,
      this.masterCategoryId,
      this.quantity,
      this.kcal});

  int userScheduleActivityId;
  int nutritionId;
  int isDeleted;
  int masterCategoryId;
  var quantity;
  var kcal;

  factory NutritionScheduleActivityInput.fromJson(Map<String, dynamic> json) =>
      NutritionScheduleActivityInput(
        kcal: json["kcal"] == null ? null : json["kcal"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        userScheduleActivityId: json["user_schedule_activity_id"] == null
            ? null
            : json["user_schedule_activity_id"],
        masterCategoryId: json["master_category_type_id"] == null
            ? null
            : json["master_category_type_id"],
        nutritionId: json["nutrition_id"] == null ? null : json["exercise_id"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "kcal": kcal == null ? null : kcal,
        "quantity": quantity == null ? null : quantity,
        "user_schedule_activity_id":
            userScheduleActivityId == null ? null : userScheduleActivityId,
        "nutrition_id": nutritionId == null ? null : nutritionId,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "master_category_type_id":
            masterCategoryId == null ? null : masterCategoryId,
      };
}
