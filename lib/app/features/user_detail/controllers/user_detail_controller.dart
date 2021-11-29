import 'package:fit_beat/app/data/model/master/master_user_details_options_entity.dart';
import 'package:fit_beat/app/data/model/user/set_user_details_request_entity.dart';
import 'package:fit_beat/app/data/model/user/user_detail_entity.dart'
    as UserDetailEntity;
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class UserDetailController extends GetxController {
  final ApiRepository repository;

  //pages
  final controller = PageController(initialPage: 0);
  var scaffoldKey = new GlobalKey<ScaffoldState>();

  UserDetailController({@required this.repository})
      : assert(repository != null);

  final totalPage = 8;
  var currentPage = 1.obs;
  var lastPageReached = 0;

  var userDetailsOptionsEntity = Rx(MasterUserDetailsOptionsEntity());

  //dob
  final dobFormat = new DateFormat("d MMM yyyy");
  final requestDobFormat = new DateFormat("yyyy-MM-dd");

  //height & weight
  var lb = new List<int>.generate(200, (i) => i++);

  //motivation
  var selectedMotivationId = [].obs;

  //interest
  var selectedInterestId = [].obs;

  final currentDate = DateTime.now();

  var selectedHeightUnit = Rx(HEIGHT_UNIT.INCH);
  var selectedWeightUnit = Rx(WEIGHT_UNIT.LB);
  RxString selectedHeight = RxString("4.6");
  RxString selectedWeight = RxString("63");
  RxInt _selectedGender = RxInt();
  RxInt _selectedFood = RxInt();
  RxInt _selectedLevel = RxInt();
  Rx<DateTime> dobValue;
  RxString dobValueLabel;

  int get selectedGender => _selectedGender.value;

  int get selectedFood => _selectedFood.value;

  int get selectedLevel => _selectedLevel.value;

  void incrementLastPageReached(int currentPage) {
    if (lastPageReached < currentPage) lastPageReached++;
  }

  void changeGenderValue(int gender) => _selectedGender.value = gender;

  void changeFoodValue(int food) => _selectedFood.value = food;

  void changeLevelValue(int level) => _selectedLevel.value = level;

  String formattedDob(DateTime dateTime) => dobFormat.format(dateTime);

  bool isMotivationSelected(int id) => selectedMotivationId.contains(id);

  bool isInterestSelected(int id) => selectedInterestId.contains(id);

  @override
  void onInit() {
    dobValue = DateTime(2015, currentDate.month, currentDate.day).obs;
    dobValueLabel = RxString(formattedDob(dobValue.value));
    getUserDetailsOptions();
  }

  void setDob(DateTime dob) {
    var dobBugFix = dob;
    if (dobBugFix.year == currentDate.year) {
      dobBugFix = DateTime(2015, dobBugFix.month, dobBugFix.day);
    }
    dobValue.value = dobBugFix;
    dobValueLabel.value = formattedDob(dobBugFix);
  }

  //region height

  String cm_to_foot(int cm) {
    if (cm == 0) return "0.0";

    var value = (cm / 30.48).toStringAsFixed(2);

    var inch =
        (int.parse(value.substring(value.indexOf(".") + 1, value.length)) *
                0.12)
            .round();
    var foot = (cm / 30.48).floor();

    value = "$foot.$inch";

    print("cm_to_foot => $value");
    return value;
  }

  String foot_to_cm(double foot) {
    var foot_to_string = foot.toString();
    var onlyFoot = foot.toInt();
    var onlyInch = int.parse(foot_to_string.substring(
        foot_to_string.indexOf(".") + 1, foot_to_string.length));

    if (foot == 0.0) return "0";

    var foot_to_cm = (30.48 * onlyFoot);

    var inch_to_cm = (2.54 * onlyInch);

    var result = (foot_to_cm + inch_to_cm).floor().toString();

    print("foot_to_cm => $result");
    return result;
  }

  //endregion

  //region weight
  String lb_to_kg(int lb) {
    if (lb == 0) return "0.0";

    var value = (lb / 2.205).toStringAsFixed(2);
    if (int.parse(value.substring(value.indexOf(".") + 1, value.length)) > 9) {
      value = (lb / 2.205).toStringAsFixed(1);
    }

    print("lb_to_kg => $value");
    return value;
  }

  String kg_to_lb(double kg) {
    if (kg == 0.0) return "0";

    var value = (2.205 * kg).floor().toString();

    print("kg_to_lb => $value");
    return value;
  }

  //endregion

  @override
  void onReady() {}

  @override
  void onClose() {}

  void gotoDobSelectionPage() {
    controller.animateToPage(currentPage.value,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
    this.currentPage.value = 2;
    incrementLastPageReached(2);
  }

  void gotoHeightSelectionPage() {
    controller.animateToPage(currentPage.value,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

    this.currentPage.value = 3;
    incrementLastPageReached(3);
  }

  void gotoWeightSelectionPage() {
    controller.animateToPage(currentPage.value,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

    this.currentPage.value = 4;
    incrementLastPageReached(4);
  }

  void gotoMotivationSelectionPage() {
    controller.animateToPage(currentPage.value,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

    this.currentPage.value = 5;
    incrementLastPageReached(5);
  }

  void gotoFoodPrefSelectionPage() {
    controller.animateToPage(currentPage.value,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

    this.currentPage.value = 6;
    incrementLastPageReached(6);
  }

  void gotoFitnessLevelSelectionPage() {
    controller.animateToPage(currentPage.value,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

    this.currentPage.value = 7;
    incrementLastPageReached(7);
  }

  void gotoInterestSelectionPage() {
    controller.animateToPage(currentPage.value,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

    this.currentPage.value = 8;
    incrementLastPageReached(8);
  }

  void pagerGoBack() {
    print("page => ${this.currentPage.value}");

    if (this.currentPage.value == 1) {
      // Get.offAllNamed(Routes.main);
    } else {
      this.currentPage.value = this.currentPage.value - 1;
      controller.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  void pagerGoForward() {
    this.currentPage.value = this.currentPage.value + 1;
    incrementLastPageReached(this.currentPage.value);
    controller.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<void> getUserDetailsOptions() async {
    try {
      var data = await repository.apiClient.get(
          "http://3.120.65.206:8080/app/v1/getmasterdata",
          headers: {"Authorization": "Bearer ${PrefData().getAuthToken()}"});
      var response = MasterUserDetailsOptionsEntity.fromMap(data);
      userDetailsOptionsEntity.value = response;
      print("Success => $response");
    } on Exception catch (e) {
      print("Error => $e");
    }
  }

  Future<void> updateUserData() async {
    Utils.showLoadingDialog();

    final request = SetUserDetailsRequestEntity(
        gender: selectedGender,
        foodPreference: selectedFood.toString(),
        fitnessLevel: selectedLevel.toString(),
        weight: selectedWeight.value.toString(),
        weightType: selectedWeightUnit.value == WEIGHT_UNIT.LB ? 1 : 2,
        height: selectedHeight.value.toString(),
        heightUnit: selectedHeightUnit.value == HEIGHT_UNIT.INCH ? 1 : 2,
        dateOfBirth: requestDobFormat.format(dobValue.value),
        userInterests: selectedInterestId
            .map((element) => UserInterest(masterInterestId: element))
            .toList(),
        userBrings: selectedMotivationId
            .map((element) => UserBring(masterBringId: element))
            .toList());
    try {
      var data = await repository.apiClient.put(
          "http://3.120.65.206:8080/app/v1/updateuserdata",
          headers: {"Authorization": "Bearer ${PrefData().getAuthToken()}"},
          body: request.toMap());
      print("Success => $data");
      Utils.dismissLoadingDialog();
      Get.back();
      Utils.showSucessSnackBar(data["message"] ?? "Success");
      /*UserDetailEntity.UserDetailData newUserDetailData =
          PrefData().getUserDetailData();
      newUserDetailData.isSetup = 1;
      Get.find<MainController>().setUserDetailData(newUserDetailData);*/
    } on Exception catch (e) {
      print("Error => $e");
      Utils.dismissLoadingDialog();
    }
  }
}

enum HEIGHT_UNIT { INCH, CM }
enum WEIGHT_UNIT { LB, KG }

Future doOnStartup() async {
  await Future.delayed(Duration(milliseconds: 500));
}
