import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/recipe/add_recipe_request_entity.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeSteps extends StatelessWidget {
  RecipeSteps({this.userRecipePreparationSteps});

  List<UserRecipePreparationStep> userRecipePreparationSteps;

  @override
  Widget build(BuildContext context) {
    return userRecipePreparationSteps.length > 0
        ? ListView.builder(
            itemCount: userRecipePreparationSteps.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext contex, int index) {
              int counter = index + 1;
              return Container(
                padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      color: FF050707,
                      size: 10,
                      maxLines: 20,
                      fontWeight: FontWeight.bold,
                      text: "Step $counter",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      color: FF050707,
                      size: 14,
                      maxLines: 20,
                      fontWeight: FontWeight.normal,
                      text:
                          "${userRecipePreparationSteps[index].description ?? ""}",
                    )
                  ],
                ),
              );
            })
        : Container(
            height: Get.height * 0.3,
            child: Center(
              child: CustomText(
                text: "No Data found",
              ),
            ),
          );
  }
}
