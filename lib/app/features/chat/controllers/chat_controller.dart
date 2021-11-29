import 'dart:io';

import 'package:fit_beat/app/data/model/chat/chat_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChatController extends GetxController {
  final ApiRepository repository;

  bool isReceivedLoading = false;
  List<ChatData> chatList = [];

  bool isLoading = false;
  int pageLimit = 10;
  bool feedLastPage = false;
  int pageNo = 1;
  var indicator = new GlobalKey<RefreshIndicatorState>();
  var textController = TextEditingController();
  bool isRefresh = false;

  var toUserId;
  var toUserName;
  var toUserProfileUrl;

  var userChatConnectionId;
  ChatController({@required this.repository}) : assert(repository != null);

  @override
  void onInit() {
    super.onInit();

    toUserId = Get.arguments[0];
    toUserName = Get.arguments[1];
    toUserProfileUrl = Get.arguments[2];
    userChatConnectionId = Get.arguments[3];

    getChatList();
  }

  Future<void> getChatList() async {
    try {
      if (pageNo == 1 && !isRefresh) {
        isLoading = true;
        update();
      }
      var response = await repository.getChatData(pageNo, pageLimit, toUserId);
      if (response.status) {
        if (response.data != null &&
            response.data.chats != null &&
            response.data.chats.isNotEmpty) {
          if (pageNo == 1) {
            chatList.clear();
          }
          chatList.addAll(response.data.chats);
        } else {
          feedLastPage = true;
        }
      }
      if (pageNo == 1 && !isRefresh) {
        isLoading = false;
      }
      update();
      isRefresh = false;
    } catch (e) {
      print("error getFollowingList ${e.toString()}");
      isLoading = false;
      isRefresh = false;
      update();
    }
  }

  Future<void> reloadList() async {
    isRefresh = true;
    pageNo = 1;
    feedLastPage = false;
    await getChatList();
    isRefresh = false;
  }

  void loadNextFeed() {
    pageNo++;
    getChatList();
  }

  void reloadPage() {
    indicator.currentState.show();
    reloadList();
  }

  void sendChat([String mediaUrl]) async {
    var response = await repository.sendChat(
        userChatConnectionId,
        toUserId,
        mediaUrl == null ? 1 : 2,
        mediaUrl == null ? textController.text : mediaUrl);

    if (response.status) {
      textController.text = "";
      update();
      reloadPage();
    } else {
      Utils.showErrorSnackBar("Unable to send message");
    }
  }

  void sendMedia(File file) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.uploadSingleMedia(file, 0);
      Utils.dismissLoadingDialog();

      if (response.status) {
        sendChat(response.url[0].mediaUrl);
      } else {
        Utils.showErrorSnackBar("Unable to send message");
      }
    } catch (_) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar("Unable to send message");
    }
  }

  @override
  void dispose() {
    /*try {
      Get.find<ChatRoomsController>().reloadPage();
    } catch (_) {}*/
    super.dispose();
  }
}
