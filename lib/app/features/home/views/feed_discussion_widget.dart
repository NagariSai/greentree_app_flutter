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

class FeedDiscussionWidget extends StatelessWidget {
  final Feed feedData;

  const FeedDiscussionWidget({Key key, this.feedData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (feedData.userTags != null && feedData.userTags.isNotEmpty) ...[
          CustomText(
            text: Utils.getFormattedTags(feedData.userTags),
            color: primaryColor,
            size: 14,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 8,
          ),
        ],
        CustomText(
          text: feedData.descriptions,
          color: titleBlackColor,
          size: 14,
          maxLines: 3,
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: catDarkGreenColor, shape: BoxShape.circle),
              width: 30,
              height: 30,
              child: Center(
                child: Image.asset(
                  Assets.discussionIcon,
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
                    text:
                        "${feedData.triedCount} people are discussing on this",
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
              label: "Start Discussion",
              onTap: () => Get.toNamed(Routes.discussion_detail_page,
                  arguments: [
                    feedData.uniqueId,
                    feedData.type,
                    feedData.triedCount,
                    feedData.title
                  ]),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        MediaSlidableWidget(mediaList: feedData.userMedia),
      ],
    );
  }
}
