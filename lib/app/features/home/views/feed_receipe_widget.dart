import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';

class FeedRecipeWidget extends StatelessWidget {
  final Feed feedData;
  final bool showFullDescription;
  final double calories;
  const FeedRecipeWidget(
      {Key key, this.feedData, this.showFullDescription = false, this.calories})
      : super(key: key);

  getCalories() {
    final protein = feedData?.userRecipeColories[0]?.protein ?? 0.0;
    final carb = feedData?.userRecipeColories[0]?.carbs ?? 0.0;
    final fat = feedData?.userRecipeColories[0]?.fat ?? 0.0;

    final kcal = (protein * 4) + (carb * 4) + (fat * 9);
    return kcal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: feedData.title,
          color: titleBlackColor,
          size: 16,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 4,
        ),
        CustomText(
          text: feedData.descriptions ?? "",
          color: titleBlackColor,
          size: 14,
          maxLines: showFullDescription ? 100 : 3,
        ),
        SizedBox(
          height: 8,
        ),
        Stack(
          children: [
            MediaSlidableWidget(
              mediaList: feedData.userMedia,
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
                        text: "${getCalories() ?? 0.0} Kcal",
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
                        text: feedData.cookingDuration ?? "NA",
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
                        text:
                            Utils.formatFoodType(feedData.foodType.toString()),
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
