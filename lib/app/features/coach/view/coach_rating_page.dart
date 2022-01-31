import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/coach_review_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach/controller/coach_rating_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CoachRatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: "Reviews",
      ),
      bottomNavigationBar: PrefData().isCoach()
          ? Container(
              height: 0,
              width: 0,
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundedCornerButton(
                height: 50,
                buttonText: "Give a Review",
                buttonColor: FF025074,
                borderColor: FF025074,
                fontSize: 14,
                radius: 12,
                isIconWidget: false,
                iconAndTextColor: Colors.white,
                iconData: null,
                onPressed: () {
                  Get.toNamed(Routes.userCoachReviewPage);
                },
              ),
            ),
      body: GetBuilder<CoachRatingController>(
          init: CoachRatingController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          CustomText(
                            text: "${_.ratingCount}",
                            size: 36,
                            color: FF050707,
                            fontWeight: FontWeight.bold,
                          ),
                          IgnorePointer(
                            child: RatingBar.builder(
                              initialRating: double.parse(_.ratingCount),
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: FFFBAB4D,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            text: "Based on ${_.count ?? 0} Reviews",
                            size: 14,
                            color: FF6D7274,
                          ),
                          const SizedBox(height: 8),
                          Divider(
                            thickness: 4,
                            color: dividerColor,
                          ),
                          const SizedBox(height: 8),
                          _.coachReviewList.length > 0
                              ? ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _.coachReviewList.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, position) {
                                    return Divider(
                                      thickness: 0.4,
                                      color: dividerColor,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    CoachReview review =
                                        _.coachReviewList[index];
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircularImage(
                                            height: 46,
                                            width: 46,
                                            imageUrl: review.profileUrl ?? "",
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomText(
                                                        text:
                                                            "${review.fullName ?? ""}",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: FF050707,
                                                        size: 16,
                                                      ),
                                                    ),
                                                    CustomText(
                                                      text:
                                                          "${Utils.convertDateIntoDisplayString(DateTime.fromMillisecondsSinceEpoch(int.parse(review.createDatetimeUnix)))}",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: FF6D7274,
                                                      size: 11,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    IgnorePointer(
                                                      child: RatingBar.builder(
                                                        initialRating: review
                                                            .rating
                                                            .toDouble(),
                                                        minRating: 0,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 14,
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: FFFBAB4D,
                                                          size: 14,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                    ),
                                                    CustomText(
                                                      text:
                                                          "${review.rating ?? "0"}",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: FF050707,
                                                      size: 12,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                CustomText(
                                                  text:
                                                      "${review.reviewContent ?? ""}",
                                                  color: FF6D7274,
                                                  maxLines: 3,
                                                  size: 12,
                                                ),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  child: Center(
                                      child: CustomText(
                                    text: "No Data Found",
                                  )),
                                ),
                          Divider(),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
