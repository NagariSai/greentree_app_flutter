import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/features/common_controller.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/time_ago.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherFeedWidget extends StatelessWidget {
  final Feed feedData;
  final Function onClickLikeUnLike;
  final Function onClickBookmark;

  const OtherFeedWidget(
      {Key key,
      @required this.feedData,
      this.onClickLikeUnLike,
      this.onClickBookmark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (feedData.type == 1) {
          Get.toNamed(Routes.discussion_detail_page,
              arguments: [feedData.uniqueId, feedData.type]);
        } else if (feedData.type == 2) {
          Get.toNamed(Routes.challenge_detail_page, arguments: [
            feedData.uniqueId,
            feedData.type,
          ]);
        } else if (feedData.type == 3) {
          Get.toNamed(Routes.transformation_detail_page,
              arguments: [feedData.uniqueId, feedData.type]);
        } else if (feedData.type == 4) {
          Get.toNamed(Routes.receipe_detail_page,
              arguments: [feedData.uniqueId, feedData.type]);
        } else if (feedData.type == 5) {
          Get.toNamed(Routes.post_update_detail_page,
              arguments: [feedData.uniqueId, feedData.type]);
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      if (PrefData().getUserData().userId == feedData.userId) {
                        Get.toNamed(Routes.myProfile);
                      } else {
                        Get.toNamed(Routes.userProfile,
                            arguments: [feedData.userId, feedData.type]);
                      }
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
                                if (PrefData().getUserData().userId ==
                                    feedData.userId) {
                                  Get.toNamed(Routes.myProfile);
                                } else {
                                  Get.toNamed(Routes.userProfile, arguments: [
                                    feedData.userId,
                                    feedData.type
                                  ]);
                                }
                              },
                              child: Text(
                                feedData.fullName ?? "NA",
                                style: TextStyle(
                                    color: titleBlackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _openDialog(context);
                            },
                            child: Image.asset(
                              Assets.ellipses,
                              width: 20,
                            ),
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
                            TimeAgoExtension.displayTimeAgoFromTimestamp(
                                feedData.updateDatetime
                                    .toLocal()
                                    .toIso8601String()),
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
                            Strings.postType[feedData.type],
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
            ),
            SizedBox(
              height: 16,
            ),
            MediaSlidableWidget(mediaList: feedData.userMedia),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      print("feedData.isMyLike : ${feedData.isMyLike}");
                      if (feedData.isMyLike == 1) {
                        //unlike
                        feedData.isMyLike = 0;
                        feedData.totalLikes = feedData.totalLikes - 1;
                        Get.find<CommonController>().likePost(
                            uniqueId: feedData.uniqueId, type: feedData.type);
                      } else {
                        feedData.isMyLike = 1;
                        feedData.totalLikes = feedData.totalLikes + 1;
                        Get.find<CommonController>().likePost(
                            uniqueId: feedData.uniqueId, type: feedData.type);
                      }
                      onClickLikeUnLike?.call();
                    },
                    child: Image.asset(
                      feedData.isMyLike == 1
                          ? Assets.likeFilledIcon
                          : Assets.like,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    feedData.totalLikes?.toString(),
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
                    feedData.totalComments?.toString(),
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
                  InkWell(
                    onTap: () {
                      if (feedData.isMyBookmark == 1) {
                        //unlike
                        feedData.isMyBookmark = 0;
                        Get.find<CommonController>().bookmarkPost(
                            uniqueId: feedData.uniqueId, type: feedData.type);
                      } else {
                        feedData.isMyBookmark = 1;
                        Get.find<CommonController>().bookmarkPost(
                            uniqueId: feedData.uniqueId, type: feedData.type);
                      }
                      onClickBookmark?.call();
                    },
                    child: Image.asset(
                      feedData.isMyBookmark == 1
                          ? Assets.fillBookmark
                          : Assets.bookmark,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openDialog(BuildContext context) {
    var controller = Get.find<CommonController>();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: CustomText(
              text: "Report Post",
              size: 17,
              fontWeight: FontWeight.w500,
              color: errorColor,
            ),
            isDefaultAction: true,
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.report_user,
                  arguments: [feedData.uniqueId, feedData.type, 1]);
              // Navigator.pop(context, 'discussion');
            },
          ),
          CupertinoActionSheetAction(
            child: CustomText(
              text: "Delete",
              size: 17,
              fontWeight: FontWeight.w500,
              color: errorColor,
            ),
            isDefaultAction: true,
            onPressed: () {
              controller.deletePost(
                  uniqueId: feedData.uniqueId, type: feedData.type);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
