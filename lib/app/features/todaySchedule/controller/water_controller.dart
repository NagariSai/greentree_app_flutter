import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/model/water_model.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class WaterController extends GetxController {
  final ApiRepository repository;

  WaterController({@required this.repository}) : assert(repository != null);

  List<WaterModel> waterLevelList = [];

  AsWater water;
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

    userScheduleId = 0;
  }

  setCalenderDate(DateTime dateTime) async {
    selectedDate = requestDobFormat.format(dateTime);
    isDateChange = true;
    resetAll();
    update();
    try {
      var response = await repository.getScheduleActivityForWater(
        startDate: selectedDate,
        endDate: selectedDate,
      );
      isDateChange = false;
      if (response.status) {
        userScheduleId = response.data[0].userScheduleId ?? 0;
      }
      onSuccess(response);
      update();
    } catch (e) {
      isDateChange = false;
      update();
    }
  }

  void getScheduleActivityForWater() async {
    try {
      isLoading = true;
      var response = await repository.getScheduleActivityForWater(
        startDate: selectedDate,
        endDate: selectedDate,
      );
      isLoading = false;

      if (response.status) {
        userScheduleId = response.data[0].userScheduleId ?? 0;
      }

      onSuccess(response);
      update();
    } catch (e) {
      print("water error : ${e.toString()}");
      isLoading = false;
    }
  }

  void onSuccess(ScheduleActivityListModel response) {
    if (response.status &&
        response.data != null &&
        response.data.length > 0 &&
        response.data[0].asWater != null &&
        response.data[0].asWater.length > 0) {
      water = response.data[0].asWater[0];

      reminderStartTime = water.reminderStartTime != null
          ? TimeOfDay(
              hour: int.parse(water.reminderStartTime.split(":")[0]),
              minute: int.parse(water.reminderStartTime.split(":")[1]))
          : null;
      reminderEndTime = water.reminderTimeTime != null
          ? TimeOfDay(
              hour: int.parse(water.reminderTimeTime.split(":")[0]),
              minute: int.parse(water.reminderTimeTime.split(":")[1]))
          : null;
      displayReminderStartTime = Utils().formatTimeOfDay(reminderStartTime);
      displayReminderEndTime = Utils().formatTimeOfDay(reminderEndTime);
      userScheduleId = water.userScheduleId ?? 0;
      print("userScheduleId ======== ${userScheduleId}");
      waterReminderValue = water.reminderSchedule;
      selectedWaterLevelId =
          water.waterLevel != null && water.waterLevel.isNotEmpty
              ? int.parse(water.waterLevel)
              : -1;
    }
    selectWaterLevel(selectedWaterLevelId, false);
    update();
  }

  void updateScheduleActivityForWater() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.updateScheduleActivityForWater(
          userScheduleId: userScheduleId ?? 0,
          scheduleDate: selectedDate,
          waterLevel: selectedWaterLevelId ?? 0,
          reminderSchedule: waterReminderValue ?? 0,
          reminderStartTime: reminderStartTime == null
              ? null
              : "${reminderStartTime.hour}:${reminderStartTime.minute}",
          reminderTimeTime: reminderEndTime == null
              ? null
              : "${reminderEndTime.hour}:${reminderEndTime.minute}");
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
      Utils.showErrorSnackBar(e.toString() ?? CustomException.ERROR_CRASH_MSG);
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
    selectedWaterLevelId = id;
    // List<WaterModel> temList = waterLevelList;
    for (WaterModel model in waterLevelList) {
      int index = waterLevelList.indexOf(model);
      if (model.id <= selectedWaterLevelId) {
        waterLevelList[index].isEmptyWater = false;
      } else {
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
