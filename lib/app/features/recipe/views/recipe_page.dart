import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/features/recipe/controller/recipe_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      body: GetBuilder<RecipeController>(
          init: RecipeController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _buildBody();
          }),
    );
  }

  Widget _buildBody() {
    return GetBuilder<RecipeController>(builder: (_) {
      return LazyLoadScrollView(
        onEndOfPage: () =>
            _.searchController.text.length < 4 ? null : _.loadNextRecipeFeed(),
        isLoading: _.feedLastPage,
        child: RefreshIndicator(
          key: _.indicator,
          onRefresh: _.reloadFeeds,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: NormalTextField(
                      bgColor: settingBgColor,
                      showPrefixIcon: true,
                      hintColor: descriptionColor,
                      hintText: "Search recipes",
                      showIcon: _.showIcon,
                      endIcon: Icons.close,
                      controller: _.searchController,
                      onIconTap: () {
                        print("Icon tap");
                        _.clearSearch("");
                      },
                      onChanged: (String text) {
                        if (text.length > 2) {
                          _.searchRecipes();
                        } else {
                          _.clearSearch(text);
                        }
                      },
                    )),
                Divider(
                  color: otherDividerColor,
                ),
                _.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _.isSearchActive
                              ? Container()
                              : Container(
                                  height: 50,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _.foodDataMap.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        int id = _.foodDataMap[index]['id'];
                                        String name =
                                            _.foodDataMap[index]['name'];
                                        Color color =
                                            _.foodDataMap[index]['color'];
                                        bool isSelected =
                                            _.foodDataMap[index]['isSelected'];
                                        return InkWell(
                                          onTap: () {
                                            _.selectUnselectFoodType(index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 8),
                                            child: Chip(
                                              label: Text(name),
                                              shape: StadiumBorder(
                                                  side:
                                                      BorderSide(color: color)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              labelStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : color),
                                              backgroundColor: isSelected
                                                  ? color
                                                  : Colors.white,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                          _.isSearchActive
                              ? Container()
                              : Divider(
                                  thickness: 4,
                                  color: dividerColor,
                                ),
                          _.isSearchActive
                              ? Container()
                              : SizedBox(
                                  height: 10,
                                ),
                          _.isSearchActive
                              ? Container()
                              : _buildRecipeCategories(),
                          Flexible(
                            fit: FlexFit.loose,
                            child: _.feedList.length > 0
                                ? ListView.separated(
                                    itemCount: _.feedList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      Feed feedData = _.feedList[index];
                                      return FeedWidget(
                                        feedData: feedData,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        thickness: 4,
                                        color: dividerColor,
                                      );
                                    },
                                  )
                                : Container(
                                    height: Get.height * 0.4,
                                    child: Center(
                                      child: CustomText(
                                        text: "No data found",
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildRecipeCategories() {
    return GetBuilder<RecipeController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              text: "Top Categories",
              size: 18,
              fontWeight: FontWeight.w600,
              color: titleBlackColor,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 90,
            child: ListView.builder(
              itemCount: _.category.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                CategoryData categoryData = _.category[index];
                print("cat len ${_.category.length}");
                return InkWell(
                  onTap: () {
                    _.selectUnSelectCategory(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 76,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: categoryData.isSelected
                            ? Colors.white
                            : recipeCatColor,
                        border: Border.all(color: recipeCatColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          categoryData.icon ?? "",
                          width: 40,
                          height: 30,
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        CustomText(
                          text: categoryData.title,
                          size: 12,
                          fontWeight: FontWeight.w600,
                          color: titleBlackColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 4,
            color: dividerColor,
          ),
        ],
      );
    });
  }
}
