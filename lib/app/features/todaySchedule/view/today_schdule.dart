import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/features/todaySchedule/view/exercise_page.dart';
import 'package:fit_beat/app/features/todaySchedule/view/nutrition_page.dart';
import 'package:fit_beat/app/features/todaySchedule/view/water_page.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodaySchedulePage extends StatefulWidget {
  @override
  _TodaySchedulePageState createState() => _TodaySchedulePageState();
}

class _TodaySchedulePageState extends State<TodaySchedulePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> tabs = <Widget>[
    Container(height: 44, width: Get.width / 3, child: Tab(text: "Nutrition")),
    Container(height: 44, width: Get.width / 3, child: Tab(text: "Exercise")),
    Container(height: 44, width: Get.width / 3, child: Tab(text: "Water")),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Today Schedule",
        onPositiveTap: () {
          Get.toNamed(Routes.myPlanCoachPage);
        },
        positiveText: "My Plan & Coach",
        positiveTextColor: FF55B5FE,
      ),
      body: Container(
        child: Column(
          children: [
            Divider(
              color: FFB0B8BB,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CommonContainer(
                height: 44,
                width: Get.width,
                borderRadius: 38,
                backgroundColor: FFE0EAEE,
                child: TabBar(
                  labelStyle: TextStyle(
                      color: FF050707,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: FontFamily.poppins),
                  unselectedLabelStyle: TextStyle(
                      color: FF868A8C,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: FontFamily.poppins),
                  isScrollable: false,
                  unselectedLabelColor: FF868A8C,
                  labelColor: FF050707,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: CustomTabIndicator(
                    indicatorHeight: 31.0,
                    indicatorColor: FFFFFFFF,
                    indicatorRadius: 40,
                  ),
                  tabs: tabs,
                  controller: _tabController,
                ),
              ),
            ),
            Divider(
              color: FFB0B8BB,
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                NutritionPage(),
                ExercisePage(),
                WaterPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
