import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/home/views/dummy_media_slidable_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_button.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DummyFeedRecipeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Spiced and Seared Flank Steak",
          color: titleBlackColor,
          size: 16,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 4,
        ),
        CustomText(
          text:
              "Steak, peas, and carrots are a familiar trio, and usually not very exciting. Here, each element is transformed: a smoky",
          color: titleBlackColor,
          size: 14,
          maxLines: 3,
        ),
        SizedBox(
          height: 8,
        ),
        Stack(
          children: [
            DummyMediaSlidableWidget(
              mediaList: [
                "https://i.picsum.photos/id/225/1500/979.jpg?hmac=jvGoek9ng_Y0GaBbzxN0KJhHaiPtk1VfRcukK8R8FxQ",
                "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"
              ],
            ),
            Positioned(
              bottom: 8,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        Assets.foodCalIcon,
                        width: 19,
                        height: 24,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: "343 Kcal",
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        Assets.foodTimeIcon,
                        width: 19,
                        height: 24,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: "15:00",
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        Assets.foodTypeIcon,
                        width: 19,
                        height: 24,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: "Nonveg",
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
