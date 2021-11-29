import 'package:fit_beat/app/data/model/chat/chat_request_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/chat/controllers/connection_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChatRequestController extends GetxController {
  final ApiRepository repository;

  bool isReceivedLoading = false;
  List<ChatRequestData> receivedList = [];
  List<ChatRequestData> sentList = [];

  bool isSentLoading = false;

  ChatRequestController({@required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    getReceivedList();
    getSentList();
  }

  void getReceivedList() async {
    try {
      isReceivedLoading = true;
      update();
      var response = await repository.getChatRequestReceivedList();

      if (response.status) {
        receivedList = response.data;
      }

      isReceivedLoading = false;
      update();
    } catch (e) {
      print("error isReceived ${e.toString()}");
      isReceivedLoading = false;
      update();
    }
  }

  void getSentList() async {
    try {
      isSentLoading = true;
      update();
      var response = await repository.getChatRequestSentList();

      if (response.status) {
        sentList = response.data;
      }

      isSentLoading = false;
      update();
    } catch (e) {
      print("error isReceived ${e.toString()}");
      isSentLoading = false;
      update();
    }
  }

  void onAccept(var id) async {
    var result =
        await Get.find<ConnectionStatusController>().acceptChatInvite(id);
    if (result) {
      getReceivedList();
    }
  }

  void onCancel(var id, var isReceived) async {
    var result =
        await Get.find<ConnectionStatusController>().cancelChatInvite(id);
    if (result) {
      if (isReceived) {
        getReceivedList();
      } else {
        getSentList();
      }
    }
  }
}
