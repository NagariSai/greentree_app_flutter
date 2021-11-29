import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/coach_list_model.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class CoachListRow extends StatelessWidget {
  Coach coach;
  CoachListRow({this.coach});

  @override
  Widget build(BuildContext context) {
    String coachFitnessTitle = "";
    if (coach.userFitnessCategories.length > 0) {
      for (UserFitnessCategory category in coach.userFitnessCategories) {
        coachFitnessTitle += "${category.title},";
      }
    }
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.coachDetailPage, arguments: coach.userId);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: FFF1F3F3),
        margin: EdgeInsets.only(right: 15, bottom: 15),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularImage(
                        height: 46,
                        width: 46,
                        imageUrl: coach.profileUrl ?? "",
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
                              backgroundColor: FFE0EAEE,
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: CustomText(
                                  text: "C",
                                  size: 10,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: FFFBAB4D,
                        ),
                        CustomText(
                          text: "${coach.rating ?? ""}",
                          size: 12,
                          maxLines: 3,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              CustomText(
                text: "${coach.fullName ?? ""}",
                size: 14,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              Container(
                height: 35,
                child: CustomText(
                  text: "${coachFitnessTitle != "" ? coachFitnessTitle : "NA"}",
                  maxLines: 2,
                  size: 11,
                  textAlign: TextAlign.center,
                  color: FF6D7274,
                ),
              ),
              const SizedBox(height: 5),
              CommonContainer(
                  borderRadius: 4,
                  backgroundColor: FFFBAB4D,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text:
                          "${Utils().getCoachExp(coach.experienceLevel ?? 1)}",
                      size: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  )),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: "${coach.trained ?? "0"}",
                        size: 12,
                        color: FF050707,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      CustomText(
                        text: "Trained",
                        size: 10,
                        color: FF6D7274,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: "${coach.availSlots ?? "0"}",
                        size: 12,
                        color: FF050707,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      CustomText(
                        text: "Avail Slots",
                        size: 10,
                        color: FF6D7274,
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
