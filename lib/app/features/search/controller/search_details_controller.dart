import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:meta/meta.dart';





class SearchDetailsController extends GetxController {
  final ApiRepository repository;

  SearchDetailsController({@required this.repository}) : assert(repository != null);

  RxBool isLoading = RxBool(false);
  RxList<Feed> feedList = RxList();

  bool showIcon = false;
  var indicator = new GlobalKey<RefreshIndicatorState>();
  bool isRefresh = false;
  int pageNo = 1;
  @override
  void onInit() {
    super.onInit();
    searchData("rayudu");
  }

  searchData(String query) async {
    try {
      isLoading.value = true;
      var response = await repository.searchData(query: query);

      if (response.status && response.data != null) {
        feedList.clear();
        feedList.addAll(response.data.feeds);
        feedList.removeWhere((item) => item.uniqueId==Utils.selectedfeedData.uniqueId);
        feedList.insert(0,Utils.selectedfeedData);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      feedList.clear();
      print("search error : ${e.toString()}");
    }
  }
  loadNextsearchData(String query) async {
    try {
      pageNo++;
      if (pageNo == 1 && !isRefresh) {
        isLoading.value = true;
        update();
      }


      //isLoading.value = true;
      var response = await repository.searchData(query: query);
      isLoading.value = false;
      if (response.status && response.data != null) {
        // feedList.clear();
        feedList.addAll(response.data.feeds);
      }
    } catch (e) {
      isLoading.value = false;
      feedList.clear();
      print("search error : ${e.toString()}");
    }
  }
  void refreshFeeds() {
    indicator.currentState.show();
    //reloadFeeds();
    loadNextsearchData("test");
  }

  Future<void> reloadFeeds() async {
    isRefresh = true;

    pageNo = 1;
    await loadNextsearchData("test");
    isRefresh = false;
  }

  updateCloseIcon(String query) {
    if (query.length > 0) {
      showIcon = true;
    } else {
      showIcon = false;
    }
    update();
  }


}
