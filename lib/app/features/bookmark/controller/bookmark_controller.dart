import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMarkController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserBookMarkList();
  }

  final ApiRepository repository;

  BookMarkController({@required this.repository}) : assert(repository != null);

  RxBool isLoading = RxBool(false);
  RxList<Feed> feedList = RxList();

  var pageNo = 1;
  var pageRecord = 100;
  RxInt bookMarkCounter = RxInt(0);

  getUserBookMarkList() async {
    try {
      isLoading.value = true;
      var response = await repository.getBookMarkList(
          pageNo: pageNo, pageRecord: pageRecord);
      isLoading.value = false;
      if (response.status && response.data != null) {
        feedList.clear();
        bookMarkCounter.value = response.data.count;
        feedList.addAll(response.data.feeds);
      }
    } catch (e) {
      isLoading.value = false;
      feedList.clear();
      print("search error : ${e.toString()}");
    }
  }

  reloadUserBookmarkList() async {
    try {
      var response = await repository.getBookMarkList(
          pageNo: pageNo, pageRecord: pageRecord);
      if (response.status && response.data != null) {
        feedList.clear();
        bookMarkCounter.value = response.data.count;
        feedList.addAll(response.data.feeds);
        bookMarkCounter.refresh();
        feedList.refresh();
      }
    } catch (e) {
      print("error");
    }
  }
}
