import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach/controller/coach_rating_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CoachReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Give a Review",
        negativeText: "Cancel",
        positiveText: "Submit",
        onNegativeTap: () {
          Get.back();
        },
        onPositiveTap: () {
          Get.find<CoachRatingController>().giveCoachRating();
        },
      ),
      body: GetBuilder<CoachRatingController>(
          init: CoachRatingController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    CustomText(
                      text: "How did we do?",
                      size: 12,
                      color: FF6D7274,
                    ),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: FFFBAB4D,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        _.userRating = rating;
                      },
                    ),
                    Divider(),
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
                              text: "Care to share more about it?",
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
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
