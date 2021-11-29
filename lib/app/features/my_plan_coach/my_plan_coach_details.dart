import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class MyPlanCoachDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Details",
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
              fontWeight: FontWeight.w400,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "Nutrition & Training -12 Weeks Transformation",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Duration",
              size: 12,
              fontWeight: FontWeight.w400,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "12 Weeks",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Amount",
              size: 12,
              fontWeight: FontWeight.w400,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "3000 Kr",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Description",
              size: 12,
              fontWeight: FontWeight.w400,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text:
                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
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
              fontWeight: FontWeight.w400,
              color: FF6D7274,
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "Saturday & Sunday will not be rest day",
              size: 14,
              color: FF050707,
            ),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            CustomText(
              text: "Coach",
              size: 12,
              fontWeight: FontWeight.w400,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: "Test Coach",
                            size: 16,
                            color: FF050707,
                            fontWeight: FontWeight.bold,
                          ),
                          Spacer(),
                          CustomText(
                            text: "13 Apr 2020",
                            size: 11,
                            color: FF6D7274,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
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
                          )),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.switchAccountPage);
                        },
                        child: CustomText(
                          text: "Switch coach",
                          size: 16,
                          color: FF55B5FE,
                        ),
                      ),
                    ],
                  ),
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
