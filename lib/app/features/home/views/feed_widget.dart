import 'dart:convert';

import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/features/common_controller.dart';
import 'package:fit_beat/app/features/home/views/feed_challenge_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_discussion_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_receipe_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_transformation_widget.dart';
import 'package:fit_beat/app/features/home/views/feed_update_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/time_ago.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedWidget extends StatelessWidget {
  final Feed feedData;
  final Function onClickLikeUnLike;
  final Function onClickBookmark;

  const FeedWidget(
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
          /*Get.toNamed(Routes.otherFeedPage, parameters: {
            "count": feedData.triedCount.toString(),
            "title": feedData.title,
            "isChallenge": "false",
            "masterPostId": feedData.uniqueId.toString()
          });*/

          Get.toNamed(Routes.discussion_detail_page, arguments: [
            feedData.uniqueId,
            feedData.type,
            feedData.triedCount,
            feedData.title
          ]);
        } else if (feedData.type == 2) {
          // Get.toNamed(Routes.challenge_detail_page,
          //     arguments: [feedData.uniqueId, feedData.type]);
          Get.toNamed(Routes.otherFeedPage, parameters: {
            "count": feedData.triedCount.toString(),
            "title": feedData.title,
            "isChallenge": "true",
            "masterPostId": feedData.uniqueId.toString()
          });
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
                    child: CircularImage(
                      imageUrl: feedData.profileUrl,
                    )),
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
            if (feedData.type == 1) ...[
              FeedDiscussionWidget(feedData: feedData),
            ],
            if (feedData.type == 2) ...[
              FeedChallengeWidget(feedData: feedData),
            ],
            if (feedData.type == 3) ...[
              FeedTransformationWidget(feedData: feedData),
            ],
            if (feedData.type == 4) ...[
              FeedRecipeWidget(feedData: feedData),
            ],
            if (feedData.type == 5) ...[
              FeedUpdateWidget(feedData: feedData),
            ],
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
                    onTap: () async {
                      if (feedData.isMyBookmark == 1) {
                        //unlike

                        var result = await DialogUtils.customDialog(
                            title: "UnBookmark",
                            description: "Are you sure you want to UnBookmark?",
                            firstButtonTitle: "Yes, UnBookmark",
                            secondButtonTitle: "Cancel");

                        if (result) {
                          feedData.isMyBookmark = 0;
                          try {
                            Utils.showLoadingDialog();
                            await Get.find<CommonController>().bookmarkPost(
                                uniqueId: feedData.uniqueId,
                                type: feedData.type);
                            Utils.dismissLoadingDialog();
                          } catch (e) {
                            Utils.dismissLoadingDialog();
                          }
                        }
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
            if (feedData.userId == PrefData().getUserData().userId) ...[
              CupertinoActionSheetAction(
                child: CustomText(
                  text: "Edit",
                  size: 17,
                  fontWeight: FontWeight.w500,
                  color: errorColor,
                ),
                isDefaultAction: true,
                onPressed: () {
                  print("xccxcxc${feedData.type}");

                  if (feedData.type == 3) {
                    Get.back();
                    Get.toNamed(Routes.addTransformationPost,
                        arguments: feedData);
                  } else if (feedData.type == 1) {
                    Get.back();
                    Get.toNamed(Routes.addPost, parameters: {
                      "postType": "0",
                      "title": "",
                      "isOtherType": "",
                      "masterPostId": "0",
                      "feed": jsonEncode(feedData.toJson())
                    });
                  } else if (feedData.type == 2) {
                    Get.back();
                    Get.toNamed(Routes.addPost, parameters: {
                      "postType": "1",
                      "title": "",
                      "isOtherType": "",
                      "masterPostId": "0",
                      "feed": jsonEncode(feedData.toJson())
                    });
                  } else if (feedData.type == 5) {
                    Get.back();
                    Get.toNamed(Routes.addPost, parameters: {
                      "postType": "2",
                      "title": "",
                      "isOtherType": "",
                      "masterPostId": "0",
                      "feed": jsonEncode(feedData.toJson())
                    });
                  } else if (feedData.type == 4) {
                    Get.back();
                    Get.toNamed(Routes.ADD_RECIPE, arguments: feedData);
                  }
                  /* controller.deletePost(
                    uniqueId: feedData.uniqueId, type: feedData.type);
                Get.back();*/
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
                onPressed: () async {
                  var result = await DialogUtils.customDialog(
                      title: "Delete",
                      description: "Are you sure you want to delete this post?",
                      firstButtonTitle: "Yes, Delete",
                      secondButtonTitle: "Cancel");

                  if (result) {
                    try {
                      Utils.showLoadingDialog();
                      controller.deletePost(
                          uniqueId: feedData.uniqueId, type: feedData.type);
                      Utils.dismissLoadingDialog();
                    } catch (e) {
                      Utils.dismissLoadingDialog();
                    }
                  }

                  Get.back();
                },
              ),
            ],
            if (feedData.userId != PrefData().getUserData().userId) ...[
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
            ],
          ],
          cancelButton: CupertinoActionSheetAction(
            child: CustomText(
              text: "Cancel",
              size: 17,
              fontWeight: FontWeight.w500,
              color: cancelTextColor,
            ),
            isDefaultAction: false,
            onPressed: () {
              Get.back();
            },
          )),
    );
  }
}
