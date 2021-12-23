import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_food_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/select_food_row.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SelectFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectFoodController>(
        init: SelectFoodController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Select Food",
              positiveText: "Add",
              onPositiveTap: () {
                if (_.input.isNotEmpty) {
                  _.addNutritionInScheduleActivity();
                } else {
                  Utils.showErrorSnackBar("Select atleast one nutrition food");
                }
              },
              onNegativeTap: () {
                Get.find<SelectFoodController>().input.clear();
                Get.back();
              },
              negativeText: "Cancel",
            ),
            body: _.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        child: NormalTextField(
                          controller: _.searchController,
                          bgColor: settingBgColor,
                          showPrefixIcon: true,
                          hintColor: descriptionColor,
                          hintText: "Search food…",
                          endIcon: Icons.close,
                          showIcon: _.searchController.text.length > 0,
                          onIconTap: () {
                            _.onClearSearch();
                          },
                          onChanged: (String text) {
                            _.onSearchChange();
                          },
                        ),
                      ),
                      Divider(),
                      /* Container(
                        height: 50,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: _.foodDataMap.length,
                            itemBuilder: (BuildContext context, int index) {
                              int id = _.foodDataMap[index]['id'];
                              String name = _.foodDataMap[index]['name'];
                              Color color = _.foodDataMap[index]['color'];
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
                                        side: BorderSide(color: color)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: id == _.selectedFoodType['id']
                                            ? Colors.white
                                            : color),
                                    backgroundColor:
                                        id == _.selectedFoodType['id']
                                            ? color
                                            : Colors.white,
                                  ),
                                ),
                              );
                            }),
                      ),
                      Divider(
                        thickness: 4,
                        color: dividerColor,
                      ),*/
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.addFoodNutritionPage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              CustomText(
                                text: "${_.addedCount}",
                                color: FF55B5FE,
                                size: 16,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: FF55B5FE,
                                    size: 16,
                                  ),
                                  CustomText(
                                    text: "Add Your food",
                                    color: FF55B5FE,
                                    size: 16,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _.isSearching
                          ? Center(child: CircularProgressIndicator())
                          : _.nutritionFoodList.length > 0
                              ? Flexible(
                                  fit: FlexFit.loose,
                                  child: LazyLoadScrollView(
                                    onEndOfPage: () => _.loadNextFeed(),
                                    isLoading: _.feedLastPage,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: _.nutritionFoodList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          NutritionData nutrition =
                                              _.nutritionFoodList[index];

                                          return SelectFoodRow(
                                            nutrition: nutrition,
                                            index: index,
                                          );
                                        }),
                                  ),
                                )
                              : Center(child: CustomText(text: "No Data found"))
                    ],
                  ),
          );
        });
  }
}
