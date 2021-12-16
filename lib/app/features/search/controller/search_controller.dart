import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final ApiRepository repository;

  SearchController({@required this.repository}) : assert(repository != null);

  RxBool isLoading = RxBool(false);
  RxList<Feed> feedList = RxList();
  List<String> _listItem = new List();
  TextEditingController searchController = TextEditingController();

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
      isLoading.value = false;
      if (response.status && response.data != null) {
        feedList.clear();
        feedList.addAll(response.data.feeds);
      }
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

  clearSearch() {
    feedList.clear();
    feedList.refresh();
    searchController.clear();
    showIcon = false;
    update();
  }

  reloadSearch() {
    searchData(searchController.text);
  }
}
