import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/features/auth/coach_register/controller/coach_register_controller.dart';
import 'package:fit_beat/app/features/auth/coach_register/view/profile_header.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coach_contact_info.dart';
import 'coach_personal_info.dart';

class CoachRegisterPage extends StatefulWidget {
  @override
  _CoachRegisterPageState createState() => _CoachRegisterPageState();
}

class _CoachRegisterPageState extends State<CoachRegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoachRegisterController>(builder: (_) {
      return Scaffold(
        appBar: CustomAppBar(
          negativeText: "Cancel",
          positiveText: _.tabIndex == 0 ? "Save" : "Submit",
          onNegativeTap: () {
            Get.back();
          },
          onPositiveTap: () {
            if (_.tabIndex == 0) {
              Get.find<CoachRegisterController>().validatePersonalInfo();
            } else {
              Get.find<CoachRegisterController>().registerCoach();
            }
          },
        ),
        body: Scaffold(
          body: _.isRegisterLoading
              ? Center(child: CircularProgressIndicator())
              : NestedScrollView(
                  headerSliverBuilder: (context, bool isInnerBoxScroll) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          _createTopView(),
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        Expanded(
                            child: TabBarView(
                          controller: _.tabController,
                          children: [
                            CoachPersonalInfo(),
                            CoachContactInfo(),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }

  List<Widget> _createTopView() {
    return List.generate(1, (index) {
      return Column(
        children: [
          CoachProfileHeader(),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CommonContainer(
              height: 44,
              width: Get.width,
              borderRadius: 38,
              backgroundColor: FFE0EAEE,
              child: TabBar(
                isScrollable: false,
                unselectedLabelColor: FF6D7274,
                labelColor: FF050707,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CustomTabIndicator(
                  indicatorHeight: 31.0,
                  indicatorColor: FFFFFFFF,
                  indicatorRadius: 40,
                ),
                tabs: Get.find<CoachRegisterController>().tabs,
                controller: Get.find<CoachRegisterController>().tabController,
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      );
    });
  }
}
