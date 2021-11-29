import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/features/user_profile/controller/user_profile_controller.dart';
import 'package:fit_beat/app/features/user_profile/view/user_interest_and_goals.dart';
import 'package:fit_beat/app/features/user_profile/view/user_profile_header.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GetBuilder<UserProfileController>(
          init: UserProfileController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _.isProfileLoading
                ? Center(child: CircularProgressIndicator())
                : NestedScrollView(
                    headerSliverBuilder: (context, bool isInnerBoxScroll) {
                      return [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            _createTopView(),
                          ),
                        ),
                      ];
                    },
                    body: _.isUserFeedLoading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Container(
                                height: 50,
                                child: ListView.separated(
                                  itemCount: _.filterList.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                                                side: BorderSide(
                                                    color: borderColor)),
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
                              Divider(
                                thickness: 4,
                                color: dividerColor,
                              ),
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: _.feedList.length > 0
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
                                        ))
                            ],
                          ));
          }),
    );
  }

  List<Widget> _createTopView() {
    var _ = Get.find<UserProfileController>();
    return List.generate(1, (index) {
      return Column(
        children: [
          UserProfileHeader(),
          _.showDivider()
              ? Divider(color: FF6D7274, thickness: 0.2)
              : Container(),
          UserInterestAndGoals(),
          Divider(
            thickness: 4,
            color: dividerColor,
          ),
        ],
      );
    });
  }
}
