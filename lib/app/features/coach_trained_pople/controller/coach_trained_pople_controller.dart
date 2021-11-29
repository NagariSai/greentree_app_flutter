import 'package:fit_beat/app/data/model/coach_trained_people.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachTrainedPopleController extends GetxController {
  final ApiRepository repository;

  CoachTrainedPopleController({@required this.repository})
      : assert(repository != null);

  List<CoachTrained> trainedPopleList = [];
  int pageLimit = 10;
  bool feedLastPage = false;
  int pageNo = 1;
  var indicator = new GlobalKey<RefreshIndicatorState>();
  bool isRefresh = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController trainedPeopleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCoachTrainedPeopleData();
  }

  void getCoachTrainedPeopleData() async {
    try {
      if (pageNo == 1 && !isRefresh) {
        _isLoading = true;
        update();
      }

      var response = await repository.getCoachTrainedPeople(
          pageRecord: pageLimit,
          pageNo: pageNo,
          search: trainedPeopleController.text.toString() ?? "");

      if (response.status) {
        if (response.data != null && response.data.rows != null) {
          print("data");
          if (pageNo == 1) {
            trainedPopleList.clear();
          }
          trainedPopleList.addAll(response.data.rows);
        } else {
          feedLastPage = true;
        }
      }
      if (pageNo == 1 && !isRefresh) {
        _isLoading = false;
      }
      update();
      isRefresh = false;
    } on Exception catch (e) {
      _isLoading = false;
      isRefresh = false;
      update();
      print("Error => $e");
    }
  }

  void loadNext() {
    pageNo++;
    getCoachTrainedPeopleData();
  }

  void clearSearch() {
    trainedPeopleController.text = "";
    update();
    getCoachTrainedPeopleData();
  }
}
