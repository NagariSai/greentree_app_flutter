import 'package:fit_beat/app/data/model/chat/my_chats_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChatRoomsController extends GetxController {
  final ApiRepository repository;

  bool isLoading = false;
  int pageLimit = 10;
  bool feedLastPage = false;
  int pageNo = 1;
  var indicator = new GlobalKey<RefreshIndicatorState>();
  bool isRefresh = false;
  List<MyChat> userList = [];
  ChatRoomsController({@required this.repository}) : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    getUsersList();
  }

  Future<void> getUsersList([String query = ""]) async {
    try {
      if (pageNo == 1 && !isRefresh) {
        userList.clear();
        isLoading = true;
        update();
      }
      var response =
          await repository.getChatRoomsList(pageNo, pageLimit, query);
      if (response.status) {
        if (response.data != null &&
            response.data.myChats != null &&
            response.data.myChats.isNotEmpty) {
          if (pageNo == 1) {
            userList.clear();
          }
          userList.addAll(response.data.myChats);
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
    await getUsersList();
    isRefresh = false;
  }

  void loadNextFeed() {
    pageNo++;
    getUsersList();
  }

  void reloadPage() {
    indicator.currentState.show();
    reloadList();
  }

  void searchChatUsers(String query) async {
    pageNo = 1;
    feedLastPage = false;
    await getUsersList(query);
  }
}
