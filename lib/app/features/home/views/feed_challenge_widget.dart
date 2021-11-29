import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/features/home/views/feed_button.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedChallengeWidget extends StatelessWidget {
  final Feed feedData;

  const FeedChallengeWidget({Key key, this.feedData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: Utils.getFormattedTags(feedData.userTags),
          color: primaryColor,
          size: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 8,
        ),
        CustomText(
          text: feedData.descriptions,
          color: titleBlackColor,
          overflow: null,
          size: 14,
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: catYellowColor, shape: BoxShape.circle),
              width: 30,
              height: 30,
              child: Center(
                child: Image.asset(
                  Assets.challengeIcon,
                  width: 15,
                  height: 15,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: feedData.title,
                    color: titleBlackColor,
                    size: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  CustomText(
                    text: "${feedData.triedCount} people tried this challenge",
                    color: descriptionColor,
                    size: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            FeedButton(
              label: "Try Challenge",
              onTap: () => Get.toNamed(Routes.addPost, parameters: {
                "postType": "1",
                "title": feedData.title,
                "isOtherType": "true",
                "masterPostId": feedData.uniqueId.toString()
              }),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        MediaSlidableWidget(
          mediaList: feedData.userMedia,
        ),
      ],
    );
  }
}
