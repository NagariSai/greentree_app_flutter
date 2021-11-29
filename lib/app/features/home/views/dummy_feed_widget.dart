import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/features/home/views/dummy_feed_challenge_widget.dart';
import 'package:fit_beat/app/features/home/views/dummy_feed_discussion_widget.dart';
import 'package:fit_beat/app/features/home/views/dummy_feed_receipe_widget.dart';
import 'package:fit_beat/app/features/home/views/dummy_feed_transformation_widget.dart';
import 'package:fit_beat/app/features/home/views/dummy_feed_update_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_challenge_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_discussion_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_receipe_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_transformation_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_update_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DummyFeedWidget extends StatelessWidget {
  final int feedType;

  const DummyFeedWidget({Key key, @required this.feedType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Get.toNamed(Routes.userProfile);
                  },
                  child: CircularImage()),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.userProfile);
                            },
                            child: Text(
                              "Arven juhi",
                              style: TextStyle(
                                  color: titleBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Image.asset(
                          Assets.ellipses,
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "45m",
                          style: TextStyle(
                            color: descriptionColor,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          "  |  ",
                          style: TextStyle(
                            color: descriptionColor,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          Strings.postType[feedType],
                          style: TextStyle(
                            color: descriptionColor,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          if (feedType == 1) ...[
            DummyFeedTransformationWidget(),
          ],
          if (feedType == 2) ...[
            DummyFeedDiscussionWidget(),
          ],
          if (feedType == 3) ...[
            DummyFeedUpdateWidget(),
          ],
          if (feedType == 4) ...[
            DummyFeedChallengeWidget(),
          ],
          if (feedType == 5) ...[
            DummyFeedRecipeWidget(),
          ],
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  Assets.like,
                  width: 24,
                  height: 24,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "31",
                  style: TextStyle(
                      color: titleBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 24,
                ),
                Image.asset(
                  Assets.comment,
                  width: 24,
                  height: 24,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "12",
                  style: TextStyle(
                      color: titleBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 24,
                ),
                /* Image.asset(
                  Assets.share,
                  width: 24,
                  height: 24,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "10",
                  style: TextStyle(
                      color: titleBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),*/
                Spacer(),
                Image.asset(
                  Assets.bookmark,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
