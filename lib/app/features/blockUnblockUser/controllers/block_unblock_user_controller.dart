import 'package:fit_beat/app/data/model/user/block_user_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockUnBlockController extends GetxController {
  final ApiRepository repository;

  BlockUnBlockController({@required this.repository})
      : assert(repository != null);

  var userProfileId;

  @override
  void onInit() {
    super.onInit();
    userProfileId = Get.arguments;
    getBlockUserList();
  }

  bool isBlockUserListLoading = false;
  List<BlockUser> userBlockList = [];

  var pageNo = 1;
  var pageRecord = 100;

  void getBlockUserList() async {
    try {
      isBlockUserListLoading = true;
      var response = await repository.getBlockUserList(
          pageRecord: pageRecord, pageNo: pageNo);
      isBlockUserListLoading = false;
      if (response.status) {
        userBlockList = response.data.blockUserList;
      }
      update();
    } catch (e) {
      print("error getBlockUserList ${e.toString()}");
      isBlockUserListLoading = false;
      update();
    }
  }

  void unBlockUser(var userProfileId) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.unBlockUser(userProfileId: userProfileId);
      if (response.status) {
        reloadBlockUserList();
        Utils.dismissLoadingDialog();
        Utils.showSucessSnackBar(response.message);
      } else {
        Utils.dismissLoadingDialog();
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  reloadBlockUserList() async {
    try {
      var response = await repository.getBlockUserList(
          pageRecord: pageRecord, pageNo: pageNo);
      isBlockUserListLoading = false;
      if (response.status) {
        userBlockList = response.data.blockUserList;
        update();
      }
    } catch (e) {}
  }
}
