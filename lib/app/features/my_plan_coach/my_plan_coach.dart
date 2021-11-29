import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/features/my_plan_coach/completed.dart';
import 'package:fit_beat/app/features/my_plan_coach/on_going.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPlanCoach extends StatefulWidget {
  @override
  _MyPlanCoachState createState() => _MyPlanCoachState();
}

class _MyPlanCoachState extends State<MyPlanCoach>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Widget> tabs = <Widget>[
    Container(height: 44, width: Get.width / 2, child: Tab(text: "On Going")),
    Container(height: 44, width: Get.width / 2, child: Tab(text: "Completed")),
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
        title: "My Plan & coach",
      ),
      body: Container(
        child: Column(
          children: [
            Divider(
              color: dividerColor,
              thickness: 1,
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
              children: [OnGoingPage(), CompletedPage()],
            )),
          ],
        ),
      ),
    );
  }
}
