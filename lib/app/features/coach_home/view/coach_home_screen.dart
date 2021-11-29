import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/coach_home/view/coach_all_post.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coach_my_post.dart';
import 'my_people_page.dart';

class CoachHomeScreen extends StatefulWidget {
  @override
  _CoachHomeScreenState createState() => _CoachHomeScreenState();
}

class _CoachHomeScreenState extends State<CoachHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentIndex = 0;

  final List<Widget> tabs = <Widget>[
    Container(
        height: 30,
        width: Get.width / 3,
        child: Tab(
          child: Row(
            children: [
              Image.asset(
                Assets.myPeopel,
                height: 18,
                width: 18,
              ),
              const SizedBox(width: 4),
              CustomText(
                text: "My People",
                color: FF050707,
                size: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        )),
    Container(
        height: 30,
        width: Get.width / 3,
        child: Tab(
          child: Row(
            children: [
              Image.asset(
                Assets.myPost,
                height: 18,
                width: 18,
              ),
              const SizedBox(width: 4),
              CustomText(
                text: "My Posts",
                color: FF050707,
                size: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        )),
    Container(
        height: 30,
        width: Get.width / 3,
        child: Row(
          children: [
            Image.asset(
              Assets.allPost,
              height: 18,
              width: 18,
            ),
            const SizedBox(width: 4),
            CustomText(
              text: "All Posts",
              color: FF050707,
              size: 14,
              fontWeight: FontWeight.w400,
            ),
          ],
        )),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tabController.index == 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  hintText: "Search my people",
                  height: 36,
                  prefixIcon: Icon(
                    Icons.search,
                    color: FF025074,
                  ),
                  hintColor: hintColor,
                  isPaddingRequired: false,
                  inputType: TextInputType.text,
                  showIcon: true,
                  endIcon: Icons.filter_alt_outlined,
                  bgColor: FFE0EAEE,
                  onChanged: (value) {},
                ),
              )
            : Container(),
        Divider(),
        TabBar(
          isScrollable: false,
          unselectedLabelColor: FF6D7274,
          labelColor: FF050707,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: tabs,
          controller: _tabController,
          indicatorColor: FF025074,
          indicatorWeight: 3,
          onTap: (index) {
            /*  setState(() {
              currentIndex = index;
            });*/
          },
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            MyPeoplePage(),
            CoachMyPost(),
            CoachAllPost(),
          ],
        ))
      ],
    );
  }
}
