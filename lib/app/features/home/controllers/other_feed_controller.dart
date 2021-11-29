import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class OtherFeedController extends GetxController {
  final ApiRepository repository;
  final int uniqueId;
  final String isChallenge;

  OtherFeedController(
      {@required this.repository,
      @required this.uniqueId,
      @required this.isChallenge})
      : assert(repository != null);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Feed> feedList;
  int pageLimit = 10;
  bool feedLastPage = false;
  int pageNo = 1;
  var indicator = new GlobalKey<RefreshIndicatorState>();
  bool isRefresh = false;
  var count = 0;
  @override
  void onInit() {
    super.onInit();
    feedList = List();
    getFeeds();
  }

  Future<void> getFeeds() async {
    try {
      if (pageNo == 1 && !isRefresh) {
        _isLoading = true;
        update();
      }

      var response = await repository.getOtherFeeds(
          pageNo, pageLimit, uniqueId, isChallenge == "true" ? 2 : 1);

      if (response.status) {
        if (response.data != null && response.data.feeds != null) {
          count = response.data.count;
          print("data");
          if (pageNo == 1) {
            feedList.clear();
          }
          feedList.addAll(response.data.feeds);
        } else {
          feedLastPage = true;
        }
      }
      if (pageNo == 1 && !isRefresh) {
        _isLoading = false;
      }
      update();
      isRefresh = false;
    } on Exception catch (e) {
      _isLoading = false;
      isRefresh = false;
      update();
      print("Error => $e");
    }
  }

  Future<void> reloadFeeds() async {
    isRefresh = true;
    pageNo = 1;
    await getFeeds();
    isRefresh = false;
  }

  void loadNextFeed() {
    pageNo++;
    getFeeds();
  }

  void refreshFeeds() {
    indicator.currentState.show();
    reloadFeeds();
  }

  void updateHomeList() {
    update();
  }
}
