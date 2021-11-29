import 'package:fit_beat/app/common_widgets/custom_calendar/table_calendar.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/prog_tracker/controllers/insight_controller.dart';
import 'package:fit_beat/app/features/prog_tracker/views/weight_graph_page.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calender_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InsightController>(
        init: InsightController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return _.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCalenderView(
                          calendarFormat: CalendarFormat.month,
                          hideContent: true,
                          selectedDate: (selectedDate) {
                            _.setCalenderDate(selectedDate);
                          },
                        ),
                        if (_.isDateChange)
                          Container(
                              height: 500,
                              child: Center(child: CircularProgressIndicator()))
                        else
                          WeightGraphPage()
                      ],
                    ),
                  ),
                );
        });
  }
}
