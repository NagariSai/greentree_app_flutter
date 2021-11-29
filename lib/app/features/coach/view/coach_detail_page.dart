import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/coach_profile_info_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach/controller/coach_detail_controller.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GetBuilder<CoachDetailsController>(
          init: CoachDetailsController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _.isCoachProfileLoading
                ? Center(child: CircularProgressIndicator())
                : _.coachProfile != null
                    ? SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 212,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              height: 212,
                                              width: Get.width,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${_.coachProfile?.backgroundProfileUrl ?? "https://www.crescendo-global.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBbk1HIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--0725fc0328bc750a0fcc18a18ffde9bcca5b8dff/old-img-placeholder.jpg"}",
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  Assets.backgroundBanner,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 174,
                                      child: Stack(
                                        children: [
                                          CircularImage(
                                            height: 76,
                                            width: 76,
                                            imageUrl:
                                                _.coachProfile?.profileUrl ??
                                                    "",
                                          ),
                                          Positioned(
                                            bottom: 1,
                                            right: 1,
                                            child: InkWell(
                                              onTap: () {},
                                              child: CommonContainer(
                                                  height: 24,
                                                  width: 24,
                                                  borderRadius: 24,
                                                  backgroundColor: FFFBAB4D,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: primaryColor),
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: CustomText(
                                                      text: "C",
                                                      size: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text:
                                                "${_.coachProfile?.fullName ?? ""}",
                                            size: 20,
                                            color: FF050707,
                                          ),
                                          CustomText(
                                            text:
                                                "${_.fitnessCategoryStr?.trim()}",
                                            size: 13,
                                            color: FF6D7274,
                                          ),
                                          const SizedBox(height: 10),
                                          CommonContainer(
                                              height: 32,
                                              borderRadius: 4,
                                              backgroundColor: FFFBAB4D,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomText(
                                                  text:
                                                      "${Utils().getCoachExp(_.coachProfile.experienceLevel ?? 1)}",
                                                  size: 13,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Container(
                                                width: Get.width / 3 - 16,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: FFF1F3F3),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: 18,
                                                          color: FFFBAB4D,
                                                        ),
                                                        CustomText(
                                                          text:
                                                              "${_.coachProfile?.rating ?? 0}",
                                                          size: 18,
                                                          maxLines: 3,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    CustomText(
                                                      text: "Rating",
                                                      size: 13,
                                                      maxLines: 3,
                                                      color: FF6D7274,
                                                    )
                                                  ],
                                                )),
                                            onTap: () {
                                              if (_.coachProfile.isMyReview ==
                                                  2) {
                                                Get.toNamed(
                                                    Routes.userCoachRatingPage,
                                                    arguments: [
                                                      _.coachProfile.userId,
                                                      _.coachProfile.rating
                                                    ]);
                                              }
                                            },
                                          ),
                                          Container(
                                              height: 90,
                                              width: Get.width / 3 - 16,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: FFF1F3F3),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "${_.coachProfile?.trained ?? 0}",
                                                        size: 18,
                                                        maxLines: 3,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  CustomText(
                                                    text: "Trained",
                                                    size: 13,
                                                    maxLines: 3,
                                                    color: FF6D7274,
                                                  )
                                                ],
                                              )),
                                          Container(
                                              height: 90,
                                              width: Get.width / 3 - 16,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: FFF1F3F3),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "${_.coachProfile?.availSlots ?? 0}",
                                                        size: 18,
                                                        maxLines: 3,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  CustomText(
                                                    text: "Available Slots",
                                                    size: 13,
                                                    maxLines: 3,
                                                    color: FF6D7274,
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Divider(),
                                    const SizedBox(height: 15),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                text: "${_.postCount ?? 0}",
                                                size: 18,
                                                maxLines: 3,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(height: 8),
                                              CustomText(
                                                text: "Posts",
                                                size: 13,
                                                maxLines: 3,
                                                color: FF6D7274,
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                text:
                                                    "${_.coachProfile?.followersCount ?? 0}",
                                                size: 18,
                                                maxLines: 3,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(height: 8),
                                              CustomText(
                                                text: "Followers",
                                                size: 13,
                                                maxLines: 3,
                                                color: FF6D7274,
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                text:
                                                    "${_.coachProfile?.followingCount ?? 0}",
                                                size: 18,
                                                maxLines: 3,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(height: 8),
                                              CustomText(
                                                text: "Following",
                                                size: 13,
                                                maxLines: 3,
                                                color: FF6D7274,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            visible: _.coachProfile?.isBtn == 0
                                                ? false
                                                : true,
                                            child: Container(
                                              child: _.coachProfile?.isBtn == 3
                                                  ? RoundedCornerButton(
                                                      height: 36,
                                                      width: 94,
                                                      buttonText: "Enrolled",
                                                      buttonColor: FFFFFFFF,
                                                      borderColor: FF025074,
                                                      fontSize: 14,
                                                      radius: 6,
                                                      iconAndTextColor:
                                                          FF025074,
                                                      onPressed: () {},
                                                    )
                                                  : _.coachProfile?.isBtn == 1
                                                      ? RoundedCornerButton(
                                                          height: 36,
                                                          width: 94,
                                                          buttonText: "Enroll",
                                                          buttonColor: FFFFFFFF,
                                                          borderColor: FF025074,
                                                          fontSize: 14,
                                                          radius: 6,
                                                          iconAndTextColor:
                                                              FF025074,
                                                          onPressed: () {
                                                            Get.find<CoachDetailsController>()
                                                                    .isEnroll =
                                                                true;
                                                            Get.toNamed(
                                                                Routes
                                                                    .userEnrollPage,
                                                                arguments: [
                                                                  _.fitnessCategoryId,
                                                                  _.coachProfileId
                                                                ]);
                                                          },
                                                        )
                                                      : _.coachProfile?.isBtn ==
                                                              2
                                                          ? RoundedCornerButton(
                                                              height: 36,
                                                              width: 94,
                                                              buttonText:
                                                                  "Send Request",
                                                              buttonColor:
                                                                  FFFFFFFF,
                                                              borderColor:
                                                                  FF025074,
                                                              fontSize: 14,
                                                              radius: 6,
                                                              iconAndTextColor:
                                                                  FF025074,
                                                              onPressed: () {
                                                                Get.find<CoachDetailsController>()
                                                                        .isEnroll =
                                                                    false;
                                                                Get.toNamed(Routes
                                                                    .userEnrollPage);
                                                              },
                                                            )
                                                          : _.coachProfile
                                                                      ?.isBtn ==
                                                                  4
                                                              ? RoundedCornerButton(
                                                                  height: 36,
                                                                  width: 94,
                                                                  buttonText:
                                                                      "Request Send",
                                                                  buttonColor:
                                                                      FFFFFFFF,
                                                                  borderColor:
                                                                      FF025074,
                                                                  fontSize: 14,
                                                                  radius: 6,
                                                                  iconAndTextColor:
                                                                      FF025074,
                                                                  onPressed:
                                                                      () {
                                                                    Get.find<CoachDetailsController>()
                                                                            .isEnroll =
                                                                        false;
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .userEnrollPage);
                                                                  },
                                                                )
                                                              : Container(
                                                                  height: 0,
                                                                  width: 0,
                                                                ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: _.coachProfile?.isBtn == 0
                                                  ? 0
                                                  : 20),
                                          RoundedCornerButton(
                                            height: 36,
                                            width: 94,
                                            buttonText: "Message",
                                            buttonColor: FFFFFFFF,
                                            borderColor: FF025074,
                                            fontSize: 14,
                                            radius: 6,
                                            iconAndTextColor: FF025074,
                                            onPressed: () {},
                                          ),
                                          const SizedBox(width: 20),
                                          RoundedCornerButton(
                                            height: 36,
                                            width: 94,
                                            buttonText: "Follow",
                                            buttonColor: FF025074,
                                            borderColor: FF025074,
                                            fontSize: 14,
                                            radius: 6,
                                            isIconWidget: false,
                                            iconAndTextColor: Colors.white,
                                            iconData: null,
                                            onPressed: () {},
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Years of experience",
                                            color: FF6D7274,
                                            size: 12,
                                          ),
                                          const SizedBox(height: 6),
                                          CustomText(
                                            text:
                                                "${_.coachProfile?.noOfExperience ?? 0}",
                                            color: FF050707,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Levels",
                                            color: FF6D7274,
                                            size: 12,
                                          ),
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: _.getCoachLevelList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Known Languages",
                                            color: FF6D7274,
                                            size: 12,
                                          ),
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: _.getLanguageList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Work experience",
                                            color: FF6D7274,
                                            size: 12,
                                          ),
                                          const SizedBox(height: 6),
                                          CustomText(
                                            text:
                                                "${_.coachProfile?.bio ?? ""}",
                                            color: FF050707,
                                            maxLines: 3,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _.coachProfile?.userCertificates?.length > 0
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: "Certificates",
                                                  color: FF6D7274,
                                                  size: 12,
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  height: 110,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: _
                                                          .coachProfile
                                                          .userCertificates
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        UserCertificate
                                                            certificate =
                                                            _.coachProfile
                                                                    .userCertificates[
                                                                index];
                                                        return Container(
                                                          height: 100,
                                                          width: 98,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Container(
                                                              height: 100,
                                                              width: Get.width,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    certificate
                                                                        .certificateUrl,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                  Assets
                                                                      .backgroundBanner,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                  Assets
                                                                      .placeholder,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                const SizedBox(height: 8),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Divider(
                                      thickness: 4,
                                      color: dividerColor,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 16),
                                      height: 50,
                                      child: ListView.separated(
                                        itemCount: _.topicList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, position) {
                                          var data = _.topicList[position];
                                          return GestureDetector(
                                            onTap: () {
                                              _.getFilteredFeed(position);
                                            },
                                            child: Chip(
                                              shape: data.isSelected
                                                  ? null
                                                  : StadiumBorder(
                                                      side: BorderSide(
                                                          color: borderColor)),
                                              label: Text(data.title),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              labelStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: data.isSelected
                                                      ? FF050707
                                                      : titleBlackColor),
                                              backgroundColor: data.isSelected
                                                  ? FFB2C8D2
                                                  : Colors.white,
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, position) {
                                          return SizedBox(
                                            width: 8,
                                          );
                                        },
                                      ),
                                    ),
                                    Divider(
                                      thickness: 4,
                                      color: dividerColor,
                                    ),
                                    _.feedList.length > 0
                                        ? ListView.separated(
                                            itemCount: _.feedList.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return FeedWidget(
                                                feedData: _.feedList[index],
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                thickness: 4,
                                                color: dividerColor,
                                              );
                                            },
                                          )
                                        : Container(
                                            height: Get.height * 0.4,
                                            child: Center(
                                              child: CustomText(
                                                text: "No data found",
                                              ),
                                            ),
                                          ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Text("No Data Found"),
                      );
          }),
    );
  }
}
