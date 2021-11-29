import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/home/views/dummy_media_slidable_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_button.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DummyFeedChallengeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "#Fitness",
          color: primaryColor,
          size: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 8,
        ),
        CustomText(
          text: "My 5 minutes challenge",
          color: titleBlackColor,
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
                    text: "Workout Challenge",
                    color: titleBlackColor,
                    size: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  CustomText(
                    text: "2,345 people tried this challenge",
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
              onTap: () {},
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        DummyMediaSlidableWidget(
          mediaList: [
            "https://i.picsum.photos/id/390/5760/3840.jpg?hmac=iQnvcvi8NX5BkurqLHAciZ_amDp8IOVXSVbi-27Iaro",
            "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"
          ],
        ),
      ],
    );
  }
}
