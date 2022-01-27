import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/coach_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      body: GetBuilder<HomeController>(
        init: HomeController(repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) => _.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )

            : LazyLoadScrollView(
                onEndOfPage: () => _.loadNextFeed(),
                isLoading: _.feedLastPage,
                child: RefreshIndicator(

                  key: _.indicator,
                  onRefresh: _.reloadFeeds,
                  child: SingleChildScrollView(

                    controller: _.scrollController,
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                           Get.toNamed(Routes.todaySchedulePage);

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: Row(
                              children: [
                                Obx(
                                  () => CircularImage(
                                    imageUrl: Get.find<MainController>()
                                            .profileUrl
                                            .value ??
                                        "",
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Today's schedule",
                                  style: TextStyle(
                                      fontSize: 18, color: titleBlackColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: dividerColor,
                        ),
                        Container(
                          height: 40,
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.comingSoonPage,
                                      arguments: "Live");
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.video,
                                      width: 18,
                                      height: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Live",
                                      style: TextStyle(
                                        color: titleBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Get.toNamed(Routes.coachListUserPage),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.user,
                                      width: 18,
                                      height: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Get a Coach",
                                      style: TextStyle(
                                        color: titleBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              /* Row(
                                children: [
                                  Image.asset(
                                    Assets.exercise,
                                    width: 18,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Home Workout",
                                    style: TextStyle(
                                      color: titleBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),*/
                              /*InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.comingSoonPage,
                                      arguments: "Exercise");
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.dumbell,
                                      width: 18,
                                      height: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Exercise",
                                      style: TextStyle(
                                        color: titleBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),*/
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.comingSoonPage,
                                      arguments: "Events");
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.events,
                                      width: 18,
                                      height: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Events",
                                      style: TextStyle(
                                        color: titleBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: dividerColor,
                        ),
                        _.coachList.length > 0
                            ? Container(
                                height: 132,
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Suggested Coaches",
                                          style: TextStyle(
                                            color: titleBlackColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.coachListUserPage);
                                          },
                                          child: Text(
                                            "View All",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _.coachList.length,
                                          itemBuilder:
                                              (BuildContext contex, int index) {
                                            Coach coach = _.coachList[index];
                                            return InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.coachDetailPage,
                                                    arguments: coach.userId);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16),
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        CircularImage(
                                                          width: 62,
                                                          height: 62,
                                                          imageUrl: coach
                                                                  .profileUrl ??
                                                              "",
                                                        ),
                                                        Positioned(
                                                          bottom: 1,
                                                          right: 1,
                                                          child: InkWell(
                                                            onTap: () {},
                                                            child:
                                                                CommonContainer(
                                                                    height: 16,
                                                                    width: 16,
                                                                    borderRadius:
                                                                        16,
                                                                    backgroundColor:
                                                                        FF6BD295,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                primaryColor),
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CustomText(
                                                                        text:
                                                                            "C",
                                                                        size:
                                                                            10,
                                                                        color:
                                                                            FFFFFFFF,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      "${coach.fullName ?? ""}",
                                                      style: TextStyle(
                                                        color: titleBlackColor,
                                                        fontSize: 11,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        _.coachList.length > 0
                            ? Divider(
                                thickness: 1,
                                color: dividerColor,
                              )
                            : Container(),
                        Container(
                          height: 50,
                          child: ListView.separated(
                            itemCount: _.filterList.length,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, position) {
                              var data = _.filterList[position];
                              return GestureDetector(
                                onTap: () {
                                  _.getFilteredFeed(position);
                                },
                                child: Chip(
                                  shape: data.isSelected
                                      ? null
                                      : StadiumBorder(
                                          side: BorderSide(color: borderColor)),
                                  label: Text(data.title),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      color: data.isSelected
                                          ? Colors.white
                                          : titleBlackColor),
                                  backgroundColor: data.isSelected
                                      ? primaryColor
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

                        /*children: [
                              Chip(
                                label: Text("All"),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                labelStyle:
                                    TextStyle(fontSize: 14, color: Colors.white),
                                backgroundColor: primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Chip(
                                shape: StadiumBorder(
                                    side: BorderSide(color: borderColor)),
                                label: Text("Challenges"),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                labelStyle:
                                    TextStyle(fontSize: 14, color: titleBlackColor),
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Chip(
                                shape: StadiumBorder(
                                    side: BorderSide(color: borderColor)),
                                label: Text("Transformations"),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                labelStyle:
                                    TextStyle(fontSize: 14, color: titleBlackColor),
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Chip(
                                shape: StadiumBorder(
                                    side: BorderSide(color: borderColor)),
                                label: Text("Recipe"),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                labelStyle:
                                    TextStyle(fontSize: 14, color: titleBlackColor),
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Chip(
                                shape: StadiumBorder(
                                    side: BorderSide(color: borderColor)),
                                label: Text("Discussions"),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                labelStyle:
                                    TextStyle(fontSize: 14, color: titleBlackColor),
                                backgroundColor: Colors.white,
                              ),
                            ],*/
                        Divider(
                          thickness: 1,
                          color: dividerColor,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: _.feedList.length > 0
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
                                      thickness: 1,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
