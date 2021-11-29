import 'package:fit_beat/app/data/model/coach_list_model.dart';
import 'package:fit_beat/app/data/model/feed/feed_filter_type.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  final ApiRepository repository;

  HomeController({@required this.repository}) : assert(repository != null);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Feed> feedList;
  List<FeedFilterType> filterList = List();
  int pageLimit = 10;
  bool feedLastPage = false;
  int pageNo = 1;
  FeedFilterType selectedFilterType;
  var indicator = new GlobalKey<RefreshIndicatorState>();
  bool isRefresh = false;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    feedList = List();
    filterList.add(FeedFilterType(isSelected: true, title: "All", type: 0));
    filterList
        .add(FeedFilterType(isSelected: false, title: "Challenges", type: 2));
    filterList.add(
        FeedFilterType(isSelected: false, title: "Transformations", type: 3));
    filterList.add(FeedFilterType(isSelected: false, title: "Recipe", type: 4));
    filterList
        .add(FeedFilterType(isSelected: false, title: "Discussions", type: 1));
    filterList
        .add(FeedFilterType(isSelected: false, title: "Updates", type: 5));
    selectedFilterType = filterList[0];
    getCoachList();
    getFeeds();
  }

  Future<void> getFeeds() async {
    try {
      if (pageNo == 1 && !isRefresh) {
        _isLoading = true;
        update();
      }

      var response =
          await repository.getFeeds(pageNo, selectedFilterType.type, pageLimit);

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

  List<Coach> coachList = [];
  void getCoachList() async {
    try {
      // _isLoading = true;
      update();
      var response = await repository.getCoachList(
        gender: "",
        pageNo: 1,
        pageRecord: 10,
        fitnessCategoryId: -1,
        userLanguages: [],
      );
      //_isLoading = false;
      if (response.status) {
        coachList.clear();
        coachList.addAll(response.data.rows);
      } else {
        coachList = [];
      }
      update();
    } catch (e) {
      print("error : ${e.toString()}");
      coachList = [];
      //_isLoading = false;
      update();
    }
  }

  void getFilteredFeed(int index) async {
    try {
      filterList.forEach((element) {
        element.isSelected = false;
      });
      selectedFilterType = filterList[index];
      selectedFilterType.isSelected = true;
      update();

      Utils.showLoadingDialog();

      var response =
          await repository.getFeeds(1, selectedFilterType.type, pageLimit);

      if (response.status) {
        feedList.clear();

        if (response.data != null && response.data.feeds != null) {
          feedList.addAll(response.data.feeds);
        }
      }
      Utils.dismissLoadingDialog();
      update();
    } on Exception catch (e) {
      Utils.dismissLoadingDialog();
      print("Error => $e");
    }
  }

  Future<void> reloadFeeds() async {
    isRefresh = true;
    filterList.forEach((element) {
      element.isSelected = false;
    });
    selectedFilterType = filterList[0];
    selectedFilterType.isSelected = true;
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
