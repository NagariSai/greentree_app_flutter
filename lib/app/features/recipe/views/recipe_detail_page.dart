import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/comment_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/common_controller.dart';
import 'package:fit_beat/app/features/home/views/feed_receipe_widget.dart';
import 'package:fit_beat/app/features/recipe/controller/recipe_details_controller.dart';
import 'package:fit_beat/app/features/recipe/views/receipe_calories.dart';
import 'package:fit_beat/app/features/recipe/views/recipe_ingredients.dart';
import 'package:fit_beat/app/features/recipe/views/recipe_steps.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/time_ago.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeDetailPage extends StatefulWidget {
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> tabs = <Widget>[
    Container(height: 36, width: Get.width / 3, child: Tab(text: "Calories")),
    Container(
        height: 36, width: Get.width / 3, child: Tab(text: "Ingredients")),
    Container(height: 36, width: Get.width / 3, child: Tab(text: "Prep.Steps")),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: "",
      ),
      /*bottomNavigationBar: GetBuilder<RecipeDetailsController>(builder: (_) {
        return _.isLoading
            ? Container(
                height: 64,
              )
            : Container(
                height: 64,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: FFFFFFFF,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        _.feedData?.isMyLike == 1
                            ? Assets.likeFilledIcon
                            : Assets.like,
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        _.feedData?.totalLikes?.toString() ?? "0",
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
                        _.feedData?.totalComments?.toString() ?? "",
                        style: TextStyle(
                            color: titleBlackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Spacer(),
                      Image.asset(
                        Assets.bookmark,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              );
      }),*/
      body: SafeArea(
        bottom: true,
        child: GetBuilder<RecipeDetailsController>(
            init: RecipeDetailsController(
                repository: ApiRepository(apiClient: ApiClient())),
            builder: (_) {
              return _.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _.feedData != null
                      ? Stack(
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    _createTopView(),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                      child: CommonContainer(
                                        height: 36,
                                        width: Get.width,
                                        borderRadius: 40,
                                        backgroundColor: FFE0EAEE,
                                        child: TabBar(
                                          isScrollable: false,
                                          unselectedLabelColor: FF6D7274,
                                          labelColor: FFFFFFFF,
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          indicator: CustomTabIndicator(
                                            indicatorHeight: 31.0,
                                            indicatorColor: FF025074,
                                            indicatorRadius: 40,
                                          ),
                                          tabs: tabs,
                                          controller: _tabController,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 200,
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: [
                                            ReceipeCalories(),
                                            RecipeIngredients(
                                              userRecipeIngredients: _.feedData
                                                  .userRecipeIngredients,
                                            ),
                                            RecipeSteps(
                                              userRecipePreparationSteps: _
                                                  .feedData
                                                  .userRecipePreparationSteps,
                                            ),
                                          ],
                                        )),
                                    Divider(
                                      thickness: 1,
                                      color: dividerColor,
                                    ),
                                    _.isCommentLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                child: CustomText(
                                                  text:
                                                      "Comments ${_.commentList.length}",
                                                  size: 16,
                                                  color: FF050707,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              _.commentList.length > 0
                                                  ? ListView.builder(
                                                      itemCount:
                                                          _.commentList.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        Comment comment = _
                                                            .commentList[index];

                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 8),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  CircularImage(
                                                                    imageUrl:
                                                                        comment.profileUrl ??
                                                                            "",
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Expanded(
                                                                    child: CommonContainer(
                                                                        borderRadius: 16,
                                                                        backgroundColor: _.index != null && index == _.index ? FFB4C9D2 : Colors.transparent,
                                                                        child: Padding(
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
                                                                                overflow: null,
                                                                                color: FF050707,
                                                                                size: 14,
                                                                                maxLines: 5,
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
                                                                      width:
                                                                          48),
                                                                  CustomText(
                                                                    text:
                                                                        "${TimeAgoExtension.displayTimeAgoFromTimestamp(comment.createDatetime.toLocal().toIso8601String())}",
                                                                    size: 12,
                                                                    color:
                                                                        FF6D7274,
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          24),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      print(
                                                                          "feedData.isMyLike : ${comment.isMyLike}");
                                                                      if (comment
                                                                              .isMyLike ==
                                                                          1) {
                                                                        _.disLikeComment(
                                                                            comment.userCommentId,
                                                                            index);
                                                                      } else {
                                                                        _.likeComment(
                                                                            comment.userCommentId,
                                                                            index);
                                                                      }
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      comment.isMyLike == 1
                                                                          ? Assets
                                                                              .likeFilledIcon
                                                                          : Assets
                                                                              .like,
                                                                      width: 24,
                                                                      height:
                                                                          24,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Text(
                                                                    comment
                                                                        .totalLikes
                                                                        ?.toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            titleBlackColor,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          24),
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
                                                                    child: Image
                                                                        .asset(
                                                                      Assets
                                                                          .ic_reshare,
                                                                      width: 22,
                                                                      height:
                                                                          22,
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
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              comment.subComment
                                                                          .length >
                                                                      0
                                                                  ? ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: comment
                                                                              .subComment
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            Comment
                                                                                subcomment =
                                                                                comment.subComment[index];

                                                                            return Row(
                                                                              children: [
                                                                                const SizedBox(width: 48),
                                                                                CircularImage(
                                                                                  imageUrl: subcomment.profileUrl ?? "",
                                                                                ),
                                                                                const SizedBox(width: 8),
                                                                                CommonContainer(
                                                                                    height: 52,
                                                                                    borderRadius: 16,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Column(
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
                                                                                            overflow: null,
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
                                                          text:
                                                              "No Comments to show",
                                                          color: primaryColor,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                    SizedBox(height: 64),
                                  ],
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
                                            imageUrl:
                                                PrefData().getProfileUrl(),
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
                                              height: 80,
                                              maxlines: null,
                                              bgColor: FFE8EFF2,
                                              inputType: TextInputType.text,
                                              onFieldSubmitted: (v) {
                                                // _.addComment();
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
                            )
                          ],
                        )
                      : Center(
                          child: CustomText(
                          text: "No data Found.",
                          textAlign: TextAlign.center,
                        ));
            }),
      ),
    );
  }

  Widget _createTopView() {
    return GetBuilder<RecipeDetailsController>(builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      if (PrefData().getUserData().userId ==
                          _.feedData.userId) {
                        Get.toNamed(Routes.myProfile);
                      } else {
                        Get.toNamed(Routes.userProfile,
                            arguments: [_.feedData.userId, _.feedData.type]);
                      }
                    },
                    child: CircularImage(
                      imageUrl: _.feedData.profileUrl ?? "",
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
                                    _.feedData.userId) {
                                  Get.toNamed(Routes.myProfile);
                                } else {
                                  Get.toNamed(Routes.userProfile, arguments: [
                                    _.feedData.userId,
                                    _.feedData.type
                                  ]);
                                }
                              },
                              child: Text(
                                _.feedData.fullName ?? "NA",
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
                            TimeAgoExtension.displayTimeAgoFromTimestamp(_
                                .feedData.updateDatetime
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
                            "Recipe",
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
            const SizedBox(height: 8),
            FeedRecipeWidget(
              feedData: _.feedData,
              showFullDescription: true,
              calories: _.getCalories(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonContainer(
                    height: 90,
                    borderRadius: 12,
                    backgroundColor: FFF1F3F3,
                    shadowColor: FFFFFFFF,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.ic_lunch,
                          width: 32,
                          height: 30,
                        ),
                        CustomText(
                          text: "Lunch",
                          size: 12,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonContainer(
                    height: 90,
                    borderRadius: 12,
                    backgroundColor: FFF1F3F3,
                    shadowColor: FFFFFFFF,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.ic_servings,
                          width: 32,
                          height: 30,
                        ),
                        CustomText(
                          text: "Servings ${_.feedData.servings ?? ""}",
                          size: 12,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonContainer(
                    height: 90,
                    borderRadius: 12,
                    backgroundColor: FFF1F3F3,
                    shadowColor: FFFFFFFF,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.ic_italian,
                          width: 32,
                          height: 30,
                        ),
                        CustomText(
                          text: "Italian",
                          size: 12,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  Widget showReplyMode() {
    return GetBuilder<RecipeDetailsController>(builder: (_) {
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
    var _ = Get.find<RecipeDetailsController>();

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
