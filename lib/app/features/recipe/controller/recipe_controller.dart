import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  final ApiRepository repository;
  RecipeController({@required this.repository}) : assert(repository != null);

  int pageNo = 1;
  int pageLimit = 10;
  bool isRefresh = false;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Feed> feedList;
  bool feedLastPage = false;
  List<int> foodFilter = [];
  List<int> catFilter = [];

  var masterCategoryEntity;
  var indicator = new GlobalKey<RefreshIndicatorState>();

  bool isSearchActive = false;
  bool showIcon = false;

  List foodDataMap = [
    {"id": 0, "name": "All", "color": primaryColor, "isSelected": true},
    {"id": 1, "name": "Veg", "color": foodVegColor, "isSelected": false},
    {"id": 2, "name": "Nonveg", "color": foodNonVegColor, "isSelected": false},
    {"id": 3, "name": "Eggetarian", "color": foodEggColor, "isSelected": false},
    {"id": 4, "name": "Vegan", "color": foodVeganColor, "isSelected": false},
  ];

  List<CategoryData> category = [];

  bool isFilterClick = false;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    feedList = [];
  }

  void loadRecipe() {
    masterCategoryEntity = Rx(PrefData().getMasterCategories());
    getRecipeFeed();
    getCategory();
  }

  getCategory() {
    category.clear();
    print(masterCategoryEntity.value.data.length);
    for (var data in masterCategoryEntity.value.data) {
      String icon;
      if (data.title.toLowerCase().contains("breakfast")) {
        icon = Assets.breakfastIcon;
      } else if (data.title.toLowerCase().contains("lunch")) {
        icon = Assets.lunchIcon;
      } else if (data.title.toLowerCase().contains("salad")) {
        icon = Assets.saladIcon;
      } else if (data.title.toLowerCase().contains("dinner")) {
        icon = Assets.juiceIcon;
      } else if (data.title.toLowerCase().contains("snac")) {
        icon = Assets.snacksIcon;
      }
      category.add(CategoryData(
          title: data.title,
          icon: icon,
          isSelected: false,
          index: data.masterCategoryTypeId));
    }
  }

  List<int> getFoodType() {
    foodFilter.clear();
    for (int i = 0; i < foodDataMap.length; i++) {
      if (foodDataMap[i]['isSelected']) {
        if (foodDataMap[i]['id'] != 0) {
          foodFilter.add(foodDataMap[i]['id']);
        }
      }
    }
    return foodFilter;
  }

  List<int> getCatagoryFilter() {
    catFilter.clear();
    for (var value in category) {
      if (value.isSelected) {
        catFilter.add(value.index);
      }
    }
    return catFilter;
  }

  selectUnselectFoodType(int index) {
    if (index == 0) {
      foodDataMap.forEach((element) => element["isSelected"] = false);
      foodDataMap[index]["isSelected"] = true;
    } else {
      foodDataMap[0]["isSelected"] = false;
      bool priviousSelection = foodDataMap[index]["isSelected"];
      foodDataMap[index]["isSelected"] = !priviousSelection;
    }
    pageNo = 1;

    isFilterClick = true;
    update();
    getRecipeFeedFilter();
    isFilterClick = false;
  }

  selectUnSelectCategory(int index) {
    pageNo = 1;
    bool priviousSelection = category[index].isSelected;
    category[index].isSelected = !priviousSelection;
    isFilterClick = true;
    update();
    getRecipeFeedFilter();
    isFilterClick = false;
  }

  Future<void> getRecipeFeedFilter() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.getRecipeFeeds(
          pageNo: pageNo,
          pageLimit: pageLimit,
          catFilter: getCatagoryFilter() ?? [],
          foodFilter: getFoodType() ?? []);
      Utils.dismissLoadingDialog();
      if (response.status) {
        feedList.clear();
        if (response.data != null && response.data.feeds != null) {
          feedList.addAll(response.data.feeds);
        }
      }
      update();
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  Future<void> getRecipeFeed() async {
    try {
      if (pageNo == 1 && !isRefresh) {
        _isLoading = true;
        update();
      }
      var response = await repository.getRecipeFeeds(
          pageNo: pageNo,
          pageLimit: pageLimit,
          catFilter: getCatagoryFilter() ?? [],
          foodFilter: getFoodType() ?? []);

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
    } catch (e) {
      _isLoading = false;
      isRefresh = false;
      update();
      print("Error => $e");
    }
  }

  void loadNextRecipeFeed() {
    print("loadNextRecipeFeed");
    if (!isSearchActive) {
      pageNo++;
      getRecipeFeed();
    }
  }

  Future<void> reloadFeeds() async {
    print("reloadFeeds");
    isRefresh = true;
    pageNo = 1;
    await getRecipeFeed();
    isRefresh = false;
  }

  void refreshFeeds() {
    foodDataMap.forEach((element) => element["isSelected"] = false);
    foodDataMap[0]["isSelected"] = true;
    category.forEach((element) => element.isSelected = false);
    indicator.currentState.show();
    reloadFeeds();
  }

  searchRecipes() async {
    try {
      _isLoading = true;

      if (searchController.text.length == 0) {
        isSearchActive = false;
        Utils.dismissKeyboard();
      } else {
        isSearchActive = true;
      }
      update();
      var response =
          await repository.getRecipeFeeds(query: searchController.text);
      if (response.status) {
        if (response.data != null && response.data.feeds != null) {
          feedList.addAll(response.data.feeds);
        }
      }
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      print("${e.toString()}");
    }
  }

  void updateRecipeList() {
    update();
  }

  clearSearch(String query) {
    isSearchActive = false;
    if (query.length == 0) {
      showIcon = false;
      searchController.clear();
      Utils.dismissKeyboard();
      getRecipeFeed();
    } else {
      showIcon = true;
      feedList.clear();
      update();
    }
  }
}

class CategoryData {
  int index;
  String title;
  String icon;
  bool isSelected;

  CategoryData({this.index, this.title, this.icon, this.isSelected});
}
