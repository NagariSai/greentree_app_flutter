import 'dart:convert';
import 'dart:io';

import 'package:fit_beat/app/data/model/add_post/media_upload_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart' as media;
import 'package:fit_beat/app/data/model/master/master_tag_entity.dart'
    as MasterTagEntity;
import 'package:fit_beat/app/data/model/recipe/add_recipe_request_entity.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/features/recipe/controller/recipe_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipeController extends GetxController {
  final ApiRepository repository;

  List<File> mediaPathList = List();

  AddRecipeController({
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

  Feed feedData;

  void setProtein(String value) {
    var data = caloriesMap.value;
    data["protein"] = double.parse(value == "" ? "0" : value);
    caloriesMap.value = data;
    update();
  }

  void setCarb(String value) {
    var data = caloriesMap.value;
    data["carb"] = double.parse(value == "" ? "0" : value);
    caloriesMap.value = data;
    update();
  }

  void setFat(String value) {
    var data = caloriesMap.value;
    data["fat"] = double.parse(value == "" ? "0" : value);
    caloriesMap.value = data;
    update();
  }

  var title = RxString();
  var description = RxString();
  var cookingDuration = RxString();
  var serving = RxString();
  var selectedTag = <MasterTagEntity.Datum>[];
  var recipeIngredients = <String>[];
  var recipeSteps = <String>[];
  var selectedStringTags = <String>[];
  var selectedFoodTypeId = RxInt();
  RxInt selectedCuisineId = RxInt();
  var selectedCategoryId = <int>[].obs;

  var userDetailData = Rx(PrefData().getUserDetailData());
  var masterTagEntity = Rx(PrefData().getMasterTags());
  var masterCuisineEntity = Rx(PrefData().getMasterCuisines());
  var masterCategoryEntity = Rx(PrefData().getMasterCategories());

  final TextEditingController descController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController servingController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  List<media.UserMedia> mediaUrlList = [];

  bool isFoodTypeSelected(int id) => selectedFoodTypeId.value == id;

  bool isCuisineSelected(int id) => selectedCuisineId.value == id;

  bool isCategorySelected(int id) => selectedCategoryId.contains(id);

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

  @override
  void onInit() {
    /*debounce(caloriesMap, (value) => caloriesMap.value = value,
        time: Duration(seconds: 2));*/
    super.onInit();

    feedData = Get.arguments;
    print("feed $feedData");
    if (feedData != null) setData();
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

  void tagSelectionLogic() {
    List<String> all_selected = selectedStringTags;

    var all_suggested_as_string =
        masterTagEntity.value.data.map((e) => e.title);

    var selected_and_suggested = all_suggested_as_string
        .where((element) => all_selected.contains(element));

    var selected_but_not_suggested = all_selected
        .where((element) => !selected_and_suggested.contains(element));

    var selected_and_suggested_object = masterTagEntity.value.data
        .where((element) => selected_and_suggested.contains(element.title))
        .toList();

    selected_but_not_suggested.forEach((element) {
      print(element);
      selected_and_suggested_object
          .add(MasterTagEntity.Datum(title: element, masterTagId: 0));
    });

    print("selected_and_suggested_object => : $selected_and_suggested_object");
    selectedTag = selected_and_suggested_object;
  }

  Future<void> recipesData() async {
    //todo
    tagSelectionLogic();
    print("cal ${caloriesMap.value["fat"]}");

    if (title.value != null &&
        title.value.isNotEmpty &&
        description.value != null &&
        description.value.isNotEmpty &&
        selectedCuisineId.value != null &&
        selectedFoodTypeId.value != null &&
        cookingDuration.value.isNotEmpty &&
        mediaPathList.length + mediaUrlList.length > 0 &&
        serving.value != null &&
        serving.value.isNotEmpty &&
        selectedTag.length > 0 &&
        recipeIngredients.length > 0 &&
        recipeSteps.length > 0 &&
        selectedCategoryId != null &&
        selectedCategoryId.length > 0 &&
        caloriesMap.value["protein"] != 0.0 &&
        caloriesMap.value["carb"] != 0.0 &&
        caloriesMap.value["fat"] != 0.0) {
      Get.find<ProgressController>().progress = 0.0;
      Utils.showProgressLoadingDialog();

      var response = await repository.uploadMedia(mediaPathList, 4);
      if (response.status) {
        Utils.dismissLoadingDialog();

        Utils.showLoadingDialog();
        List<MediaUrl> mediaUrl = [];
        mediaUrl.addAll(response.url);
        for (media.UserMedia data in mediaUrlList) {
          mediaUrl.add(MediaUrl(
              mediaType: data.mediaType,
              mediaUrl: data.mediaUrl,
              userMediaId: data.userMediaId));
        }
        final request = AddRecipeRequestEntity(
            title: title.value,
            recipeId: feedData == null ? 0 : feedData.uniqueId,
            description: description.value,
            masterCuisineId: selectedCuisineId.value,
            foodType: selectedFoodTypeId.value,
            masterCategoryId: selectedCategoryId,
            cookingDuration: cookingDuration.value,
            servings: serving.value,
            userTags: selectedTag
                .map((element) => UserTag(
                    title: element.title,
                    masterTagId:
                        element.masterTagId != null ? element.masterTagId : 0))
                .toList(),
            calories: Calories(
              protein: caloriesMap.value["protein"],
              carbs: caloriesMap.value["carb"],
              fat: caloriesMap.value["fat"],
            ),
            userMedia: mediaUrl,
            userRecipeIngredients: recipeIngredients
                .map((element) => UserRecipeIngredient(
                      title: element,
                    ))
                .toList(),
            userRecipePreparationSteps: recipeSteps
                .map((element) =>
                    UserRecipePreparationStep(description: element))
                .toList());

        try {
          var data = feedData == null
              ? await repository.apiClient.post(
                  "http://3.120.65.206:8080/app/v1/recipessdata",
                  headers: {
                    "Authorization": "Bearer ${PrefData().getAuthToken()}"
                  },
                  body: request.toMap())
              : await repository.apiClient.put(
                  "http://3.120.65.206:8080/app/v1/recipessdata",
                  headers: {
                    "Authorization": "Bearer ${PrefData().getAuthToken()}"
                  },
                  body: jsonEncode(request.toMap()));
          print("Success => $data");
          if (!PrefData().isCoach()) {
            Get.find<HomeController>()?.refreshFeeds();
            Get.find<RecipeController>()?.refreshFeeds();
          }
          Utils.dismissLoadingDialog();
          Get.back();
          Utils.showSucessSnackBar(data["message"] ?? "Recipe added");
        } on Exception catch (e) {
          print("Error => $e");
          Utils.dismissLoadingDialog();
          Utils.showErrorSnackBar("Unable to add recipe");
        }
      } else {
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(response.message ?? "Unable to add recipe");
      }
    } else {
      Utils.showErrorSnackBar("Fields cannot be empty");
    }
  }

  void setData() {
    description.value = feedData.descriptions;
    descController.text = description.value;
    title.value = feedData.title;
    titleController.text = title.value;
    mediaUrlList = feedData.userMedia;
    selectedStringTags = feedData.userTags.map((e) => e.title).toList();
    print(feedData.foodType is int);
    selectedFoodTypeId.value = feedData.foodType;
    selectedCuisineId.value = feedData.masterCuisineId;
    selectedCategoryId.value = getSelectedCategory();
    cookingDuration.value = feedData.cookingDuration;
    durationController.text = cookingDuration.value;
    serving.value = feedData.servings.toString();
    servingController.text = serving.value;
    recipeIngredients = getSelectedIngredients();
    recipeSteps = getSelectedSteps();

    if (feedData.userRecipeColories != null) {
      var data = caloriesMap.value;

      var protein = feedData.userRecipeColories[0].protein.toString() == ""
          ? "0"
          : feedData.userRecipeColories[0].protein.toString();
      data["protein"] = double.parse(protein);
      proteinController.text = protein;
      var carbs = feedData.userRecipeColories[0].carbs.toString() == ""
          ? "0"
          : feedData.userRecipeColories[0].carbs.toString();
      carbsController.text = carbs;

      data["carb"] = double.parse(carbs);
      var fats = feedData.userRecipeColories[0].fat.toString() == ""
          ? "0"
          : feedData.userRecipeColories[0].fat.toString();
      fatController.text = carbs;

      data["fat"] = double.parse(fats);
      caloriesMap.value = data;
    }
  }

  List<int> getSelectedCategory() {
    List<int> ids = [];
    for (UserRecipeCategory cat in feedData.userRecipeCategory) {
      if (cat.masterCategoryId != null) {
        ids.add(cat.masterCategoryId);
      }
    }
    return ids;
  }

  List<String> getSelectedIngredients() {
    List<String> ids = [];
    for (UserRecipeIngredient cat in feedData.userRecipeIngredients) {
      if (cat.user_recipe_ingredient_id != null) {
        ids.add(cat.user_recipe_ingredient_id.toString());
      }
    }
    return ids;
  }

  List<String> getSelectedSteps() {
    List<String> ids = [];
    for (UserRecipePreparationStep cat in feedData.userRecipePreparationSteps) {
      if (cat.description != null) {
        ids.add(cat.description);
      }
    }
    return ids;
  }

  void removeUrlMedia(int position) {
    mediaUrlList.removeAt(position);
    update();
  }
}
