import 'dart:convert';

import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/views/feed_button.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/features/home/views/video_widget.dart';
import 'package:fit_beat/app/features/search/controller/search_details_controller.dart';
import 'package:fit_beat/app/features/search/view/search_feed.dart';

import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/time_ago.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../common_controller.dart';
class SearchDetailsPage extends StatefulWidget  {


  @override
  _ItemsViewState createState() => _ItemsViewState();
}




class _ItemsViewState extends State<SearchDetailsPage> {
  ScrollController scrollController = ScrollController();
  bool isInView=false;
  ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;


  @override
  void initState() {
    super.initState();

    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });

    scrollController.addListener(() {

    /*  if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        Get.find<SearchController>().searchData("test");
        setState(() {
        });

      }*/


    });
  }
  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

/*
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(

              height: _showAppbar ? 56.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: AppBar(
                title: Text('Expore'),
                actions: <Widget>[
                  //add buttons here
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: _scrollViewController,
                child: Column(
                  children: <Widget>[
                    //add your screen content here
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
*/
    return Scaffold(

      backgroundColor: bodybgColor,
        appBar: CustomAppBar(


          title: "Explore",
          positiveText: "",
          onPositiveTap: () {},
          onNegativeTap: () {
            Get.back();
          },
          negativeText: "",
        ),

      body: GetX<SearchDetailsController>(

        init: SearchDetailsController(repository: ApiRepository(apiClient: ApiClient())),

        builder: (_) => _.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : LazyLoadScrollView(
          onEndOfPage: () => _.loadNextsearchData("test"),
          //  isLoading: _.feedLastPage,

          child: RefreshIndicator(
            key: _.indicator,
            onRefresh: _.reloadFeeds,
            child: SingleChildScrollView(
              //  controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Flexible(
                    fit: FlexFit.loose,
                    child:   _.feedList.length > 0
                        ? ListView.separated(
                      itemCount: _.feedList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildSearchDetails(_.feedList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1,
                          color: dividerColor,
                        );
                      },
                    )
                        : Container(
                      height: Get.height * 0.4,
                      child: Center(
                        child: CustomText(
                          text: "No data found",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),


/*
      body: GetBuilder<SearchDetailsController>(
        init: SearchDetailsController(repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) => _.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )

            : LazyLoadScrollView(
          onEndOfPage: () => _.loadNextsearchData("test"),
         // isLoading: _.feedLastPage,
          child: RefreshIndicator(

            key: _.indicator,
            onRefresh: _.reloadFeeds,
            child: SingleChildScrollView(

              controller: scrollController,
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [



                  Flexible(
                    fit: FlexFit.loose,
                    child: _.feedList.length > 0
                        ? ListView.separated(
                      itemCount: _.feedList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildSearchDetails(_.feedList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1,
                          color: dividerColor,
                        );
                      },
                    )
                        : Container(
                      height: Get.height * 0.4,
                      child: Center(
                        child: CustomText(
                          text: "No data found",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
*/



    );
  }

  Widget buildSearchDetails(Feed feedData) {
    return
      InkWell(
      onTap: () {

      },
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          FeedButton(
                            label: "Follow",

                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              _openDialog(context,feedData);
                            },
                            child: Image.asset(
                              Assets.ellipses,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
/*
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
*/
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            MediaSlidableWidget(mediaList: feedData.userMedia),

/*
            Container(

              height: 300,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 4),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0, //
                        color: Colors.white//                 <--- border width here
                    ),
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                        image: NetworkImage(feedData.userMedia[0].mediaUrl),

                        fit: BoxFit.cover

                    )
                ),
               // child: _buildBody()

            ),
*/
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Row(
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
                      //onClickLikeUnLike?.call();
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
                    //  onClickBookmark?.call();
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

                      SizedBox(height: 10,),
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
            )
          ],
        ),
      ),
    );
  }

  void _openDialog(BuildContext context,Feed feedData) {
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



