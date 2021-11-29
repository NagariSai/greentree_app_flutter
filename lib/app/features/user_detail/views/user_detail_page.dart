import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/features/user_detail/views/dob_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/fitness_level_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/food_pref_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/gender_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/height_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/interest_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/motive_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/weight_selection_view.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailPage extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _.pagerGoBack();
        return false;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: true,
          top: true,
          child: Scaffold(
            key: _.scaffoldKey,
            body: OrientationBuilder(builder: (context, orientation) {
              return LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Opacity(
                                  child: GestureDetector(
                                    onTap: (_.currentPage.value == 1)
                                        ? null
                                        : _.pagerGoBack,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: primaryColor,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  opacity: (_.currentPage.value == 1) ? 0 : 1,
                                )),
                            Center(
                              child: Container(
                                width: viewportConstraints.maxWidth / 1.7,
                                height: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Obx(
                                    () => LinearProgressIndicator(
                                      backgroundColor:
                                          primaryColor.withOpacity(0.1),
                                      value: _.currentPage.value /
                                          _.totalPage, // page_count / total_page
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Opacity(
                                child: GestureDetector(
                                  onTap: (_.currentPage.value == _.totalPage)
                                      ? null
                                      : _.pagerGoForward,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 16),
                                    ),
                                  ),
                                ),
                                opacity: (_.currentPage.value == _.totalPage)
                                    ? 0
                                    : 1,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Obx(
                            () => Text(
                              "STEP ${_.currentPage.value}/${_.totalPage}",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: PageView(
                              scrollDirection: Axis.horizontal,
                              controller: _.controller,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                GenderSelectionView(),
                                DobSelectionView(),
                                HeightSelectionView(),
                                WeightSelectionView(),
                                MotiveSelectionView(),
                                FoodPrefSelectionView(),
                                FitnessLevelSelectionView(),
                                InterestSelectionView()
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              });
            }),
          ),
        ),
      ),
    );
  }
}
