import 'dart:io';

import 'package:fit_beat/app/data/model/add_post/media_upload_response.dart';
import 'package:fit_beat/app/data/model/master/master_tag_entity.dart'
    as MasterTagEntity;
import 'package:fit_beat/app/data/model/recipe/add_recipe_request_entity.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_food_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodNutritionController extends GetxController {
  final ApiRepository repository;

  List<File> mediaPathList = List();

  AddFoodNutritionController({
    @required this.repository,
  }) : assert(repository != null);

  Rx<Map<String, double>> caloriesMap = Rx({
    "protein": 0,
    "carb": 0,
    "fat": 0,
  });

  List foodDataMap = [
    {"id": 1, "name": "Veg", "color": foodVegColor},
    {"id": 2, "name": "Nonveg", "color": foodNonVegColor},
    {"id": 3, "name": "Eggetarian", "color": foodEggColor},
    {"id": 4, "name": "Vegan", "color": foodVeganColor},
  ];

  List<Color> colorList = [
    Colors.lightGreen,
    Colors.purple,
    Colors.deepOrangeAccent,
  ];

  void setProtein(String value) {
    var data = caloriesMap.value;
    data["protein"] = double.parse(value);
    caloriesMap.value = data;
    update();
  }

  void setCarb(String value) {
    var data = caloriesMap.value;
    data["carb"] = double.parse(value);
    caloriesMap.value = data;
    update();
  }

  void setFat(String value) {
    var data = caloriesMap.value;
    data["fat"] = double.parse(value);
    caloriesMap.value = data;
    update();
  }

  var title = RxString();
  var description = RxString();
  var foodQuantity = RxString();
  var serving = RxString();
  var selectedTag = <MasterTagEntity.Datum>[];
  var selectedFoodTypeId = RxInt();
  var selectedCategoryId = 0;

  var quantityController = TextEditingController();

  var userDetailData = Rx(PrefData().getUserDetailData());
  var masterCategoryEntity = Rx(PrefData().getMasterCategories());

  bool isFoodTypeSelected(int id) => selectedFoodTypeId.value == id;

  /*bool isCategorySelected(int id) => selectedCategoryId.contains(id);*/

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

  void onSelectCategory(int masterCategoryTypeId) {
    selectedCategoryId = masterCategoryTypeId;
    update();
  }

  @override
  void onInit() {
    /*debounce(caloriesMap, (value) => caloriesMap.value = value,
        time: Duration(seconds: 2));*/
    super.onInit();
  }

  void addMedia(BuildContext context) async {
    try {
      PermissionService getPermission = PermissionService.gallery();
      await getPermission.getPermission(context);

      if (getPermission.granted == false) {
        print("permission false");
        //Permission is not granted
        return;
      }

      var file = Platform.isAndroid
          ? await MediaPickerService().pickImageOrVideo()
          : await MediaPickerService().pickImage(source: ImageSource.gallery);
      if (file != null) {
        if (Utils.isFileImageOrVideo(file)) {
          mediaPathList.add(file);
          update();
        } else {
          Utils.showErrorSnackBar("Please select image or video");
        }
      } else {
        Utils.showErrorSnackBar("Please select image or video");
      }
    } catch (_) {
      Utils.showErrorSnackBar("exception");
    }
  }

  void removeMedia(int position) {
    mediaPathList.removeAt(position);
    update();
  }

  void addFood() async {
    if (title.value.isEmpty) {
      Utils.showErrorSnackBar("Please enter recipe name");
    } else if (selectedFoodTypeId == null) {
      Utils.showErrorSnackBar("Please select food type");
    } else if (selectedCategoryId == null) {
      Utils.showErrorSnackBar("Please select category type");
    } else if (quantityController.text.toString().isEmpty) {
      Utils.showErrorSnackBar("Please enter quatity");
    } else if (caloriesMap.value["protein"] == 0) {
      Utils.showErrorSnackBar("Please enter protein");
    } else if (caloriesMap.value["carb"] == 0) {
      Utils.showErrorSnackBar("Please enter carb");
    } else if (caloriesMap.value["fat"] == 0) {
      Utils.showErrorSnackBar("Please enter fat");
    } else if (mediaPathList.length == 0) {
      Utils.showErrorSnackBar("Please add photo");
    } else {
      Get.find<ProgressController>().progress = 0.0;
      Utils.showProgressLoadingDialog();
      var response = await repository.uploadMedia(mediaPathList, 6);
      if (response.status) {
        Utils.dismissLoadingDialog();
        try {
          Utils.showLoadingDialog();

          var selectedMediaUrl = <MediaUrl>[];
          for (MediaUrl mediaUrl in response.url) {
            selectedMediaUrl.add(MediaUrl(mediaUrl: mediaUrl.mediaUrl));
          }

          var foodApiResponse = await repository.addNutritions(
              title: title.value,
              description: description.value,
              foodType: selectedFoodTypeId,
              kcal: getCalories(),
              masterCategoryTypeId: selectedCategoryId,
              quantity: quantityController.text.toString(),
              nutritionMedia: selectedMediaUrl,
              nutritionCalories: Calories(
                protein: caloriesMap.value["protein"],
                carbs: caloriesMap.value["carb"],
                fat: caloriesMap.value["fat"],
              ).toMap());
          Utils.dismissLoadingDialog();
          if (foodApiResponse.status) {
            Get.find<SelectFoodController>().getNutritionFoodList();
            Get.back();
            Utils.showSucessSnackBar(foodApiResponse.message);
          } else {
            Utils.showErrorSnackBar(foodApiResponse.message);
          }
        } catch (e) {
          Utils.dismissLoadingDialog();
          Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
        }
      } else {
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(response.message ?? "Unable to add recipe");
      }
    }
  }
}
