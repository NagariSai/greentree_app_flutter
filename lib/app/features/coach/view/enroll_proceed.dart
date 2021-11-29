import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/category_plan_model.dart';
import 'package:fit_beat/app/features/coach/controller/coach_detail_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class EnrollProceed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FitnessCategoryPlan plan = Get.arguments[0];
    String title = Get.arguments[1] ?? "";
    return Scaffold(
      appBar: CustomAppBar(
        title: "${plan.title ?? ""}",
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RoundedCornerButton(
          height: 50,
          buttonText: "Proceed",
          buttonColor: FF025074,
          borderColor: FF025074,
          fontSize: 14,
          radius: 12,
          isIconWidget: false,
          iconAndTextColor: Colors.white,
          iconData: null,
          onPressed: () {
            Get.offNamed(Routes.userEnrollPayPage, arguments: [plan, title]);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            CustomText(
              text: "Title",
              size: 12,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "$title - ${plan.title ?? ""}",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Duration",
              size: 12,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text:
                  "${plan.duration ?? ""}  ${plan.type == "W" ? "Week" : "Day"}",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Amount",
              size: 12,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "${plan.rate ?? ""}",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Description",
              size: 12,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "${plan.description ?? ""}",
              size: 14,
              maxLines: 20,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Note",
              size: 12,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "${plan.note ?? ""}",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Coach",
              size: 12,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircularImage(
                      height: 46,
                      width: 46,
                      imageUrl:
                          "${Get.find<CoachDetailsController>().coachProfile.profileUrl ?? ""}",
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: InkWell(
                        onTap: () {},
                        child: CommonContainer(
                            height: 16,
                            width: 16,
                            borderRadius: 16,
                            backgroundColor: FFFBAB4D,
                            decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                shape: BoxShape.circle),
                            child: Center(
                              child: CustomText(
                                text: "C",
                                size: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          "${Get.find<CoachDetailsController>().coachProfile.fullName ?? ""}",
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonContainer(
                        height: 24,
                        borderRadius: 4,
                        backgroundColor: FFFBAB4D,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomText(
                            text: "Basic",
                            size: 13,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
