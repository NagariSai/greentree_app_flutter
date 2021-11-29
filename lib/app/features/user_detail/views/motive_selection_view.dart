import 'package:fit_beat/app/features/user_detail/common_widgets/what_bring_you_here_container.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MotiveSelectionView extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "What brings you here?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(top: 41),
                /*child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: [...generate(_)],
                  ),*/
                child: Container(
                  child: GridView.count(
                    childAspectRatio: 0.8,
                    primary: true,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: [...generate(_)],
                  ),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () {
                  if (_.selectedMotivationId != null &&
                      _.selectedMotivationId.isNotEmpty)
                    _.gotoFoodPrefSelectionPage();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 52),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      color: (_.selectedMotivationId != null &&
                              _.selectedMotivationId.isNotEmpty)
                          ? primaryColor
                          : Colors.grey,
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _.updateUserData();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Center(
                  child: Text(
                    "I will do this later",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generate(UserDetailController _) {
    return _.userDetailsOptionsEntity.value.data.masterBrings
        .map((e) => WhatBringYouHereContainer(
              onTap: () {
                print(
                    "_.isMotivationSelected(e.masterBringId) => ${_.isMotivationSelected(e.masterBringId)}");
                if (_.isMotivationSelected(e.masterBringId)) {
                  _.selectedMotivationId.remove(e.masterBringId);
                } else {
                  _.selectedMotivationId.add(e.masterBringId);
                }
              },
              height: 86,
              width: 86,
              borderRadius: 24,
              isSelected: _.isMotivationSelected(e.masterBringId),
              backgroundColor: Utils.hexToColor(e.color),
              label: e.title,
              child: Container(
                child: Center(
                  child: SvgPicture.network(
                    e.icon,
                    color: _.isMotivationSelected(e.masterBringId)
                        ? Colors.white
                        : Utils.hexToColor(e.color),
                    placeholderBuilder: (BuildContext context) =>
                        SvgPicture.asset(
                      "assets/images/ic_motive_${e.masterBringId}.svg",
                      color: _.isMotivationSelected(e.masterBringId)
                          ? Colors.white
                          : Utils.hexToColor(e.color),
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }
}
