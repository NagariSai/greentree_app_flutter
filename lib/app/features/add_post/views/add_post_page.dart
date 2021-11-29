import 'dart:convert';

import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/media_url_widget.dart';
import 'package:fit_beat/app/common_widgets/media_widget.dart';
import 'package:fit_beat/app/common_widgets/tag_widget.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/add_post/controllers/add_post_controller.dart';
import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostPage extends StatelessWidget {
  int postType = 1;
  String negativeText = "Cancel";
  String positiveText = "Post";
  String title = "";
  String preTitle = "";
  String isOtherType = "";
  int masterPostId;
  Feed feedData;

  @override
  Widget build(BuildContext context) {
    /// postType 0 => Start a discussion, 1 => Post your challenge, 2 => Post an update,
    postType = int.parse(Get.parameters["postType"]);

    masterPostId = int.parse(Get.parameters["masterPostId"]) ?? 0;
    preTitle = Get.parameters["title"] ?? "";
    isOtherType = Get.parameters["isOtherType"] ?? "";

    setData();

    return Scaffold(
      appBar: CustomAppBar(
        negativeText: negativeText,
        positiveText: positiveText,
        onNegativeTap: () => Get.back(),
        onPositiveTap: () => Get.find<AddPostController>().submitPost(),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<AddPostController>(
        init: AddPostController(
            repository: ApiRepository(apiClient: ApiClient()),
            postType: postType,
            preTitle: preTitle,
            otherType: isOtherType,
            masterPostId: masterPostId,
            feedData: feedData),
        builder: (_) => SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (postType == 2) ...[
                    CustomText(
                      text: title,
                      color: titleBlackColor,
                      size: 21,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                  if ((postType == 0 || postType == 1) &&
                      isOtherType == "") ...[
                    CustomText(
                      text: title,
                      color: titleBlackColor,
                      size: 21,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextInputContainer(
                      controller: _.postTitleController,
                      title: "Title",
                      maxLength: 40,
                      maxLines: 2,
                      inputHint:
                          "${postType == 0 ? "Discussion" : "Challenge"} title",
                      onChange: (value) {
                        _.postTitle = value;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                  if ((postType == 0 || postType == 1) &&
                      isOtherType == "true") ...[
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: postType == 0
                                  ? catDarkGreenColor
                                  : catYellowColor,
                              shape: BoxShape.circle),
                          width: 30,
                          height: 30,
                          child: Center(
                            child: Image.asset(
                              postType == 0
                                  ? Assets.discussionIcon
                                  : Assets.challengeIcon,
                              width: 15,
                              height: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: preTitle,
                            color: titleBlackColor,
                            size: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      thickness: 4,
                      color: dividerColor,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                  TextInputContainer(
                    controller: _.descController,
                    title: "",
                    inputHint:
                        "More about your ${postType == 0 ? "discussion" : postType == 1 ? "challenge" : "update"}",
                    minLines: 5,
                    maxLength: 160,
                    maxLines: 7,
                    onChange: (value) {
                      _.postDescription = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomInputContainer(
                    title: "Add photo or video",
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            if (_.mediaUrlList.isNotEmpty) ...[
                              Flexible(
                                fit: FlexFit.loose,
                                child: ListView.separated(
                                  itemBuilder: (context, position) {
                                    return MediaUrlWidget(
                                      mediaUrl:
                                          _.mediaUrlList[position].mediaUrl,
                                      mediaType:
                                          _.mediaUrlList[position].mediaType,
                                      onRemove: () =>
                                          _.removeUrlMedia(position),
                                    );
                                  },
                                  itemCount: _.mediaUrlList.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, position) {
                                    return SizedBox(
                                      width: 8,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ],
                            if (_.mediaPathList.isNotEmpty) ...[
                              Flexible(
                                fit: FlexFit.loose,
                                child: ListView.separated(
                                  itemBuilder: (context, position) {
                                    return MediaWidget(
                                      mediaFile: _.mediaPathList[position],
                                      onRemove: () => _.removeMedia(position),
                                    );
                                  },
                                  itemCount: _.mediaPathList.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, position) {
                                    return SizedBox(
                                      width: 8,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ],
                            _.mediaPathList.length + _.mediaUrlList.length < 5
                                ? SizedBox(
                                    width: 8,
                                  )
                                : SizedBox(),
                            _.mediaPathList.length + _.mediaUrlList.length < 5
                                ? MediaWidget(
                                    onTap: () => _.addMedia(context),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TagWidget(
                    selectedString:
                        _.feedData == null ? null : _.selectedStringTags,
                    suggestedTags:
                        _.masterTagEntity.data.map((e) => e.title).toList(),
                    onTagsChanged: (value) {
                      _.selectedStringTags = value;
                      print("selectedStringTags => ${_.selectedStringTags}");
                    },
                  ),
                ],
              ),
            ));
  }

  void setData() {
    try {
      String data =
          Get.parameters.containsKey("feed") ? Get.parameters["feed"] : null;

      feedData = data != null ? Feed.fromJson(jsonDecode(data)) : null;

      print("fdattta ${feedData.userId}");
    } catch (_) {
      print("except ${_.toString()}");
    }
    if (postType == 0) {
      positiveText = "Start";
      title = "Start a discussion";
    } else if (postType == 1) {
      title = "Post your challenge";
    } else if (postType == 2) {
      title = "Post an update";
    }
  }
}
