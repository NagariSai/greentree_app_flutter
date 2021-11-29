import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';

class FeedUpdateWidget extends StatelessWidget {
  final Feed feedData;

  const FeedUpdateWidget({Key key, this.feedData}) : super(key: key);

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
          maxLines: 3,
          color: titleBlackColor,
          size: 14,
        ),
        SizedBox(
          height: 8,
        ),
        MediaSlidableWidget(
          mediaList: feedData.userMedia,
        ),
      ],
    );
  }
}
