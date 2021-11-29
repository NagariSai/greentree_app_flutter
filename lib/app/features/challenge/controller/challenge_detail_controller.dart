import 'package:fit_beat/app/data/model/comment_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/common_controller.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeDetailController extends GetxController {
  final ApiRepository repository;

  ChallengeDetailController({@required this.repository})
      : assert(repository != null);

  Feed feedData;
  bool isLoading = false;
  var feedId;
  var type;

  List<Comment> commentList = [];

  TextEditingController commentController = TextEditingController();
  TextEditingController replyCommentController = TextEditingController();

  bool isCommentLoading = false;

  int pageLimit = 20;
  int pageNo = 1;

  bool isReplyClick = false;
  String replayUser = "";
  int commentId;
  int commentType;
  var title;
  var triedCount;
  @override
  void onInit() async {
    super.onInit();
    feedId = Get.arguments[0];
    type = Get.arguments[1];
    // title = Get.arguments[2];
    // triedCount = Get.arguments[3];
    await getDetailPageInfo();
    getCommentList();
  }

  /// get comment list update section
  Future<void> getCommentList() async {
    try {
      isCommentLoading = true;
      var response = await repository.getCommentList(
          uniqueId: feedId, type: type, pageLimit: pageLimit, pageNo: pageNo);

      isCommentLoading = false;

      if (response.status) {
        commentList.addAll([]);
        commentList.addAll(response.data.rows);
      } else {
        commentList = [];
      }
      update();
    } catch (e) {
      commentList = [];
      isCommentLoading = false;
      update();
    }
  }

  /// get detail update section
  getDetailPageInfo() async {
    try {
      isLoading = true;
      update();
      var response =
          await repository.getDetailsInfo(uniqueId: feedId, type: type);

      isLoading = false;
      if (response.status && response.feedData != null) {
        feedData = response.feedData;

        print("totalComments === ${feedData.totalComments}");
      }
      update();
    } catch (e) {
      print("error : ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  /// like update section
  like() {
    feedData.isMyLike = 1;
    feedData.totalLikes = feedData.totalLikes + 1;
    update();
    Get.find<CommonController>()
        .likePost(uniqueId: feedData.uniqueId, type: feedData.type);
    update();
  }

  /// dislike update section
  disLike() {
    //unlike
    feedData.isMyLike = 0;
    feedData.totalLikes = feedData.totalLikes - 1;
    update();
    Get.find<CommonController>()
        .likePost(uniqueId: feedData.uniqueId, type: feedData.type);
    update();
  }

  /// unbookmark update section
  unBookmark() async {
    feedData.isMyBookmark = 0;
    update();
    await Get.find<CommonController>()
        .bookmarkPost(uniqueId: feedData.uniqueId, type: feedData.type);
    update();
  }

  /// book mark update section
  bookMark() {
    feedData.isMyBookmark = 1;
    update();
    Get.find<CommonController>()
        .bookmarkPost(uniqueId: feedData.uniqueId, type: feedData.type);
    update();
  }

  /// reload comment section without loader
  reloadCommentList() async {
    try {
      var response = await repository.getCommentList(
          uniqueId: feedId, type: type, pageLimit: pageLimit, pageNo: pageNo);
      if (response.status) {
        commentList.clear();
        commentList.addAll(response.data.rows);
      } else {
        commentList = [];
      }
      update();
    } catch (e) {}
  }

  /// add comment in update section
  addComment() async {
    try {
      if (commentController.text.isEmpty) {
        Utils.showErrorSnackBar("Please enter comment");
      } else {
        Utils.showLoadingDialog();
        var response = await repository.addComment(
            uniqueId: feedData.uniqueId,
            type: feedData.type,
            description: commentController.text.toString());
        Utils.dismissLoadingDialog();
        if (response.status) {
          commentController.clear();
          reloadCommentList();
          feedData.totalComments = feedData.totalComments + 1;
          Get.find<CommonController>().updateData();
          update();
        }
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  /// like comment update section
  likeComment(var uniqueId, int index) async {
    commentList[index].isMyLike = 1;
    commentList[index].totalLikes = commentList[index].totalLikes + 1;
    update();
    var response = await repository.likeComment(userCommentId: uniqueId);
    if (response.status) {
      reloadCommentList();
    }
    update();
  }

  /// dislike comment update section
  disLikeComment(var uniqueId, int index) async {
    //unlike
    commentList[index].isMyLike = 0;
    commentList[index].totalLikes = commentList[index].totalLikes - 1;
    update();
    var response = await repository.likeComment(userCommentId: uniqueId);
    if (response.status) {
      reloadCommentList();
    }
    update();
  }

  int index;

  onCommentReply(String replayUser, int commentId, int type, int index) {
    isReplyClick = true;
    this.replayUser = replayUser;
    this.commentId = commentId;
    this.commentType = type;
    this.index = index;
    update();
  }

  clearReplay() {
    isReplyClick = false;
    this.replayUser = "";
    this.commentId = null;
    this.commentType = null;
    this.index = null;
    update();
  }

  /// reply comment in update section
  addRelyComment() async {
    try {
      if (replyCommentController.text.isEmpty) {
        Utils.showErrorSnackBar("Please enter comment");
      } else {
        Utils.showLoadingDialog();
        var response = await repository.addComment(
            uniqueId: feedData.uniqueId,
            type: commentType,
            parentUserCommentId: commentId,
            description: replyCommentController.text.toString());
        Utils.dismissLoadingDialog();
        if (response.status) {
          //clearReplay();
          replyCommentController.clear();
          reloadCommentList();
          commentList[index].totalSubComment =
              commentList[index].totalSubComment + 1;
          Get.find<CommonController>().updateData();
          clearReplay();
        } else {
          Utils.showErrorSnackBar(response.message);
        }
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }
}
