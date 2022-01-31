import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/features/my_profile/controller/profile_controller.dart';
import 'package:fit_beat/app/features/my_profile/view/personal_info.dart';
import 'package:fit_beat/app/features/my_profile/view/profile_header.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_info.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> tabs = <Widget>[
    Container(
        height: 44, width: Get.width / 2, child: Tab(text: "Personal Info.")),
    Container(
        height: 44, width: Get.width / 2, child: Tab(text: "Contact Info.")),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    print("Edit= ${Get.find<ProfileController>().isEdit.value}");
    return GetX<ProfileController>(builder: (_) {
      return Scaffold(
        backgroundColor: bodybgColor,
        appBar: CustomAppBar(
          negativeText: _.isEdit.value ? "Cancel" : null,
          positiveText: _.isEdit.value ? "Save" : null,
          onNegativeTap: () {
            _.isEdit.value = false;
            _.isEdit.refresh();
          },
          onPositiveTap: () {
            _.editMyProfileDetails();
          },
        ),
        body: Scaffold(
          backgroundColor: bodybgColor,
          body: GetBuilder<ProfileController>(builder: (_) {
            return _.isProfileLoading
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
                            controller: _tabController,
                            children: [
                              PersonalInfo(),
                              ContactInfo(),
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
          }),
        ),
      );
    });
  }

  List<Widget> _createTopView() {
    return List.generate(1, (index) {
      return Column(
        children: [
          ProfileHeader(),
          const SizedBox(height: 25),
          CommonContainer(
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
              tabs: tabs,
              controller: _tabController,
            ),
          ),
          const SizedBox(height: 36),
        ],
      );
    });
  }
}
