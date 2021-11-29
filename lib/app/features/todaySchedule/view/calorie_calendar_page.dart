import 'dart:math';

import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_calendar/table_calendar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/calorie_calendar_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalorieCalendarPage extends StatelessWidget {
  Map<DateTime, List<String>> calendarMap = Map();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    // setData();
    // DateTime _focusedDay = DateTime.now();
    // DateTime _selectedDay;
    return Scaffold(
        appBar: CustomAppBar(
          title: "Calendar view",
          elevation: 1,
        ),
        body: GetBuilder<CalorieCalendarController>(
            init: CalorieCalendarController(
                repository: ApiRepository(apiClient: ApiClient())),
            builder: (_) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TableCalendar(
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarController: _.calendarController,
                      initialCalendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onDaySelected:
                          (DateTime day, List events, List holidays) {
                        // _onDaySelected(day, events, holidays, calendarController);
                      },
                      onVisibleDaysChanged: (DateTime first, DateTime last,
                          CalendarFormat format) {
                        _onVisibleDaysChanged(first, last, format, _);
                      },
                      headerStyle: HeaderStyle(
                          titleTextStyle: TextStyle(
                              color: FF050707,
                              fontSize: 16,
                              fontFamily: FontFamily.poppins,
                              fontWeight: FontWeight.w500),
                          centerHeaderTitle: true,
                          // leftChevronMargin: const EdgeInsets.only(left: 64),
                          // rightChevronMargin: const EdgeInsets.only(right: 64),
                          formatButtonVisible: false,
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: FF55B5FE,
                            size: 28,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: FF55B5FE,
                            size: 28,
                          )),
                      events: _.calendarMap,
                      calendarStyle: CalendarStyle(
                        markersAlignment: Alignment.bottomCenter,
                        todayStyle: TextStyle(
                            color: FF050707,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                        weekdayStyle: TextStyle(
                            color: FF050707,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                        weekendStyle: TextStyle(
                            color: FF050707,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                        selectedColor: FF050707,
                        selectedStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                        // contentDecoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(12),
                        // ),

                        outsideDaysVisible: false,
                        // todayColor: ,
                        outsideStyle: TextStyle(
                            color: FF050707,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                        outsideWeekendStyle: TextStyle(
                            color: FF050707,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                            color: FF050707,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                        weekdayStyle: TextStyle(
                            color: FF050707,
                            fontSize: 13,
                            fontFamily: FontFamily.poppins),
                      ),
                      builders: CalendarBuilders(
                        markersBuilder: (context, date, events, holidays) {
                          // print("cal out date ${date}");
                          // print("events ${events[0]}");
                          // print("holidays ${holidays[0]}");

                          final children = <Widget>[];

                          if (!isExceedingLimit(events)) {
                            children.add(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: date.day.toString(),
                                    size: 13,
                                    color: FF050707,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                    text:
                                        "${events[0].completeKcal.toString()}",
                                    color: FF03913D,
                                    size: 10,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            children.add(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: date.day.toString(),
                                    size: 13,
                                    color: FF050707,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                    text:
                                        "${events[0].completeKcal.toString()}",
                                    size: 10,
                                    color: FFBA1100,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            );
                          }
                          return children;
                        },
                        dayBuilder:
                            (context, DateTime time, List<dynamic> dayList) {
                          return Center(
                            child: Container(
                              height: 54,
                              width: 44,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: !isExceedingLimit(dayList)
                                      ? FFE4F8ED
                                      : FFFDE2DF),
                            ),
                          );
                        },
                        holidayDayBuilder:
                            (context, DateTime time, List<dynamic> dayList) {
                          return Center(
                            child: Container(
                              height: 54,
                              width: 44,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: !isExceedingLimit(dayList)
                                      ? FFE4F8ED
                                      : FFFDE2DF),
                            ),
                          );
                        },
                        selectedDayBuilder:
                            (context, DateTime time, List<dynamic> dayList) {
                          return Center(
                            child: Container(
                              height: 54,
                              width: 44,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: !isExceedingLimit(dayList)
                                      ? FFE4F8ED
                                      : FFFDE2DF),
                            ),
                          );
                        },
                        todayDayBuilder:
                            (context, DateTime time, List<dynamic> dayList) {
                          return Center(
                            child: Container(
                              height: 54,
                              width: 44,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: !isExceedingLimit(dayList)
                                      ? FFE4F8ED
                                      : FFFDE2DF),
                            ),
                          );
                        },
                        weekendDayBuilder:
                            (context, DateTime time, List<dynamic> dayList) {
                          return Center(
                            child: Container(
                              height: 54,
                              width: 44,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: !isExceedingLimit(dayList)
                                      ? FFE4F8ED
                                      : FFFDE2DF),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 9,
                            width: 9,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: FF03913D),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "In Limit of Kcal goal",
                            size: 13,
                            color: FF6D7274,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 9,
                            width: 9,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: FFBA1100),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "Exceeded limit of Kcal goal",
                            size: 13,
                            color: FF6D7274,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  bool getRandomBool(List<dynamic> holidays) {
    if (holidays == null || holidays.isEmpty) {
      return Random().nextBool();
    } else {
      if (holidays[0] == "0") {
        return true;
      } else {
        return false;
      }
    }
    return Random().nextBool();
  }

  bool isExceedingLimit(List<dynamic> holidays) {
    bool isExceeding = false;

    if (holidays == null || holidays.isEmpty) {
      isExceeding = false;
    } else {
      if (holidays[0].completeKcal <= holidays[0].setKcal) {
        isExceeding = false;
      } else {
        isExceeding = true;
      }
    }

    return isExceeding;
  }

  setData() {
    for (int i = 0; i < daysInMonth(DateTime.now()); i++) {
      calendarMap.putIfAbsent(
          DateTime(DateTime.now().year, DateTime.now().month, i + 1),
          () => [i.isEven ? "1" : "0"]);
    }
    /*calendarMap.putIfAbsent(DateTime.now(), () => ["1"]);
    calendarMap.putIfAbsent(
        DateTime.now().subtract(Duration(days: 1)), () => ["0"]);
    calendarMap.putIfAbsent(
        DateTime.now().subtract(Duration(days: 2)), () => ["1"]);
    calendarMap.putIfAbsent(
        DateTime.now().subtract(Duration(days: 3)), () => ["0"]);
    calendarMap.putIfAbsent(
        DateTime.now().subtract(Duration(days: 4)), () => ["1"]);
    calendarMap.putIfAbsent(
        DateTime.now().subtract(Duration(days: 5)), () => ["0"]);
    calendarMap.putIfAbsent(
        DateTime.now().subtract(Duration(days: 6)), () => ["1"]);*/
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last,
      CalendarFormat format, CalorieCalendarController _) async {
    print('CALLBACK: _onVisibleDaysChanged');
    print(_.calendarController.focusedDay);
    if (_.calendarController.focusedDay.month !=
        _.calendarController.selectedDay.month) {
      _.getCalendarData(
        first.year,
        first.month,
      );
    }
  }
}
