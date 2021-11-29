import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/home/views/dummy_media_slidable_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_button.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DummyFeedDiscussionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "#Diet",
          color: primaryColor,
          size: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 8,
        ),
        CustomText(
          text: "How to follow good diet plan every day.",
          color: titleBlackColor,
          size: 14,
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
                    text: "Diet plan",
                    color: titleBlackColor,
                    size: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  CustomText(
                    text: "345 people are discussing on this",
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
              onTap: () {},
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        DummyMediaSlidableWidget(
          mediaList: [
            "https://i.picsum.photos/id/1073/5472/3648.jpg?hmac=xCDetU9pLnLGZopbvHOQOkQRhTiYwyrzWc0YyHPzp5Y",
            "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"
          ],
        ),
      ],
    );
  }
}
