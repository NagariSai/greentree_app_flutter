import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/coach_enroll_user_response.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';

class PendingRow extends StatelessWidget {
  CoachEnrollUser coachEnrollUser;
  PendingRow({this.coachEnrollUser});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CustomText(
                        text: "Decline",
                        size: 13,
                        color: FFFF9B91,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(width: 24),
                      RoundedCornerButton(
                        height: 27,
                        width: 78,
                        buttonText: "Approve",
                        buttonColor: FFE8FFF2,
                        borderColor: FFE8FFF2,
                        fontSize: 13,
                        radius: 4,
                        isIconWidget: false,
                        iconAndTextColor: FF6BD295,
                        iconData: null,
                        onPressed: () {},
                      )
                    ],
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
              ],
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
