import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/home/views/dummy_media_slidable_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_button.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DummyFeedUpdateWidget extends StatelessWidget {
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
          text: "Today's new workout",
          color: titleBlackColor,
          size: 14,
        ),
        SizedBox(
          height: 8,
        ),
        DummyMediaSlidableWidget(
          mediaList: [
            "https://i.picsum.photos/id/30/1280/901.jpg?hmac=A_hpFyEavMBB7Dsmmp53kPXKmatwM05MUDatlWSgATE",
            "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"
          ],
        ),
      ],
    );
  }
}
