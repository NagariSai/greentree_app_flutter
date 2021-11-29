import 'dart:convert';

import 'package:fit_beat/app/constant/api_endpoint.dart';
import 'package:fit_beat/app/data/model/common_response.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_food_controller.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class FoodBottomController extends GetxController {
  double protein;
  double carbs;
  double fat;

  @override
  void onInit() {
    super.onInit();
    qtyController.text = nutrition.quantity.toString() ?? "0";
    protein = nutrition.nutritionCalory.protein ?? 0.0;
    carbs = nutrition.nutritionCalory.carbs ?? 0.0;
    fat = nutrition.nutritionCalory.fat ?? 0.0;
    updateCalories();
  }

  final ApiRepository repository;
  final NutritionData nutrition;
  final int index;
  bool isValueChange = false;

  Map<String, double> data = {};
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

  void updateCalories() {
    data["protein"] = protein;
    data["carb"] = carbs;
    data["fat"] = fat;
    caloriesMap.value = data;
  }

  FoodBottomController({@required this.repository, this.nutrition, this.index})
      : assert(repository != null);

  TextEditingController qtyController = TextEditingController();

  int getCalories() {
    /*
    1 gram of carbohydrates = 4 kilocalories.
    1 gram of protein = 4 kilocalories.
    1 gram of fat = 9 kilocalories.
    In addition to carbohydrates, protein and fat, alcohol can also provide energy (1 gram alcohol = 7 kilocalories)
    */

    if (isValueChange) {
      return ((protein * 4) + (carbs * 4) + (fat * 9)).toInt();
    } else {
      return nutrition.kcal;
    }
  }

  ///Food Qty Change
  onFoodQtyChange(String value) {
    if (value.length > 0) {
      double enterQty = double.parse(qtyController.text.toString());
      fat = (enterQty * nutrition.nutritionCalory.fat) / nutrition.quantity;
      carbs = (enterQty * nutrition.nutritionCalory.carbs) / nutrition.quantity;
      protein =
          (enterQty * nutrition.nutritionCalory.protein) / nutrition.quantity;
      isValueChange = true;
    }
    update();
  }

  updateFoodQty(bool isFromTodaySchdule) async {
    if (!isFromTodaySchdule) {
      try {
        var usetSchduleActivityId =
            Get.find<NutritionController>().userScheduleId ?? 0;
        var qty = int.parse(qtyController.text.toString());

        if (qtyController.text.isEmpty) {
          Utils.showErrorSnackBar("Enter food qty");
        } else {
          Utils.showProgressLoadingDialog();
          CommonResponse response =
              await repository.updateQty(qty, usetSchduleActivityId);
          if (response.status) {
            //Get.find<SelectFoodController>().getNutritionFoodList();
            Get.find<SelectFoodController>().nutritionFoodList[index].quantity =
                int.parse(qtyController.text);
            Get.find<SelectFoodController>().update();
            Utils.dismissLoadingDialog();
            Get.back();
            Utils.showSucessSnackBar(response.message);
          } else {
            Utils.dismissLoadingDialog();
            Get.back();
            Utils.showSucessSnackBar(response.message);
          }
        }
      } catch (e) {
        print("error : ${e.toString()}");
        Utils.dismissLoadingDialog();
      }
    } else {
      Get.back();
    }
  }

/*
 Future<List<Serving>> fetchServings(String food_id) async {
    var header = new Map<String, String>();
    var body = new Map<String, Object>();
    body["food_id"] = food_id;
    header["secret"] = "c78facccdc8f4aa6bb0ffef7ff0d7d42";
    header["token"] = "e7f48371c00549f1ab1248c09071f167";
    final response =
    await repository.apiClient.post(
      ApiEndpoint.getServings,
      headers: header,
      body: body,
    );
    var data = jsonDecode(response.body);
    print(data["code"]);
    print(data["message"]);
    if (data["code"] == 200) {
      List jsonResponse = data["serving"] as List;
      // List jsonResponse = json.decode(response.body);
    //  print(jsonResponse);


    }
  }
*/
}

/*
class Serving {
  String serving_id;
  String serving_description;

  Serving({
    this.serving_id,
    this.serving_description,

  });
  factory Serving.fromJson(Map<String, dynamic> json) => Serving(
    serving_id: json["serving_id"],
    serving_description: json["serving_description"],

  );
  Map<String, dynamic> toJson() => {
    "id": serving_id,
    "name": serving_description,

  };



  @override
  String toString() {
    return '{ ${this.serving_id}, ${this.serving_description} }';
  }
}
*/
