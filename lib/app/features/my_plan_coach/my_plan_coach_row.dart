import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MyPlanCoachRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.myPlanDetailsPage);
      },
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Arun Sharma",
                        fontWeight: FontWeight.bold,
                        size: 16,
                        color: FF050707,
                      ),
                      CustomText(
                        text: "12 Weeks Transformation",
                        fontWeight: FontWeight.w300,
                        size: 11,
                        color: FF6D7274,
                      ),
                      const SizedBox(height: 10),
                      CommonContainer(
                          height: 19,
                          borderRadius: 4,
                          backgroundColor: FFFBAB4D,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomText(
                                text: "Basic",
                                size: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "12 Apr 2020",
                          fontWeight: FontWeight.w300,
                          size: 11,
                          color: FF6D7274,
                        ),
                        CustomText(
                          text: "3000 Kr",
                          fontWeight: FontWeight.w600,
                          size: 14,
                          color: FF6BD295,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              thickness: 1,
              color: dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
