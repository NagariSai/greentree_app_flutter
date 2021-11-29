import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class IngredientsController extends GetxController {
  List<String> ingredients = [];

  IngredientsController({this.ingredients});

  void addIngredient(String ingredient) {
    if (ingredient.isNotEmpty) {
      ingredients.add(ingredient);
      update();
    }
  }

  void removeIngredient(String ingredient) {
    if (ingredient.isNotEmpty) {
      ingredients.remove(ingredient);
      update();
    }
  }
}

class IngredientsWidget extends StatelessWidget {
  final Function(dynamic) onChanged;
  List<String> ingredients;

  IngredientsWidget({this.onChanged, this.ingredients});

  var ingredientInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(IngredientsController(
        ingredients: ingredients != null ? ingredients : []));

    return GetBuilder<IngredientsController>(builder: (controller) {
      return CustomInputContainer(
        title: "Ingredients",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${position + 1}. ${controller.ingredients[position]}",
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 20,
                            ),
                            onPressed: () {
                              controller.removeIngredient(
                                  controller.ingredients[position]);
                            })
                      ],
                    ),
                  );
                },
                itemCount: controller.ingredients.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 0.8, color: containerBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(8) //
                      )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              controller.addIngredient(
                                  ingredientInputController.text);
                              ingredientInputController.clear();
                              onChanged(controller.ingredients);
                            }),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: ingredientInputController,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) {
                              controller.addIngredient(
                                  ingredientInputController.text);
                              ingredientInputController.clear();
                              onChanged(controller.ingredients);
                            },
                            decoration: new InputDecoration.collapsed(
                                hintText: "Add Ingredient",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
