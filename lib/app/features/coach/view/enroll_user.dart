import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/category_plan_model.dart';
import 'package:fit_beat/app/features/coach/controller/coach_enroll_request_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class EnrollUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Select Plan",
      ),
      body: GetBuilder<CoachEnrollRequestController>(builder: (_) {
        return _.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _.categoryPlan.length,
                          itemBuilder: (BuildContext context, int index) {
                            CategoryPlan categoryPlan = _.categoryPlan[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${categoryPlan.title ?? ""}",
                                  size: 15,
                                  color: FF050707,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 8),
                                ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: categoryPlan
                                        .fitnessCategoryPlans.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      FitnessCategoryPlan plan = categoryPlan
                                          .fitnessCategoryPlans[index];
                                      return InkWell(
                                        onTap: () {
                                          Get.offNamed(
                                              Routes.userEnrollProccedPage,
                                              arguments: [
                                                plan,
                                                categoryPlan.title
                                              ]);
                                        },
                                        child: Container(
                                            height: 44,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: FFE0EAEE),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomText(
                                                      text:
                                                          "${plan.title ?? ""}",
                                                      size: 15,
                                                      color: FF6D7274,
                                                    ),
                                                  ),
                                                  CustomText(
                                                    text: "${plan.rate ?? 0}",
                                                    size: 15,
                                                    color: FF025074,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );
                                    })
                              ],
                            );
                          }),
                      const SizedBox(height: 8),
                      Divider(),
                      const SizedBox(height: 16),
                      CustomText(
                        text: "How it works?",
                        size: 15,
                        color: FF050707,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: FFB5D2E0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "1",
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 34,
                                    child: VerticalDivider(color: FFBDC5C5)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                height: 61,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Enroll",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      color: FF050707,
                                    ),
                                    CustomText(
                                      text:
                                          "You enroll in a package of your choice",
                                      size: 14,
                                      color: FF6D7274,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: FFB5D2E0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "2",
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 34,
                                    child: VerticalDivider(color: FFBDC5C5)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                height: 61,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Coach calls you",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      color: FF050707,
                                    ),
                                    CustomText(
                                      text: "Coach calls you within 24 hours",
                                      size: 14,
                                      color: FF6D7274,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: FFB5D2E0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "3",
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 41,
                                    child: VerticalDivider(color: FFBDC5C5)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                height: 71,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text:
                                          "Coach understands & set expectation",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      color: FF050707,
                                    ),
                                    CustomText(
                                      text:
                                          "Coach understands your goal, sets expectation about how this work",
                                      size: 14,
                                      color: FF6D7274,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: FFB5D2E0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "4",
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 44,
                                    child: VerticalDivider(color: FFBDC5C5)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                height: 71,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Coach Prepares plan for you",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      color: FF050707,
                                    ),
                                    CustomText(
                                      text:
                                          "Coach evaluates and prepares the best plan for you",
                                      size: 14,
                                      color: FF6D7274,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: FFB5D2E0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "5",
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 44,
                                    child: VerticalDivider(color: FFBDC5C5)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                height: 71,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Coach assesses your progress",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      color: FF050707,
                                    ),
                                    CustomText(
                                      text:
                                          "Coach assesses your weekly progress and makes course adjustment.",
                                      size: 14,
                                      color: FF6D7274,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: FFB5D2E0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "6",
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 44,
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                height: 71,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "You Get result.",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      color: FF050707,
                                    ),
                                    CustomText(
                                      text:
                                          "Finally you will end up with good results!",
                                      size: 14,
                                      color: FF6D7274,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
