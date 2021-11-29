import 'package:fit_beat/app/data/model/comment_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/common_controller.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeDetailsController extends GetxController {
  final ApiRepository repository;

  RecipeDetailsController({@required this.repository})
      : assert(repository != null);

  var feedId;
  bool isLoading = false;
  Feed feedData;

  List<Comment> commentList = [];

  TextEditingController commentController = TextEditingController();
  TextEditingController replyCommentController = TextEditingController();

  bool isCommentLoading = false;
  bool isReplyClick = false;
  String replayUser = "";
  int commentId;
  int commentType;

  int pageLimit = 20;
  int pageNo = 1;
  var type;

  List<Color> colorList = [
    Colors.lightGreen,
    Colors.purple,
    Colors.deepOrangeAccent,
  ];

  Rx<Map<String, double>> caloriesMap = Rx({
    "protein": 0,
    "carb": 0,
    "fat": 0,
  });

  void setProtein(String value) {
    var data = caloriesMap.value;
    data["protein"] = double.parse(value);
    caloriesMap.value = data;
    update();
  }

  void setCarb(String value) {
    var data = caloriesMap.value;
    data["carb"] = double.parse(value);
    caloriesMap.value = data;
    update();
  }

  void setFat(String value) {
    var data = caloriesMap.value;
    data["fat"] = double.parse(value);
    caloriesMap.value = data;
    update();
  }

  double getCalories() {
    /*
    1 gram of carbohydrates = 4 kilocalories.
    1 gram of protein = 4 kilocalories.
    1 gram of fat = 9 kilocalories.
    In addition to carbohydrates, protein and fat, alcohol can also provide energy (1 gram alcohol = 7 kilocalories)
    */

    final protein = caloriesMap.value["protein"];
    final carb = caloriesMap.value["carb"];
    final fat = caloriesMap.value["fat"];

    final kcal = (protein * 4) + (carb * 4) + (fat * 9);
    return kcal;
  }

  @override
  void onInit() {
    super.onInit();
    feedId = Get.arguments[0];
    type = Get.arguments[1];
    getRecipeDetails();
    getCommentList();
  }

  initCaloriesData() {
    setProtein(feedData.userRecipeColories[0].protein.toString() ?? "");
    setCarb(feedData.userRecipeColories[0].carbs.toString() ?? "");
    setFat(feedData.userRecipeColories[0].fat.toString() ?? "");
    caloriesMap.refresh();
  }

  getRecipeDetails() async {
    try {
      isLoading = true;
      update();
      var response = await repository.getRecipeDetails(id: feedId);
      if (response.status && response.feedData != null) {
        feedData = response.feedData;
        initCaloriesData();
      }
      isLoading = false;
      update();
    } catch (e) {
      print("error : ${e.toString()}");
      isLoading = false;
      update();
    }
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
            uniqueId: feedId,
            type: type,
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
