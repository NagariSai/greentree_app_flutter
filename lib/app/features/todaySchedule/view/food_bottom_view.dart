import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/food_bottom_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_food_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class FoodBottomView extends StatelessWidget {
  bool isFromTodaySchdule;
  NutritionData nutrition;
  int index;
  FoodBottomView({this.nutrition, this.isFromTodaySchdule = false, this.index});
  var _;
  @override
  Widget build(BuildContext context) {
    if (isFromTodaySchdule) {
      _ = Get.find<NutritionController>();
    } else {
      _ = Get.find<SelectFoodController>();
    }
    _.caloriesMap.value = {
      "protein": nutrition.nutritionCalory.protein.toDouble(),
      "carb": nutrition.nutritionCalory.carbs.toDouble(),
      "fat": nutrition.nutritionCalory.fat.toDouble(),
    };

    return GetBuilder<FoodBottomController>(
        init: FoodBottomController(
            repository: ApiRepository(apiClient: ApiClient()),
            nutrition: nutrition,
            index: index),
        builder: (FoodBottomController foodBottomController) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                ),
                color: Colors.white),
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: "${nutrition.title}",
                            size: 16,
                            color: FF050707,
                            maxLines: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //Get.back();
                            foodBottomController
                                .updateFoodQty(isFromTodaySchdule);
                          },
                          child: CustomText(
                            text: "Done",
                            size: 14,
                            color: FF55B5FE,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      text: "Food Quantity",
                      color: FF6D7274,
                      size: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: !isFromTodaySchdule
                          ? TextField(
                              onChanged: (value) {
                                foodBottomController.onFoodQtyChange(value);
                              },
                              controller: foodBottomController.qtyController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '${nutrition.quantity}'),
                            )
                          : Row(
                              children: [
                                CustomText(
                                  text: "${nutrition.quantity}",
                                  color: FF025074,
                                  size: 16,
                                ),
                                CustomText(
                                  text:
                                      " ${Utils().getQuatityType(nutrition.quantityType)}",
                                  color: FF93999B,
                                  size: 13,
                                ),
                              ],
                            )),
                  const SizedBox(height: 8),
                  Divider(),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      text: "Calories Information",
                      color: FF6D7274,
                      size: 12,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                      width: 50, child: Text("Protein")),
                                ),
                                Text(":"),
                                Container(
                                  width: 80,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomText(
                                    color: Colors.lightGreen,
                                    text: "${foodBottomController.protein}g" ??
                                        "",
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                      width: 50, child: Text("Carbs")),
                                ),
                                Text(":"),
                                Container(
                                  width: 80,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomText(
                                    color: Colors.purple,
                                    text:
                                        "${foodBottomController.carbs}g" ?? "",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child:
                                      Container(width: 50, child: Text("Fat")),
                                ),
                                Text(":"),
                                Container(
                                  width: 80,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomText(
                                    color: Colors.orangeAccent,
                                    text: "${foodBottomController.fat}g" ?? "",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.only(top: 16),
                            alignment: Alignment.centerRight,
                            height: 120,
                            child: Stack(
                              children: [
                                Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "${foodBottomController.getCalories() ?? 0}",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ),
                                    Text("Kcal",
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                )),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 10,
                                          value: 1,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey)),
                                      height: 100,
                                      width: 100,
                                    ),
                                    Obx(
                                      () => PieChart(
                                        dataMap: foodBottomController
                                            .caloriesMap.value,
                                        chartLegendSpacing: 0,
                                        chartRadius: 100,
                                        colorList: _.colorList,
                                        initialAngleInDegree: 0,
                                        chartType: ChartType.ring,
                                        ringStrokeWidth: 10,
                                        legendOptions: LegendOptions(
                                          showLegendsInRow: false,
                                          showLegends: false,
                                        ),
                                        chartValuesOptions: ChartValuesOptions(
                                          showChartValueBackground: false,
                                          showChartValues: false,
                                          showChartValuesInPercentage: false,
                                          showChartValuesOutside: false,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      text: "Description",
                      color: FF6D7274,
                      size: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        CustomText(
                          text: "${nutrition.description ?? ""}",
                          color: FF025074,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
