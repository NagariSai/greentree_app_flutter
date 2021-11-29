import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/ingredients_widget.dart';
import 'package:fit_beat/app/common_widgets/media_url_widget.dart';
import 'package:fit_beat/app/common_widgets/media_widget.dart';
import 'package:fit_beat/app/common_widgets/preparation_steps_widget.dart';
import 'package:fit_beat/app/common_widgets/tag_widget.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/add_post/controllers/add_post_controller.dart';
import 'package:fit_beat/app/features/add_post/controllers/add_recipe_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/interest_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class AddRecipePage extends StatelessWidget {
  var _ = AddPostController(
      repository: ApiRepository(apiClient: ApiClient()), postType: 1);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRecipeController>(
        init: AddRecipeController(
          repository: Get.find<ApiRepository>(),
        ),
        builder: (_) {
          return Obx(
            () => (_.masterCuisineEntity.value != null &&
                    _.masterCategoryEntity.value != null &&
                    _.masterTagEntity.value != null &&
                    _.userDetailData.value != null &&
                    //
                    _.masterCuisineEntity.value.data != null &&
                    _.masterCategoryEntity.value.data != null &&
                    _.masterTagEntity.value.data != null)
                ? Container(
                    color: Colors.white,
                    child: SafeArea(
                      child: Scaffold(
                        appBar: CustomAppBar(
                          negativeText: "Cancel",
                          positiveText: "Add",
                          onNegativeTap: () => Get.back(),
                          onPositiveTap: () {
                            _.recipesData();
                          },
                        ),
                        backgroundColor: Colors.white,
                        body:
                            OrientationBuilder(builder: (context, orientation) {
                          return LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Add a recipe",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: TextInputContainer(
                                          controller: _.titleController,
                                          title: "Title",
                                          maxLength: 40,
                                          maxLines: 2,
                                          inputHint: "Recipe name",
                                          onChange: (value) {
                                            _.title.value = value;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: TextInputContainer(
                                          controller: _.descController,
                                          title: "Description",
                                          inputHint: "More about your recipe",
                                          onChange: (value) {
                                            _.description.value = value;
                                          },
                                          maxLength: 160,
                                          minLines: 4,
                                          maxLines: 5,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: CustomInputContainer(
                                            title: "Cuisine Type",
                                            child: Obx(
                                              () => Wrap(
                                                  children: _
                                                      .masterCuisineEntity
                                                      .value
                                                      .data
                                                      .map((e) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                InterestContainer(
                                                              onTap: () {
                                                                _.selectedCuisineId
                                                                        .value =
                                                                    e.masterCuisineId;
                                                              },
                                                              isSelected: _
                                                                  .isCuisineSelected(
                                                                      e.masterCuisineId),
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          178,
                                                                          200,
                                                                          210,
                                                                          1),
                                                              label: e.title,
                                                            ),
                                                          ))
                                                      .toList()),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: CustomInputContainer(
                                            title: "Food Type",
                                            child: Obx(
                                              () => Wrap(
                                                  children: _.foodDataMap
                                                      .map((k) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                InterestContainer(
                                                              onTap: () {
                                                                _.selectedFoodTypeId
                                                                        .value =
                                                                    k["id"];
                                                              },
                                                              isColored: true,
                                                              isSelected: _
                                                                  .isFoodTypeSelected(
                                                                      k["id"]),
                                                              backgroundColor:
                                                                  k["color"],
                                                              label: k["name"],
                                                            ),
                                                          ))
                                                      .toList()),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: CustomInputContainer(
                                          title: "Category type",
                                          child: Obx(
                                            () => Wrap(
                                                children: _.masterCategoryEntity
                                                    .value.data
                                                    .map((e) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              InterestContainer(
                                                            onTap: () {
                                                              if (_.isCategorySelected(
                                                                  e.masterCategoryTypeId)) {
                                                                _.selectedCategoryId
                                                                    .remove(e
                                                                        .masterCategoryTypeId);
                                                              } else {
                                                                _.selectedCategoryId
                                                                    .add(e
                                                                        .masterCategoryTypeId);
                                                              }
                                                            },
                                                            isSelected: _
                                                                .isCategorySelected(
                                                                    e.masterCategoryTypeId),
                                                            backgroundColor:
                                                                Color.fromRGBO(
                                                                    178,
                                                                    200,
                                                                    210,
                                                                    1),
                                                            label: e.title,
                                                          ),
                                                        ))
                                                    .toList()),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: TextInputContainer(
                                          // maxLength: 4,
                                          controller: _.durationController,
                                          title: "Cooking Duration",
                                          inputHint: "In minutes",
                                          textInputType: TextInputType.number,
                                          onChange: (value) {
                                            _.cookingDuration.value = value;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: TextInputContainer(
                                          controller: _.servingController,
                                          title: "Serving",
                                          textInputType: TextInputType.number,
                                          inputHint: "Serves how many people?",
                                          onChange: (value) {
                                            _.serving.value = value;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: CustomInputContainer(
                                          title: "Calories",
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Container(
                                              height: 170,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                child: Text(
                                                                    "Protein"),
                                                              ),
                                                              Text(":"),
                                                              Container(
                                                                width: 80,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  controller: _
                                                                      .proteinController,
                                                                  onChanged:
                                                                      (value) {
                                                                    _.setProtein(
                                                                        value);
                                                                  },
                                                                  maxLength: 5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .lightGreen),
                                                                  decoration: new InputDecoration(
                                                                      suffixText:
                                                                          "g",
                                                                      border: InputBorder
                                                                          .none,
                                                                      counterText:
                                                                          "",
                                                                      hintText:
                                                                          "0",
                                                                      hintStyle: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14)),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                child: Text(
                                                                    "Carbs"),
                                                              ),
                                                              Text(":"),
                                                              Container(
                                                                width: 80,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  controller: _
                                                                      .carbsController,
                                                                  onChanged:
                                                                      (value) {
                                                                    _.setCarb(
                                                                        value);
                                                                  },
                                                                  maxLength: 5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .purple),
                                                                  decoration: new InputDecoration(
                                                                      suffixText:
                                                                          "g",
                                                                      border: InputBorder
                                                                          .none,
                                                                      counterText:
                                                                          "",
                                                                      hintText:
                                                                          "0",
                                                                      hintStyle: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14)),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                child:
                                                                    Text("Fat"),
                                                              ),
                                                              Text(":"),
                                                              Container(
                                                                width: 80,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  controller: _
                                                                      .fatController,
                                                                  onChanged:
                                                                      (value) {
                                                                    _.setFat(
                                                                        value);
                                                                  },
                                                                  maxLength: 5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepOrangeAccent),
                                                                  decoration: new InputDecoration(
                                                                      suffixText:
                                                                          "g",
                                                                      border: InputBorder
                                                                          .none,
                                                                      counterText:
                                                                          "",
                                                                      hintText:
                                                                          "0",
                                                                      hintStyle: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14)),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        height: 120,
                                                        child: Stack(
                                                          children: [
                                                            Center(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Obx(
                                                                    () => Text(
                                                                        "${_.getCalories()}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                primaryColor,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 16)),
                                                                  ),
                                                                ),
                                                                Text("Kcal",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12)),
                                                              ],
                                                            )),
                                                            Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  child: CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          10,
                                                                      value: 1,
                                                                      valueColor: AlwaysStoppedAnimation<
                                                                              Color>(
                                                                          Colors
                                                                              .grey)),
                                                                  height: 100,
                                                                  width: 100,
                                                                ),
                                                                Obx(
                                                                  () =>
                                                                      PieChart(
                                                                    dataMap: _
                                                                        .caloriesMap
                                                                        .value,
                                                                    chartLegendSpacing:
                                                                        0,
                                                                    chartRadius:
                                                                        100,
                                                                    colorList: _
                                                                        .colorList,
                                                                    initialAngleInDegree:
                                                                        0,
                                                                    chartType:
                                                                        ChartType
                                                                            .ring,
                                                                    ringStrokeWidth:
                                                                        10,
                                                                    legendOptions:
                                                                        LegendOptions(
                                                                      showLegendsInRow:
                                                                          false,
                                                                      showLegends:
                                                                          false,
                                                                    ),
                                                                    chartValuesOptions:
                                                                        ChartValuesOptions(
                                                                      showChartValueBackground:
                                                                          false,
                                                                      showChartValues:
                                                                          false,
                                                                      showChartValuesInPercentage:
                                                                          false,
                                                                      showChartValuesOutside:
                                                                          false,
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
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: IngredientsWidget(
                                            ingredients: _.recipeIngredients,
                                            onChanged: (value) {
                                              _.recipeIngredients = value;
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: PreparationStepsWidget(
                                            selectedSteps: _.recipeSteps,
                                            onChanged: (value) {
                                              _.recipeSteps = value;
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: CustomInputContainer(
                                          title: "Add photo or video",
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Container(
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  if (_.mediaUrlList
                                                      .isNotEmpty) ...[
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: ListView.separated(
                                                        itemBuilder: (context,
                                                            position) {
                                                          return MediaUrlWidget(
                                                            mediaUrl: _
                                                                .mediaUrlList[
                                                                    position]
                                                                .mediaUrl,
                                                            mediaType: _
                                                                .mediaUrlList[
                                                                    position]
                                                                .mediaType,
                                                            onRemove: () => _
                                                                .removeUrlMedia(
                                                                    position),
                                                          );
                                                        },
                                                        itemCount: _
                                                            .mediaUrlList
                                                            .length,
                                                        shrinkWrap: true,
                                                        separatorBuilder:
                                                            (context,
                                                                position) {
                                                          return SizedBox(
                                                            width: 8,
                                                          );
                                                        },
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                      ),
                                                    ),
                                                  ],
                                                  if (_.mediaPathList
                                                      .isNotEmpty) ...[
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: ListView.separated(
                                                        itemBuilder: (context,
                                                            position) {
                                                          return MediaWidget(
                                                            mediaFile:
                                                                _.mediaPathList[
                                                                    position],
                                                            onRemove: () =>
                                                                _.removeMedia(
                                                                    position),
                                                          );
                                                        },
                                                        itemCount: _
                                                            .mediaPathList
                                                            .length,
                                                        shrinkWrap: true,
                                                        separatorBuilder:
                                                            (context,
                                                                position) {
                                                          return SizedBox(
                                                            width: 8,
                                                          );
                                                        },
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                      ),
                                                    ),
                                                  ],
                                                  _.mediaPathList.length +
                                                              _.mediaUrlList
                                                                  .length <
                                                          5
                                                      ? SizedBox(
                                                          width: 8,
                                                        )
                                                      : SizedBox(),
                                                  _.mediaPathList.length +
                                                              _.mediaUrlList
                                                                  .length <
                                                          5
                                                      ? MediaWidget(
                                                          onTap: () =>
                                                              _.addMedia(
                                                                  context),
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: TagWidget(
                                          selectedString: _.selectedStringTags,
                                          suggestedTags: _
                                              .masterTagEntity.value.data
                                              .map((e) => e.title)
                                              .toList(),
                                          onTagsChanged: (value) {
                                            _.selectedStringTags = value;
                                            print(
                                                "selectedStringTags => ${_.selectedStringTags}");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        }),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator())),
          );
        });
  }
}

class TextInputContainer extends StatelessWidget {
  String title;
  String inputHint;
  int maxLines;
  int minLines;
  int maxLength;
  double height;
  TextEditingController controller;
  Function(String value) onChange;
  TextInputType textInputType;

  TextInputContainer(
      {@required this.title,
      @required this.inputHint,
      @required this.onChange,
      this.maxLines = 1,
      this.minLines = 1,
      this.maxLength,
      this.controller,
      this.height,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: 0.4, color: containerBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(8) //
              )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title.isEmpty
                ? SizedBox()
                : Text(
                    this.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
            Padding(
              padding: EdgeInsets.only(top: title.isEmpty ? 0 : 10),
              child: TextField(
                maxLength: this.maxLength,
                minLines: this.minLines,
                maxLines: this.maxLines,
                maxLengthEnforced: true,
                decoration: new InputDecoration.collapsed(
                    hintText: this.inputHint,
                    hintStyle: TextStyle(color: inputHintColor, fontSize: 14)),
                onChanged: this.onChange,
                controller: this.controller != null ? this.controller : null,
                keyboardType: this.textInputType,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomInputContainer extends StatelessWidget {
  String title;
  Widget child;
  double titleSize;
  var fontWeight;

  CustomInputContainer(
      {@required this.title,
      @required this.child,
      this.titleSize = 16,
      fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: 0.4, color: containerBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(8) //
              )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              color: titleBlackColor,
              size: titleSize,
              fontWeight: fontWeight,
            ),
            child
          ],
        ),
      ),
    );
  }
}
