import 'package:fit_beat/app/data/model/coach_review_model.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CoachRatingController extends GetxController {
  final ApiRepository repository;

  CoachRatingController({@required this.repository});

  int pageNo = 1;
  int pageRecord = 10;
  var coachProfileId;

  var isLoading = false;
  List<CoachReview> coachReviewList = [];
  var ratingCount;
  var count = 0;

  @override
  void onInit() {
    super.onInit();
    coachProfileId = Get.arguments[0];
    ratingCount = Get.arguments[1];
    getCoachReview();
  }

  getCoachReview() async {
    isLoading = true;
    try {
      var response = await repository.getCoachReview(
          pageRecord: pageRecord, pageNo: pageNo, coachUserId: coachProfileId);
      isLoading = false;
      if (response.status) {
        coachReviewList = response.data.rows;
        count = response.data.count;
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    update();
  }

  var userRating;
  TextEditingController reviewController = TextEditingController();
  giveCoachRating() async {
    try {
      if (userRating == null) {
        Utils.showErrorSnackBar("Please give rating.");
      } else if (reviewController.text.toString().isBlank) {
        Utils.showErrorSnackBar("Please give review.");
      } else {
        Utils.showLoadingDialog();
        var response = await repository.giveCoachRating(
          coachUserId: coachProfileId,
          rating: userRating,
          review_content: reviewController.text.toString(),
        );
        getCoachReview();
        Utils.dismissLoadingDialog();
        if (response.status) {
          Get.back();
          Utils.showSucessSnackBar(response.message);
        } else {
          Utils.showErrorSnackBar(response.message);
        }
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
    }
  }
}
