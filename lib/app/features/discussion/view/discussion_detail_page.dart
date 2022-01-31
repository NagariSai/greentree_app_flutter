import 'dart:convert';

import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/data/model/comment_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/discussion/controller/discussion_detail_controller.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/time_ago.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import '../../common_controller.dart';

class DiscussionDetailPage extends StatefulWidget {
  @override
  _DiscussionDetailPageState createState() => _DiscussionDetailPageState();
}

class _DiscussionDetailPageState extends State<DiscussionDetailPage> {
  @override
  Widget build(BuildContext context) {
    print("diss");
    return Scaffold(
      backgroundColor: bodybgColor,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: "",
      ),
      body: SafeArea(
        bottom: true,
        child: GetBuilder<DiscussionDetailController>(
            init: DiscussionDetailController(
                repository: ApiRepository(apiClient: ApiClient())),
            builder: (_) {
              return GetBuilder<DiscussionDetailController>(builder: (_) {
                return _.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          Positioned(
                            child: SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(vertical: 8,
                                            horizontal: 16),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            catDarkGreenColor,
                                                        shape: BoxShape.circle),
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                          text:
                                                              _.discussionTitle,
                                                          color:
                                                              titleBlackColor,
                                                          size: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        CustomText(
                                                          text:
                                                              "${_.triedCount} people are discussing on this",
                                                          color:
                                                              descriptionColor,
                                                          size: 11,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Divider(
                                                thickness: 1,
                                                color: dividerColor,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        if (PrefData()
                                                                .getUserData()
                                                                .userId ==
                                                            _.feedData.userId) {
                                                          Get.toNamed(
                                                              Routes.myProfile);
                                                        } else {
                                                          Get.toNamed(
                                                              Routes
                                                                  .userProfile,
                                                              arguments: [
                                                                _.feedData
                                                                    .userId,
                                                                _.feedData.type
                                                              ]);
                                                        }
                                                      },
                                                      child: CircularImage(
                                                        imageUrl: _.feedData
                                                                .profileUrl ??
                                                            "",
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Get.toNamed(
                                                                      Routes
                                                                          .userProfile,
                                                                      arguments: [
                                                                        _.feedData
                                                                            .userId,
                                                                        _.feedData
                                                                            .type
                                                                      ]);
                                                                },
                                                                child: Text(
                                                                  _.feedData
                                                                          .fullName ??
                                                                      "NA",
                                                                  style: TextStyle(
                                                                      color:
                                                                          titleBlackColor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                _openDialog(
                                                                    context);
                                                              },
                                                              child:
                                                                  Image.asset(
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              TimeAgoExtension
                                                                  .displayTimeAgoFromTimestamp(_
                                                                      .feedData
                                                                      .updateDatetime
                                                                      .toLocal()
                                                                      .toIso8601String()),
                                                              style: TextStyle(
                                                                color:
                                                                    descriptionColor,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                            Text(
                                                              "  |  ",
                                                              style: TextStyle(
                                                                color:
                                                                    descriptionColor,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                            Text(
                                                              Strings.postType[_
                                                                  .feedData
                                                                  .type],
                                                              style: TextStyle(
                                                                color:
                                                                    descriptionColor,
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
                                              CustomText(
                                                text: Utils.getFormattedTags(
                                                    _.feedData.userTags),
                                                maxLines: 2,
                                                color: primaryColor,
                                                size: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              CustomText(
                                                text: _.feedData.descriptions,
                                                color: titleBlackColor,
                                                overflow: null,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              MediaSlidableWidget(
                                                mediaList: _.feedData.userMedia,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            "feedData.isMyLike : ${_.feedData.isMyLike}");
                                                        if (_.feedData
                                                                .isMyLike ==
                                                            1) {
                                                          _.disLike();
                                                        } else {
                                                          _.like();
                                                        }
                                                      },
                                                      child: Image.asset(
                                                        _.feedData.isMyLike == 1
                                                            ? Assets
                                                                .likeFilledIcon
                                                            : Assets.like,
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      _.feedData.totalLikes
                                                          ?.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              titleBlackColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                      _.feedData.totalComments
                                                          ?.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              titleBlackColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    Spacer(),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (_.feedData
                                                                .isMyBookmark ==
                                                            1) {
                                                          var result = await DialogUtils.customDialog(
                                                              title:
                                                                  "UnBookmark",
                                                              description:
                                                                  "Are you sure you want to UnBookmark?",
                                                              firstButtonTitle:
                                                                  "Yes, UnBookmark",
                                                              secondButtonTitle:
                                                                  "Cancel");

                                                          if (result) {
                                                            try {
                                                              Utils
                                                                  .showLoadingDialog();
                                                              await _
                                                                  .unBookmark();
                                                              Utils
                                                                  .dismissLoadingDialog();
                                                            } catch (e) {
                                                              Utils
                                                                  .dismissLoadingDialog();
                                                            }
                                                          }
                                                        } else {
                                                          _.bookMark();
                                                        }
                                                      },
                                                      child: Image.asset(
                                                        _.feedData.isMyBookmark ==
                                                                1
                                                            ? Assets
                                                                .fillBookmark
                                                            : Assets.bookmark,
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                            ])),
                                    Divider(),
                                    _.isCommentLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : _.commentList.length > 0
                                            ? ListView.builder(
                                                itemCount: _.commentList.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Comment comment =
                                                      _.commentList[index];

                                                  return Container(
                                                    key: Key("key$index"),
                                                    margin: EdgeInsets.only(
                                                        bottom: 8),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircularImage(
                                                              imageUrl: comment
                                                                      .profileUrl ??
                                                                  "",
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            Expanded(
                                                              child:
                                                                  CommonContainer(
                                                                      key: Key(
                                                                          "key$index"),
                                                                      borderRadius:
                                                                          16,
                                                                      backgroundColor: _.index != null && index == _.index
                                                                          ? FFB4C9D2
                                                                          : Colors
                                                                              .transparent,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            CustomText(
                                                                              text: "${comment.fullName ?? ""}",
                                                                              color: FF050707,
                                                                              size: 14,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            CustomText(
                                                                              text: "${comment.commentDescription ?? ""}",
                                                                              maxLines: 5,
                                                                              color: FF050707,
                                                                              size: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                                width: 48),
                                                            CustomText(
                                                              text:
                                                                  "${TimeAgoExtension.displayTimeAgoFromTimestamp(comment.createDatetime.toLocal().toIso8601String())}",
                                                              size: 12,
                                                              color: FF6D7274,
                                                            ),
                                                            const SizedBox(
                                                                width: 24),
                                                            InkWell(
                                                              onTap: () {
                                                                if (comment
                                                                        .isMyLike ==
                                                                    1) {
                                                                  _.disLikeComment(
                                                                      comment
                                                                          .userCommentId,
                                                                      index);
                                                                } else {
                                                                  _.likeComment(
                                                                      comment
                                                                          .userCommentId,
                                                                      index);
                                                                }
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                comment.isMyLike ==
                                                                        1
                                                                    ? Assets
                                                                        .likeFilledIcon
                                                                    : Assets
                                                                        .like,
                                                                width: 24,
                                                                height: 24,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              comment.totalLikes
                                                                  ?.toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                      titleBlackColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                                width: 24),
                                                            InkWell(
                                                              onTap: () {
                                                                _.onCommentReply(
                                                                    comment
                                                                        .fullName,
                                                                    comment
                                                                        .userCommentId,
                                                                    comment
                                                                        .type,
                                                                    index);
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                Assets
                                                                    .ic_reshare,
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              comment
                                                                  .totalSubComment
                                                                  ?.toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                      titleBlackColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        comment.subComment
                                                                    .length >
                                                                0
                                                            ? ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount: comment
                                                                    .subComment
                                                                    .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  Comment
                                                                      subcomment =
                                                                      comment.subComment[
                                                                          index];

                                                                  return Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                          width:
                                                                              48),
                                                                      CircularImage(
                                                                        imageUrl:
                                                                            subcomment.profileUrl ??
                                                                                "",
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              8),
                                                                      CommonContainer(
                                                                          height:
                                                                              52,
                                                                          borderRadius:
                                                                              0,
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                CustomText(
                                                                                  text: "${subcomment.fullName ?? ""}",
                                                                                  color: FF050707,
                                                                                  size: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                CustomText(
                                                                                  text: "${subcomment.commentDescription ?? ""}",
                                                                                  color: FF050707,
                                                                                  size: 14,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  );
                                                                })
                                                            : Container()
                                                      ],
                                                    ),
                                                  );
                                                })
                                            : Container(
                                                child: Center(
                                                  child: CustomText(
                                                    text: "No Comments to show",
                                                    color: primaryColor,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                    SizedBox(height: 64),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: FFFFFFFF,
                              padding: EdgeInsets.all(16),
                              height: _.isReplyClick ? 90 : 80,
                              child: _.isReplyClick
                                  ? showReplyMode()
                                  : Row(
                                      children: [
                                        CircularImage(
                                          imageUrl: PrefData().getProfileUrl(),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: CustomTextField(
                                            controller: _.commentController,
                                            hintText: "Write Comment...",
                                            textColor: FF6D7274,
                                            hintColor: hintColor,
                                            maxlines: null,
                                            height: 80,
                                            bgColor: FFE8EFF2,
                                            inputType: TextInputType.text,
                                            onFieldSubmitted: (v) {
                                              _.addComment();
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            _.addComment();
                                          },
                                          child: Icon(
                                            Icons.send,
                                            color: FF025074,
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      );
              });
            }),
      ),
    );
  }

  Widget showReplyMode() {
    return GetBuilder<DiscussionDetailController>(builder: (_) {
      return InkWell(
        onTap: () {
          _.clearReplay();
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    CustomText(
                      text: "Replying to",
                      color: FF6D7274,
                      size: 12,
                    ),
                    CustomText(
                      text: "${_.replayUser}",
                      color: FF050707,
                      fontWeight: FontWeight.bold,
                      size: 12,
                    ),
                    InkWell(
                        onTap: () {
                          _.clearReplay();
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 16,
                        ))
                  ],
                ),
              ),
              Row(
                children: [
                  CircularImage(
                    imageUrl: PrefData().getProfileUrl(),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CustomTextField(
                      controller: _.replyCommentController,
                      hintText: "Write Replay...",
                      textColor: FF6D7274,
                      hintColor: hintColor,
                      maxlines: null,
                      bgColor: FFE8EFF2,
                      inputType: TextInputType.text,
                      onFieldSubmitted: (v) {
                        _.addRelyComment();
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      _.addRelyComment();
                    },
                    child: Icon(
                      Icons.send,
                      color: FF025074,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  void _openDialog(BuildContext context) {
    var controller = Get.find<CommonController>();
    var _ = Get.find<DiscussionDetailController>();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          actions: <Widget>[
            if (_.feedData.userId == PrefData().getUserData().userId) ...[
              CupertinoActionSheetAction(
                child: CustomText(
                  text: "Edit",
                  size: 17,
                  fontWeight: FontWeight.w500,
                  color: errorColor,
                ),
                isDefaultAction: true,
                onPressed: () {
                  Get.back();
                  Get.back();
                  Get.toNamed(Routes.addPost, parameters: {
                    "postType": "0",
                    "title": "",
                    "isOtherType": "",
                    "masterPostId": "0",
                    "feed": jsonEncode(_.feedData.toJson())
                  });
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
                          uniqueId: _.feedData.uniqueId, type: _.type);
                      Utils.dismissLoadingDialog();
                    } catch (e) {
                      Utils.dismissLoadingDialog();
                    }
                  }

                  Get.back();
                },
              ),
            ],
            if (_.feedData.userId != PrefData().getUserData().userId) ...[
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
                      arguments: [_.feedData.uniqueId, _.feedData.type, 1]);
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
