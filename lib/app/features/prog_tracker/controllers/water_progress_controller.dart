import 'package:fit_beat/app/data/model/water_model.dart';
import 'package:fit_beat/app/data/model/water_progress_track.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class WaterProgressController extends GetxController {
  final ApiRepository repository;

  WaterProgressController({@required this.repository})
      : assert(repository != null);

  List<WaterModel> waterLevelList = [];

  WaterProgress water;
  bool isLoading = true;
  var selectedDate;
  final requestDobFormat = new DateFormat("yyyy-MM-dd");
  int selectedWaterLevelId = -1;
  TimeOfDay reminderStartTime;
  TimeOfDay reminderEndTime;
  String displayReminderStartTime = "";
  String displayReminderEndTime = "";
  bool isDateChange = false;
  int waterReminderValue = -1;

  var userScheduleId;

  final TextEditingController weightController =
      TextEditingController(text: "");
  @override
  void onInit() {
    super.onInit();
    selectedDate = requestDobFormat.format(DateTime.now());
    setWaterLevelList();
    getScheduleActivityForWater();
  }

  resetAll() {
    selectedWaterLevelId = -1;
    reminderStartTime = null;
    reminderEndTime = null;
    waterReminderValue = -1;
    displayReminderStartTime = "";
    displayReminderEndTime = "";
    water = null;
    weightController.text = "";
    userScheduleId = 0;
  }

  setCalenderDate(DateTime dateTime) async {
    selectedDate = requestDobFormat.format(dateTime);
    isDateChange = true;
    resetAll();
    update();
    try {
      var response = await repository.getWaterProgress(
        startDate: selectedDate,
      );
      isDateChange = false;
      if (response.status) {
        onSuccess(response);
      }
      update();
    } catch (e) {
      print("water error : ${e.toString()}");

      isDateChange = false;
      update();
    }
  }

  void getScheduleActivityForWater() async {
    try {
      isLoading = true;
      var response = await repository.getWaterProgress(
        startDate: selectedDate,
      );
      isLoading = false;

      if (response.status) {
        onSuccess(response);
      }

      update();
    } catch (e) {
      print("water error : ${e.toString()}");
      isLoading = false;
    }
  }

  void onSuccess(WaterProgressResponse response) {
    try {
      print("water succ");

      if (response.status && response.data != null) {
        water = response.data;

        selectedWaterLevelId =
            water.waterLevel != null && water.waterLevel != ""
                ? int.parse(water.waterLevel)
                : -1;
        if (water.bodyWeight != null)
          weightController.text = water.bodyWeight.toString();
      }
      selectWaterLevel(selectedWaterLevelId, false);
      update();
    } catch (_) {
      print("water succ ${_.toString()}");
    }
  }

  void updateScheduleActivityForWater() async {
    if (weightController.text != "" && selectedWaterLevelId != -1) {
      try {
        Utils.showLoadingDialog();
        var response = await repository.updateWaterProgress(
            date: selectedDate,
            waterLevel: selectedWaterLevelId ?? 0,
            bodyWeight: weightController.text,
            activityId: water?.progTrackActivityId);
        Utils.dismissLoadingDialog();
        if (response.status) {
          getScheduleActivityForWater();
          Utils.showSucessSnackBar(response.message);
        } else {
          Utils.showErrorSnackBar(response.message);
        }
      } catch (e) {
        print("error ${e.toString()}");
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(
            e.toString() ?? CustomException.ERROR_CRASH_MSG);
      }
    } else {
      Utils.showErrorSnackBar("water level and and weight required");
    }
  }

  void setWaterLevelList() {
    waterLevelList.add(WaterModel(title: "0.5L", isEmptyWater: true, id: 1));
    waterLevelList.add(WaterModel(title: "1L", isEmptyWater: true, id: 2));
    waterLevelList.add(WaterModel(title: "1.5L", isEmptyWater: true, id: 3));
    waterLevelList.add(WaterModel(title: "2L", isEmptyWater: true, id: 4));
    waterLevelList.add(WaterModel(title: "2.5L", isEmptyWater: true, id: 5));
    waterLevelList.add(WaterModel(title: "3L", isEmptyWater: true, id: 6));
    waterLevelList.add(WaterModel(title: "3.5L", isEmptyWater: true, id: 7));
    waterLevelList.add(WaterModel(title: "4L", isEmptyWater: true, id: 8));
  }

  onTimePickerChange(TimeRange value) {
    displayReminderStartTime = Utils().formatTimeOfDay(value.startTime);
    displayReminderEndTime = Utils().formatTimeOfDay(value.endTime);
    reminderStartTime = value.startTime;
    reminderEndTime = value.endTime;
    /*updateScheduleActivityForWater();*/
    update();
  }

  selectWaterLevel(int id, bool calledApi) {
    print("selectedWaterLevelId");

    selectedWaterLevelId = id;
    // List<WaterModel> temList = waterLevelList;
    for (WaterModel model in waterLevelList) {
      int index = waterLevelList.indexOf(model);
      if (model.id <= selectedWaterLevelId) {
        print("true");
        waterLevelList[index].isEmptyWater = false;
      } else {
        print("false");

        waterLevelList[index].isEmptyWater = true;
      }
    }
    /*if (calledApi) {
      updateScheduleActivityForWater();
    }*/
    update();
  }

  void handleRadioValueChange(int value) {
    waterReminderValue = value;
    /*updateScheduleActivityForWater();*/
    update();
  }
}
