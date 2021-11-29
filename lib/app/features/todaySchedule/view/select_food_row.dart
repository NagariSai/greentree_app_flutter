import 'dart:io';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/api_endpoint.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/food_bottom_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_food_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/servings_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/food_bottom_view.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SelectFoodRow extends StatefulWidget {
  final NutritionData nutrition;
  final int index;
  SelectFoodRow({this.nutrition, this.index});

  @override
  _SelectFoodRowState createState() => _SelectFoodRowState();
}
class Serving {
  String serving_id;
  String serving_description;

  Serving({
    this.serving_id,
    this.serving_description,

  });
  factory Serving.fromJson(Map<String, dynamic> json) => Serving(
    serving_id: json["serving_id"],
    serving_description: json["serving_description"],

  );
  Map<String, dynamic> toJson() => {
    "id": serving_id,
    "name": serving_description,

  };


@override
  String toString() {
    return '{ ${this.serving_id}, ${this.serving_description} }';
  }
}
class _SelectFoodRowState extends State<SelectFoodRow> {
  bool isAddClick = false;
  bool isFromTodaySchdule = false;
  String _chosenValue='';
  List<Serving> jsonResponse;
  var itemList = ['Select Standard',];
  @override
  void initState() {
    super.initState();
    Get.find<SelectFoodController>().input.clear();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectFoodController>(builder: (_) {
      return InkWell(
        onTap: () {
          print("nutritionId:"+widget.nutrition.quantityType.toString());
         _fetchServings1("4881229");
        //  /app/v1/getRecipesDetails/:unique_id
          //sleep(Duration(seconds:15));
        //  openFoodDetailPageDialog(_);
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 86,
                      width: 80,
                      child: CachedNetworkImage(
                        imageUrl:
                            "${widget.nutrition.nutritionMedia[0].mediaUrl}",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Image.asset(
                          Assets.backgroundBanner,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),*/
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "${widget.nutrition.title}",
                            size: 16,
                            color: FF050707,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomText(
                                text:
                                    "${widget.nutrition.quantity} ${Utils().getQuatityType(widget.nutrition.quantityType)} | ",
                                size: 13,
                                color: FF6D7274,
                              ),
                              CustomText(
                                text: "${widget.nutrition.kcal} kcal",
                                size: 13,
                                color: FF55B5FE,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!isAddClick) {
                        openFoodDetailPageDialog(_);
                      } else {
                        bool isRemove = await DialogUtils.customDialog(
                            title: "Remove",
                            description:
                                "Would you like to remove this food item from list?",
                            firstButtonTitle: "Ok",
                            secondButtonTitle: "Cancle");
                        if (isRemove) {
                          setState(() {
                            isAddClick = false;
                            _.onAddRemoveClick(isAddClick,
                                widget.nutrition.nutritionId, widget.index);
                          });
                        }
                      }
                    },
                    child: !isAddClick
                        ? Icon(
                            Icons.add_circle_outline,
                            color: FF6BD295,
                          )
                        : Image.asset(
                            Assets.tick,
                            height: 24,
                            width: 24,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void openFoodDetailPageDialog(_) {
    Get.bottomSheet(GetBuilder<FoodBottomController>(
        init: FoodBottomController(
            repository: ApiRepository(apiClient: ApiClient()),
            nutrition: widget.nutrition,
            index: widget.index),
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
                            text: "${widget.nutrition.title}",
                            size: 16,
                            color: FF050707,
                            maxLines: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //Get.back();
                            //   foodBottomController
                            //    .updateFoodQty(isFromTodaySchdule);
                            Get.back();
                            setState(() {
                              isAddClick = true;
                              Get.find<SelectFoodController>()
                                      .nutritionFoodList[widget.index]
                                      .quantity =
                                  int.parse(
                                      foodBottomController.qtyController.text);
                              Get.find<SelectFoodController>()
                                  .nutritionFoodList[widget.index]
                                  .kcal = foodBottomController.getCalories();
                              if (isAddClick) {
                                _.onAddRemoveClick(isAddClick,
                                    widget.nutrition.nutritionId, widget.index);
                              }
                            });
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
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: _chosenValue,
                          elevation: 5,
                          style: TextStyle(color: Colors.blue),
                         //  items:foodBottomController.fetchServings("4881229")
                           /*  items: jsonResponse.map((Serving map) {
                            return new DropdownMenuItem<String>(
                              value: map.serving_description,
                              child: new Text(map.serving_description,
                                  style: new TextStyle(color: Colors.black)),
                            );
                          }).toList(),*/

                        items: itemList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),


                          onChanged: (String value) {
                            setState(() {
                              _chosenValue = value;
                              print(_chosenValue);
                            });
                          },
                        ),

                      ),
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
                                  hintText: '${widget.nutrition.quantity}'),
                            )
                          : Row(
                              children: [
                                CustomText(
                                  text: "${widget.nutrition.quantity}",
                                  color: FF025074,
                                  size: 16,
                                ),
                                CustomText(
                                  text:
                                      "${Utils().getQuatityType(widget.nutrition.quantityType)}",
                                  color: FF93999B,
                                  size: 13,
                                ),
                              ],
                            )


             ),


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
                                    text: "${foodBottomController.protein} g" ??
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
                                        "${foodBottomController.carbs} g" ?? "",
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
                                    text: "${foodBottomController.fat} g" ?? "",
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
                                       colorList: foodBottomController.colorList,
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
                          text: "${widget.nutrition.description ?? ""}",
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
        }));
  }



  /*Future<List<Serving>> _fetchServings2() async {
    String myurl = "http://fitness-api.nsdcare.com/getServings";

    print(myurl);
    http.post(myurl, headers: {
       "secret" : "c78facccdc8f4aa6bb0ffef7ff0d7d42",
       "token"  : "e7f48371c00549f1ab1248c09071f167"
    }, body: jsonEncode(<String, String>{
    'food_id': "4881229"
    }
    ).then((response) {
      if (response.statusCode == 200) {
        // print(response.body);

        var data=jsonDecode(response.body);
         print(data["code"]);
        print(data["message"]);
        if(data["code"]==200) {
          List jsonResponse = data["serving"] as List;
          // List jsonResponse = json.decode(response.body);
          print(jsonResponse);

          //  return  (data["response"] as List).map((plist) => new Patients.fromJson(plist)).toList();


        //  return jsonResponse.map((job) => new Patients.fromJson(job)).toList();
        }
        else{

        }
      } else {
        throw Exception('Failed to load jobs from API');
      }
    });
  }*/

  Future<List<Serving>> _fetchServings1(String foodid) async {
    final response = await http.post(
      Uri.parse('http://fitness-api.nsdcare.com/getServings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "secret" : "c78facccdc8f4aa6bb0ffef7ff0d7d42",
        "token"  : "e7f48371c00549f1ab1248c09071f167"
      },
      body: jsonEncode(<String, String>{
        'food_id': foodid,
      }),
    );

    if (response.statusCode == 200) {

      print(response.body);
      var data=jsonDecode(response.body);
      var result=data["result"];
      var food=result["food"];

      var serving=food["servings"];

     // String arrayText=serving["serving"].toString();

    //  print(arrayText);
      var tagObjsJson = serving["serving"] as List<dynamic>;


      jsonResponse = tagObjsJson.map((tagJson) => Serving.fromJson(tagJson)).toList();

      itemList.clear();
      for (var i = 0; i < jsonResponse.length; i++) {

        itemList.add(jsonResponse[i].serving_description);
        print(jsonResponse[i].serving_description);
      }
      _chosenValue=itemList[0];

    /*  var tagsJson = jsonDecode(serving["serving"]);
      List<dynamic> tags = tagsJson != null ? List.from(tagsJson) : null;
      for (var i = 0; i < tags.length; i++) {

        print(tags[i]["serving_description"]);
      }*/
      openFoodDetailPageDialog("");

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }


}
