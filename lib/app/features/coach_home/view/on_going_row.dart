import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/coach_enroll_user_response.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnGoingRow extends StatelessWidget {
  CoachEnrollUser coachEnrollUser;
  OnGoingRow({this.coachEnrollUser});
  @override
  Widget build(BuildContext context) {
    final date2 = DateTime.now();
    final difference = coachEnrollUser.validUptoDatetime != null
        ? coachEnrollUser.validUptoDatetime.difference(date2).inDays
        : 0;

    return InkWell(
      onTap: () {
        Get.toNamed(Routes.userProfile,
            arguments: [coachEnrollUser.userProfileId, 0]);
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CircularImage(
                  height: 46,
                  width: 46,
                  imageUrl: coachEnrollUser.profileUrl ?? "",
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "${coachEnrollUser.fullName}",
                      fontWeight: FontWeight.bold,
                      color: FF050707,
                      size: 16,
                    ),
                    CustomText(
                      text: "${coachEnrollUser.packageTitle}",
                      fontWeight: FontWeight.w300,
                      color: FF6D7274,
                      size: 11,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        "${Utils.convertDateIntoDisplayString(coachEnrollUser.createDatetime)}",
                    fontWeight: FontWeight.w300,
                    color: FF6D7274,
                    size: 11,
                  ),
                  CustomText(
                    text: "${difference < 0 ? 0 : difference} days left",
                    fontWeight: FontWeight.w600,
                    color: FF025074,
                    size: 11,
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
