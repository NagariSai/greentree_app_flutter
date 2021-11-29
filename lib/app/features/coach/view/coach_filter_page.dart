import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/features/coach/controller/coach_list_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CoachFilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Filters",
        onPositiveTap: () {
          Utils.dismissKeyboard();
          Get.back();
          Get.find<CoachListController>().resetFilter();
        },
        positiveText: "Reset",
        onNegativeTap: () {
          Utils.dismissKeyboard();
          Get.back();
          Get.find<CoachListController>().getCoachList();
        },
        negativeText: "Apply",
      ),
      body: GetBuilder<CoachListController>(builder: (_) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                CustomText(
                  text: "Rating",
                  color: FF6D7274,
                  size: 12,
                ),
                const SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: FF025074,
                  ),
                  onRatingUpdate: (rating) {
                    _.rating = rating;
                    print(rating);
                  },
                ),
                Divider(),
                const SizedBox(height: 12),
                CustomText(
                  text: "Gender",
                  color: FF6D7274,
                  size: 12,
                ),
                Container(
                  height: 50,
                  child: ListView.separated(
                    itemCount: _.genderList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      var data = _.genderList[position];
                      return GestureDetector(
                        onTap: () {
                          _.getGenderCoach(position);
                        },
                        child: Chip(
                          shape: _.selectedGender != null &&
                                  data.type == _.selectedGender.type
                              ? null
                              : StadiumBorder(
                                  side: BorderSide(color: borderColor)),
                          label: Text(data.title),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: _.selectedGender != null &&
                                      data.type == _.selectedGender.type
                                  ? FF050707
                                  : titleBlackColor),
                          backgroundColor: _.selectedGender != null &&
                                  data.type == _.selectedGender.type
                              ? FFB2C8D2
                              : Colors.white,
                        ),
                      );
                    },
                    separatorBuilder: (context, position) {
                      return SizedBox(
                        width: 8,
                      );
                    },
                  ),
                ),
                Divider(),
                const SizedBox(height: 12),
                CustomText(
                  text: "Levels",
                  color: FF6D7274,
                  size: 12,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _.getCoachLevelList(),
                ),
                const SizedBox(height: 8),
                Divider(),
                const SizedBox(height: 12),
                CustomText(
                  text: "Language",
                  color: FF6D7274,
                  size: 12,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _.getLanguageList(),
                ),
                Divider(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
