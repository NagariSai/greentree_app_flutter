import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach_profile/controller/coach_profile_controller.dart';
import 'package:fit_beat/app/features/coach_profile/view/coach_profile_personal_info.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coach_profile_contact_info.dart';

class CoachProfilePage extends StatefulWidget {
  @override
  _CoachProfilePageState createState() => _CoachProfilePageState();
}

class _CoachProfilePageState extends State<CoachProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> tabs = <Widget>[
    Container(
        height: 44, width: Get.width / 2, child: Tab(text: "Personal Info.")),
    Container(
        height: 44, width: Get.width / 2, child: Tab(text: "Contact Info.")),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          Get.find<CoachProfileController>().setCurrentTab(0);

          break;
        case 1:
          Get.find<CoachProfileController>().setCurrentTab(1);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<CoachProfileController>(
        init: CoachProfileController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              negativeText: _.isEdit.value ? "Cancel" : null,
              positiveText: _.isEdit.value ? "Save" : null,
              onNegativeTap: () {
                _.isEdit.value = false;
                _.isEdit.refresh();
              },
              onPositiveTap: () {
                _.editProfile();
              },
            ),
            body: GetBuilder<CoachProfileController>(
              builder: (_) {
                return _.isCoachProfileLoading
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 212,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Stack(
                                                children: [
                                                  _.bannercamerasSelectFile !=
                                                          null
                                                      ? Container(
                                                          height: 212,
                                                          child: Image.file(
                                                            File(_
                                                                .bannercamerasSelectFile
                                                                .path),
                                                            fit: BoxFit.fill,
                                                            width: Get.width,
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 212,
                                                          width: Get.width,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "${_.coachProfile.backgroundProfileUrl ?? "https://www.crescendo-global.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBbk1HIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--0725fc0328bc750a0fcc18a18ffde9bcca5b8dff/old-img-placeholder.jpg"}",
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                              color: FFE0EAEE,
                                                              height: 212,
                                                              child: Center(
                                                                child:
                                                                    CustomText(
                                                                  text:
                                                                      "FitBeat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      FFA3C6D6,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  Positioned(
                                                    bottom: 10,
                                                    right: 10,
                                                    child: InkWell(
                                                      onTap: () {
                                                        _.openBannerCamera();
                                                      },
                                                      child: CommonContainer(
                                                          height: 24,
                                                          width: 24,
                                                          borderRadius: 24,
                                                          backgroundColor:
                                                              FFE0EAEE,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      primaryColor),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child:
                                                                  Image.asset(
                                                                Assets
                                                                    .ic_camera,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 174,
                                      child: GestureDetector(
                                        onTap: () {
                                          _.openCamera();
                                        },
                                        child: Stack(
                                          children: [
                                            _.camerasSelectFile != null
                                                ? CircularImage(
                                                    height: 76,
                                                    width: 76,
                                                    imageFile: _
                                                        .camerasSelectFile.path,
                                                    isImageFile: true,
                                                  )
                                                : CircularImage(
                                                    height: 76,
                                                    width: 76,
                                                    imageUrl: _.coachProfile
                                                            .profileUrl ??
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
                                                    backgroundColor: FFE0EAEE,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                primaryColor),
                                                        shape: BoxShape.circle),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Image.asset(
                                                          Assets.ic_camera,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 38,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text:
                                            "${_.coachProfile.fullName ?? ""}",
                                        size: 20,
                                        color: FF050707,
                                      ),
                                      CustomText(
                                        text: "${_.fitnessCategoryStr.trim()}",
                                        size: 13,
                                        color: FF6D7274,
                                      ),
                                      const SizedBox(height: 10),
                                      CommonContainer(
                                          height: 32,
                                          borderRadius: 4,
                                          backgroundColor: FFFBAB4D,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: "Basic",
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
                                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: FFFBAB4D,
                                                    ),
                                                    CustomText(
                                                      text:
                                                          "${_.coachProfile.rating ?? 0}",
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
                                          Get.toNamed(
                                              Routes.userCoachRatingPage,
                                              arguments: [
                                                _.coachProfile.userId,
                                                _.coachProfile.rating
                                              ]);
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.coachTrainedPepople);
                                        },
                                        child: Container(
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
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          "${_.coachProfile.trained ?? 0}",
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
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        "${_.coachProfile.availSlots ?? 0}",
                                                    size: 18,
                                                    maxLines: 3,
                                                    fontWeight: FontWeight.bold,
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
                                  padding: EdgeInsets.symmetric(horizontal: 40),
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
                                                "${_.coachProfile.followersCount ?? 0}",
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
                                                "${_.coachProfile.followingCount ?? 0}",
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
                                Divider(),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: CommonContainer(
                                    height: 44,
                                    width: Get.width,
                                    borderRadius: 38,
                                    backgroundColor: FFE0EAEE,
                                    child: TabBar(
                                      isScrollable: false,
                                      unselectedLabelColor: FF6D7274,
                                      labelColor: FF050707,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicator: CustomTabIndicator(
                                        indicatorHeight: 31.0,
                                        indicatorColor: FFFFFFFF,
                                        indicatorRadius: 40,
                                      ),
                                      onTap: (int index) {
                                        _.setCurrentTab(index);
                                      },
                                      tabs: tabs,
                                      controller: _tabController,
                                    ),
                                  ),
                                ),
                                GetBuilder<CoachProfileController>(
                                    builder: (_) {
                                  if (_.currentIndex == 0) {
                                    return CoachProfilePersonalInfo();
                                  } else {
                                    return CoachProfileContactInfo();
                                  }
                                }),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
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
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return FeedWidget(context,
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
                            )
                          ],
                        ),
                      );
              },
            ),
          );
        });
  }
}
