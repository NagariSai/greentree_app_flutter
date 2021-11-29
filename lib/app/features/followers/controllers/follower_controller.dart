import 'package:fit_beat/app/data/model/user/user_follow.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowerController extends GetxController {
  final ApiRepository repository;

  FollowerController({@required this.repository}) : assert(repository != null);

  var userProfileId;

  @override
  void onInit() {
    super.onInit();
    userProfileId = Get.arguments;
    getFollwerList();
  }

  bool isFollwerLoading = false;
  List<UserFollow> userFollowerList = [];

  void getFollwerList() async {
    try {
      isFollwerLoading = true;
      var response = await repository.getFollowerList(userProfileId);
      isFollwerLoading = false;
      if (response.status) {
        userFollowerList = response.data;
      }
      update();
    } catch (e) {
      print("error getFollwerList ${e.toString()}");
      isFollwerLoading = false;
      update();
    }
  }

  void unFollowUser(var userId) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.followUnFollowUser(
          userProfileId: userId, isFollow: 0);
      Utils.dismissLoadingDialog();
      if (response.status) {
        Utils.showSucessSnackBar("UnFollow user successfully");
        getFollwerList();
      }
    } catch (e) {
      print("un followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }

  void followUser(var userId) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.followUnFollowUser(
          userProfileId: userId, isFollow: 1);
      Utils.dismissLoadingDialog();
      if (response.status) {
        Utils.showSucessSnackBar("Follow user successfully");
        getFollwerList();
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      print("followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }
}
