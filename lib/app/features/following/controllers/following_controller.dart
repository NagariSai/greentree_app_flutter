import 'package:fit_beat/app/data/model/user/user_follow.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingController extends GetxController {
  final ApiRepository repository;

  FollowingController({@required this.repository}) : assert(repository != null);

  var userProfileId;

  @override
  void onInit() {
    super.onInit();
    userProfileId = Get.arguments;
    getFollowingList();
  }

  bool isFollwingLoading = false;
  List<UserFollow> userFollowingList = [];

  void getFollowingList() async {
    try {
      isFollwingLoading = true;
      var response = await repository.getFollowingList(userProfileId);
      isFollwingLoading = false;
      if (response.status) {
        userFollowingList = response.data;
      }
      update();
    } catch (e) {
      print("error getFollowingList ${e.toString()}");
      isFollwingLoading = false;
      update();
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
        getFollowingList();
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      print("followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
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
        getFollowingList();
      }
    } catch (e) {
      print("un followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }
}
