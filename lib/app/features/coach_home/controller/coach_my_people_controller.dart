import 'package:fit_beat/app/data/model/coach_enroll_user_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_filter_type.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachMyPeopleController extends GetxController {
  final ApiRepository repository;

  CoachMyPeopleController({@required this.repository})
      : assert(repository != null);

  List<FeedFilterType> statusFilterList = List();
  FeedFilterType selectedStatusFilterType;

  bool isLoading = true;
  String startDate = "";
  String endDate = "";
  int status = 1;
  int fitnessCategoryId = 0;
  int pageNo = 1;
  int pageRecord = 20;
  List<CoachEnrollUser> coachEnrollUserList = [];

  @override
  void onInit() {
    super.onInit();
    getStatusList();
    getCoachEnrollUserList();
  }

  void getStatusList() {
    statusFilterList = List();
    statusFilterList
        .add(FeedFilterType(isSelected: true, title: "On Going", type: 1));
    statusFilterList
        .add(FeedFilterType(isSelected: false, title: "Pending", type: 2));
    statusFilterList
        .add(FeedFilterType(isSelected: false, title: "Completed", type: 3));
    statusFilterList
        .add(FeedFilterType(isSelected: false, title: "Switched", type: 4));
    selectedStatusFilterType = statusFilterList[0];
  }

  void getStatusFilteredFeed(int index) async {
    try {
      statusFilterList.forEach((element) {
        element.isSelected = false;
      });
      selectedStatusFilterType = statusFilterList[index];
      selectedStatusFilterType.isSelected = true;
      status = selectedStatusFilterType.type;
      coachEnrollUserList = [];
      update();
      filterChangeCoachEnrollList();
      update();
    } on Exception catch (e) {
      print("Error => $e");
    }
  }

  void filterChangeCoachEnrollList() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.getCoachEnrollUserList(
          startDate: startDate,
          endDate: endDate,
          status: status,
          fitnessCategoryId: fitnessCategoryId,
          pageNo: pageNo,
          pageRecord: pageRecord,
          fitnessCategoryPackageId: []);
      Utils.dismissLoadingDialog();
      if (response.status) {
        coachEnrollUserList.clear();
        coachEnrollUserList = response.data.rows;
        update();
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  void getCoachEnrollUserList() async {
    try {
      isLoading = true;
      var response = await repository.getCoachEnrollUserList(
          startDate: startDate,
          endDate: endDate,
          status: status,
          fitnessCategoryId: fitnessCategoryId,
          pageNo: pageNo,
          pageRecord: pageRecord,
          fitnessCategoryPackageId: []);
      isLoading = false;
      if (response.status) {
        coachEnrollUserList = response.data.rows;
        update();
      }
    } catch (e) {
      isLoading = false;
      coachEnrollUserList = [];
      update();
    }
  }
}
