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
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: "Today Schedule",
        onPositiveTap: () {
          Get.toNamed(Routes.myPlanCoachPage);
        },
        positiveText: "My Plan & Coach",
        positiveTextColor:bottombgColor,
      ),
      body: Container(
        color: bodybgColor,
        child: Column(
          children: [
          /*  Divider(
              color: FFB0B8BB,
            ),*/
            Container(
              decoration: new BoxDecoration(
                color: bodybgColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: CommonContainer(
                height: 44,
                width: Get.width,
                borderRadius: 0,
                backgroundColor: bodybgColor,
                child: TabBar(
                  labelStyle: TextStyle(
                      color: Colors.white,
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
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: CustomTabIndicator(
                    indicatorHeight: 31.0,
                    indicatorColor: appbgColor,
                    indicatorRadius: 40,
                  ),
                  tabs: tabs,
                  controller: _tabController,
                ),
              ),
            ),
         /*   Divider(
              color: FFB0B8BB,
            ),*/
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
      /*floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 1.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(

            icon: Icon(Icons.add_circle),
            label: Text(""),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
    );
  }
}
