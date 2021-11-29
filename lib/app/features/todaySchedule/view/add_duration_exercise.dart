import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/add_exercise_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddDurationExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddExerciseController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomText(
            text: "Add your sets",
            color: FF6D7274,
            size: 14,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          Container(
            height: 140,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._.setsDurationList.map((textEditController) {
                    var index = _.setsDurationList.indexOf(textEditController);
                    return Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          CustomText(
                            text: "${index + 1}.",
                            color: FF6D7274,
                            size: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: 100,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: FFBCC7CC, // set border color
                                  width: 1.0), // set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10.0)), // set rounded corner radius
                            ),
                            child: TextField(
                              controller: textEditController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: '0',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, bottom: 10)),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              _.removeDuration(textEditController);
                            },
                            child: Icon(
                              Icons.clear,
                              color: FF025074,
                            ),
                          )
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                _.addDuration();
              },
              child: Icon(
                Icons.add_circle_outline,
                color: FF55B5FE,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Rest b/w sets",
                          color: FF6D7274,
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        TextField(
                          controller: _.restSetController,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: 'In Sec',
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, bottom: 10)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Rest b/w exercises",
                          color: FF6D7274,
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        TextField(
                          controller: _.restExerciseController,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: 'In Sec',
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, bottom: 10)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
