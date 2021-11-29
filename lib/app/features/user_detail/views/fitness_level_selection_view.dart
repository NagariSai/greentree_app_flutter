import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FitnessLevelSelectionView extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              "Your fitness level",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 31),
            child: Column(
              children: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CommonContainer(
                      height: 70,
                      width: null,
                      borderRadius: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: _.selectedLevel == 1
                              ? bgFitnessSelectColor
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              _.changeLevelValue(1);
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: bgFitnessSelectColor,
                                      blurRadius: 28,
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ]),
                              child: ClipOval(
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  color: primaryColor,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/ic_beginner.svg",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Beginner",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "I'm new to exercise",
                              style: TextStyle(
                                  color: subTitleFitnessColor,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CommonContainer(
                      height: 70,
                      width: null,
                      borderRadius: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: _.selectedLevel == 2
                              ? bgFitnessSelectColor
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              _.changeLevelValue(2);
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: bgFitnessSelectColor,
                                      blurRadius: 28,
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ]),
                              child: ClipOval(
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  color: primaryColor,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/ic_intermediate.svg",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Intermediate",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "I will spend 20-30 minutes to exercise",
                              style: TextStyle(
                                  color: subTitleFitnessColor,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CommonContainer(
                      height: 70,
                      width: null,
                      borderRadius: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: _.selectedLevel == 3
                              ? bgFitnessSelectColor
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              _.changeLevelValue(3);
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: bgFitnessSelectColor,
                                      blurRadius: 28,
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ]),
                              child: ClipOval(
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  color: primaryColor,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/ic_advanced.svg",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Advanced",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "I will spend more than 2 hrs to exercise",
                              style: TextStyle(
                                  color: subTitleFitnessColor,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                if (_.selectedLevel != null) _.gotoInterestSelectionPage();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 52),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: _.selectedLevel != null ? primaryColor : Colors.grey,
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
    );
  }
}
