import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/features/recipe/controller/recipe_details_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class ReceipeCalories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeDetailsController>(builder: (_) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(width: 50, child: Text("Protein")),
                          ),
                          Text(":"),
                          Container(
                            width: 80,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomText(
                              color: Colors.lightGreen,
                              text:
                                  "${_.feedData.userRecipeColories[0].protein}g" ??
                                      "",
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(width: 50, child: Text("Carbs")),
                          ),
                          Text(":"),
                          Container(
                            width: 80,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomText(
                              color: Colors.purple,
                              text:
                                  "${_.feedData.userRecipeColories[0].carbs}g" ??
                                      "",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(width: 50, child: Text("Fat")),
                          ),
                          Text(":"),
                          Container(
                            width: 80,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomText(
                              color: Colors.orangeAccent,
                              text:
                                  "${_.feedData.userRecipeColories[0].fat}g" ??
                                      "",
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
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
                              child: Obx(
                                () => Text("${_.getCalories()}",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                            ),
                            Text("Kcal", style: TextStyle(fontSize: 12)),
                          ],
                        )),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              child: CircularProgressIndicator(
                                  strokeWidth: 10,
                                  value: 1,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey)),
                              height: 100,
                              width: 100,
                            ),
                            Obx(
                              () => PieChart(
                                dataMap: _.caloriesMap.value,
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
              )
            ],
          ),
        ),
      );
    });
  }
}
