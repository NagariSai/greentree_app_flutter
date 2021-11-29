import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachMyPostController extends GetxController {
  final ApiRepository repository;

  CoachMyPostController({@required this.repository})
      : assert(repository != null);

  List<Feed> feedList;
  int pageLimit = 10;
  bool feedLastPage = false;
  int pageNo = 1;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isRefresh = false;

  @override
  void onInit() {
    super.onInit();
    feedList = [];
    getFeeds();
  }

  void loadNextFeed() {
    pageNo++;
    getFeeds();
  }

  Future<void> getFeeds() async {
    print("============getFeeds==========");
    try {
      if (pageNo == 1 && !isRefresh) {
        _isLoading = true;
        update();
      }

      var response = await repository.getFeeds(pageNo, 0, pageLimit,
          userProfileId: PrefData().getUserData().userId);

      if (response.status) {
        if (response.data != null && response.data.feeds != null) {
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

  void updateHomeList() {
    update();
  }
}
