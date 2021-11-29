import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach/controller/coach_detail_controller.dart';
import 'package:fit_beat/app/features/coach/controller/coach_enroll_pay_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class EnrollPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoachEnrollPayController>(
        init: CoachEnrollPayController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Payment",
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundedCornerButton(
                height: 50,
                buttonText: "Pay",
                buttonColor: FF025074,
                borderColor: FF025074,
                fontSize: 14,
                radius: 12,
                isIconWidget: false,
                iconAndTextColor: Colors.white,
                iconData: null,
                onPressed: () {
                  _.setUserCoachEnrollment();
                },
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
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
                  const SizedBox(height: 16),
                  CustomText(
                    text: "${_.title} - ${_.plan.title}",
                    size: 15,
                    color: FF050707,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    text:
                        "Duration - ${_.plan.duration} ${_.plan.type == "W" ? "Weeks" : "Days"}",
                    size: 14,
                    color: FF6D7274,
                  ),
                  const SizedBox(height: 8),
                  Divider(),
                  const SizedBox(height: 8),
                  CustomText(
                    text: "Billing",
                    size: 15,
                    color: FF050707,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: "Package Amount",
                          size: 14,
                          color: FF73787A,
                        ),
                      ),
                      CustomText(
                        text: "${_.plan.rate}",
                        size: 14,
                        color: FF050707,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    Expanded(
                      child: CustomText(
                        text: "Tax (18%)",
                        size: 14,
                        color: FF73787A,
                      ),
                    ),
                    CustomText(
                      text: "Kr 400",
                      size: 14,
                      color: FF050707,
                      fontWeight: FontWeight.bold,
                    ),
                  ]),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: "Total",
                          size: 14,
                          color: FF050707,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomText(
                        text: "Kr 3400",
                        size: 14,
                        color: FF6BD295,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CommonContainer(
                    height: 144,
                    borderRadius: 8,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: FFC4CACC,
                          width: 1,
                        ),
                        color: FFC4CACC,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomText(
                            text: "Note",
                            size: 12,
                            color: FF6D7274,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 80,
                          child: TextField(
                            controller: _.reviewController,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Write review here..',
                                hintStyle: TextStyle(
                                    color: FFBDC5C5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: FontFamily.poppins,
                                    decoration: TextDecoration.none)),
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
