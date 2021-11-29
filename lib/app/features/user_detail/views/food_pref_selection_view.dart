import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FoodPrefSelectionView extends StatelessWidget {
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
              "Your food preferences",
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
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CommonContainer(
                      height: 60,
                      width: null,
                      borderRadius: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: _.selectedFood == 1
                              ? bgFoodVegColor
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              _.changeFoodValue(1);
                            },
                            leading: ClipOval(
                              child: Container(
                                height: 36,
                                width: 36,
                                color: foodVegColor,
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_veg.svg",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Veg",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CommonContainer(
                      height: 60,
                      width: null,
                      borderRadius: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: _.selectedFood == 2
                              ? bgFoodNonVegColor
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              _.changeFoodValue(2);
                            },
                            leading: ClipOval(
                              child: Container(
                                height: 36,
                                width: 36,
                                color: foodNonVegColor,
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_non_veg.svg",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Nonveg",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CommonContainer(
                      height: 60,
                      width: null,
                      borderRadius: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: _.selectedFood == 3
                              ? bgFoodEggColor
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              _.changeFoodValue(3);
                            },
                            leading: ClipOval(
                              child: Container(
                                height: 36,
                                width: 36,
                                color: foodEggColor,
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_eggetarian.svg",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Eggetarian",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CommonContainer(
                      height: 60,
                      width: null,
                      borderRadius: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: _.selectedFood == 4
                              ? bgFoodVeganColor
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              _.changeFoodValue(4);
                            },
                            leading: ClipOval(
                              child: Container(
                                height: 36,
                                width: 36,
                                color: foodVeganColor,
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_vegan.svg",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Vegan",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
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
                if (_.selectedFood != null) _.gotoFitnessLevelSelectionPage();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 52),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: _.selectedFood != null ? primaryColor : Colors.grey,
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
