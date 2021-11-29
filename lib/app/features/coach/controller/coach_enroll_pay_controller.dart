import 'package:fit_beat/app/data/model/category_plan_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach/controller/coach_detail_controller.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachEnrollPayController extends GetxController {
  final ApiRepository repository;

  CoachEnrollPayController({@required this.repository});

  FitnessCategoryPlan plan;
  String title;
  TextEditingController reviewController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    plan = Get.arguments[0];
    title = Get.arguments[1] ?? "";
  }

  void setUserCoachEnrollment() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.setUserCoachEnrollment(
        fitnessCategoryId: Get.find<CoachDetailsController>().fitnessCategoryId,
        coachUserId: Get.find<CoachDetailsController>().coachProfileId,
        fitnessCategoryPlanId: plan.fitnessCategoryPlanId,
        finalAmount: plan.rate,
        requestNote: reviewController.text.toString(),
        isEnroll: Get.find<CoachDetailsController>().coachProfile.isBtn,
      );
      Utils.dismissLoadingDialog();
      if (response.status) {
        if (Get.find<CoachDetailsController>().isEnroll) {
          Get.back();
          Utils.showSucessSnackBar(response.message);
        } else {
          Get.back();
          Utils.showSucessSnackBar(response.message);
          DialogUtils.sendRequestDialog();
        }
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      print("error ${e.toString()}");
      Utils.dismissLoadingDialog();
      Get.back();
      Utils.showErrorSnackBar(e.toString());
    }
  }
}
