import 'package:fit_beat/app/data/model/category_plan_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CoachEnrollRequestController extends GetxController {
  final ApiRepository repository;

  CoachEnrollRequestController({@required this.repository});

  var fitnessCategoryId;
  var coachUserId;

  bool isLoading = true;

  List<CategoryPlan> categoryPlan = [];

  @override
  void onInit() {
    super.onInit();
    fitnessCategoryId = Get.arguments[0];
    coachUserId = Get.arguments[1];
    getCategoryPlan();
  }

  void getCategoryPlan() async {
    try {
      isLoading = true;
      var response = await repository.getCategoryPlan(
          coachUserId: coachUserId, fitnessCategoryId: fitnessCategoryId);
      isLoading = false;
      if (response.status) {
        categoryPlan = response.data;
      }
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
  }
}
