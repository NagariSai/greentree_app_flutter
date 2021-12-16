import 'package:fit_beat/app/common_widgets/custom_calendar/table_calendar.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class CustomCalenderView extends StatefulWidget {
  Function selectedDate;
  final CalendarFormat calendarFormat;
  final bool isNutritionPage;
  final bool hideContent;
  CustomCalenderView(
      {this.selectedDate,
      this.isNutritionPage = false,
      this.calendarFormat = CalendarFormat.week,
      this.hideContent = false});

  @override
  _CustomCalenderViewState createState() => _CustomCalenderViewState();
}

class _CustomCalenderViewState extends State<CustomCalenderView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  CalendarController calendarController = CalendarController();


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: calendarController,
      initialCalendarFormat: widget.calendarFormat,
      initialSelectedDay: _focusedDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      hideContent: widget.hideContent,

      /* firstDay: DateTime(
          DateTime.now().year, DateTime.now().month - 3, DateTime.now().day),
      lastDay: DateTime(
          DateTime.now().year, DateTime.now().month + 3, DateTime.now().day),*/
      /* onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },*/

      onDaySelected: (DateTime day, List events, List holidays) {
        // _onDaySelected(day, events, holidays, calendarController);
        widget.selectedDate.call(day);
      },
      onVisibleDaysChanged:
          (DateTime first, DateTime last, CalendarFormat format) {
        widget.selectedDate.call(first);
        print("dd");
        // _onVisibleDaysChanged(
        //     first, last, format, calendarController);
      },

      /*  onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },*/
      /* onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            widget.selectedDate.call(_selectedDay);
          });
        }
      },*/

      onHeaderIconPressed: () {
        if (widget.isNutritionPage) Get.toNamed(Routes.calorieCalendarPage);
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
          formatButtonVisible: widget.isNutritionPage ? true : false,
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
      calendarStyle: CalendarStyle(
        todayStyle: TextStyle(
            color: FF050707, fontSize: 13, fontFamily: FontFamily.poppins),
        weekdayStyle: TextStyle(
            color: FF050707, fontSize: 13, fontFamily: FontFamily.poppins),
        weekendStyle: TextStyle(
            color: FF050707, fontSize: 13, fontFamily: FontFamily.poppins),
        selectedColor: primaryColor,
        selectedStyle: TextStyle(
            color: Colors.white, fontSize: 13, fontFamily: FontFamily.poppins),
        // contentDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(12),
        // ),
        todayColor: FFC3DAE3,
        outsideDaysVisible: true,
        outsideStyle: TextStyle(
            color: FF050707, fontSize: 13, fontFamily: FontFamily.poppins),
        outsideWeekendStyle: TextStyle(
            color: FF050707, fontSize: 13, fontFamily: FontFamily.poppins),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(
            color: FF6D7274, fontSize: 13, fontFamily: FontFamily.poppins),
        weekdayStyle: TextStyle(
            color: FF6D7274, fontSize: 13, fontFamily: FontFamily.poppins),
      ),
    );
  }
}
