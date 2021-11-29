import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PreparationStepsController extends GetxController {
  List<String> steps;

  PreparationStepsController(this.steps);

  void addStep(String step) {
    if (step.isNotEmpty) {
      steps.add(step);
      update();
    }
  }

  void removeStep(String step) {
    if (step.isNotEmpty) {
      steps.remove(step);
      update();
    }
  }
}

class PreparationStepsWidget extends StatelessWidget {
  final Function(dynamic) onChanged;
  List<String> selectedSteps;

  PreparationStepsWidget({this.onChanged, this.selectedSteps}) {}

  var stepInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(
        PreparationStepsController(selectedSteps != null ? selectedSteps : []));

    return GetBuilder<PreparationStepsController>(builder: (controller) {
      return CustomInputContainer(
        title: "Preparation Steps",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Step ${position + 1}",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text("${controller.steps[position]}",
                                    style: TextStyle(fontSize: 14)),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 20,
                            ),
                            onPressed: () {
                              controller.removeStep(controller.steps[position]);
                            })
                      ],
                    ),
                  );
                },
                itemCount: controller.steps.length,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Text("Step ${controller.steps.length + 1}",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
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
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              controller.addStep(stepInputController.text);
                              stepInputController.clear();
                              onChanged(controller.steps);
                            }),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: stepInputController,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) {
                              controller.addStep(stepInputController.text);
                              stepInputController.clear();
                              onChanged(controller.steps);
                            },
                            decoration: new InputDecoration.collapsed(
                                hintText: "Add Step",
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
