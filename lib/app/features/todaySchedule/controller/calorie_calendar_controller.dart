import 'package:fit_beat/app/common_widgets/custom_calendar/table_calendar.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/data/schedule/calendar_view_response.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalorieCalendarController extends GetxController {
  final ApiRepository repository;

  CalorieCalendarController({@required this.repository})
      : assert(repository != null);

  CalendarController calendarController;
  List<CalendarData> calendarList;
  Map<DateTime, List<CalendarData>> calendarMap;

  @override
  void onInit() {
    super.onInit();
    calendarController = CalendarController();
    calendarList = List();
    calendarMap = Map();
  }

  @override
  void onReady() {
    super.onReady();
    getCalendarData(DateTime.now().year, DateTime.now().month);
  }

  void getCalendarData(
    int year,
    int month,
  ) async {
    try {
      Utils.showLoadingDialog();

      CalendarViewResponse response = await repository.getCalenderData(
        year,
        month,
      );

      if (response != null && response.status) {
        calendarList = response.data;
        await getSortedData();
        Utils.dismissLoadingDialog();
        update();

        /*if (refreshData != null && refreshData) {
          calendarController.setSelectedDay(calendarController.focusedDay,
              runCallback: true);
        }*/
      } else {
        Utils.dismissLoadingDialog();
        update();
        Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
        throw CustomException(
            CustomException.ERROR_CONNECTION, CustomException.ERROR_CRASH_MSG);
      }
    } catch (e) {
      print("calendar Error : ${e.toString()}");
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
      update();

      throw CustomException(
          CustomException.ERROR_CONNECTION, CustomException.ERROR_CRASH_MSG);
    }
  }

  Future<void> getSortedData() async {
    for (CalendarData data in calendarList) {
      print("sort ${data.scheduleDate.toLocal()}");
      calendarMap.putIfAbsent(data.scheduleDate.toLocal(), () => [data]);
    }
  }

  @override
  void onClose() {
    calendarController.dispose();
    super.onClose();
  }
}
