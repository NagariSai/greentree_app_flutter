import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/coach_enroll_user_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach_home/controller/coach_my_people_controller.dart';
import 'package:fit_beat/app/features/coach_home/view/completed_row.dart';
import 'package:fit_beat/app/features/coach_home/view/pending_row.dart';
import 'package:fit_beat/app/features/coach_home/view/switched_row.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'on_going_row.dart';

class MyPeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoachMyPeopleController>(
        init: CoachMyPeopleController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: ListView.separated(
                    itemCount: _.statusFilterList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      var data = _.statusFilterList[position];
                      return GestureDetector(
                        onTap: () {
                          _.getStatusFilteredFeed(position);
                        },
                        child: Chip(
                          shape: data.isSelected
                              ? null
                              : StadiumBorder(
                                  side: BorderSide(color: borderColor)),
                          label: Text(data.title),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: data.isSelected
                                  ? Colors.white
                                  : titleBlackColor),
                          backgroundColor:
                              data.isSelected ? primaryColor : Colors.white,
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
                _.isLoading
                    ? Container(
                        height: Get.height * 0.4,
                        child: Center(child: CircularProgressIndicator()))
                    : _.coachEnrollUserList.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: _.coachEnrollUserList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              CoachEnrollUser coachEnrollUser =
                                  _.coachEnrollUserList[index];
                              if (_.selectedStatusFilterType.type == 1) {
                                return OnGoingRow(
                                  coachEnrollUser: coachEnrollUser,
                                );
                              } else if (_.selectedStatusFilterType.type == 2) {
                                return PendingRow(
                                  coachEnrollUser: coachEnrollUser,
                                );
                              } else if (_.selectedStatusFilterType.type == 3) {
                                return CompletedRow(
                                  coachEnrollUser: coachEnrollUser,
                                );
                              } else if (_.selectedStatusFilterType.type == 4) {
                                return SwitchedRow(
                                  coachEnrollUser: coachEnrollUser,
                                );
                              }
                              return OnGoingRow(
                                coachEnrollUser: coachEnrollUser,
                              );
                            })
                        : Container(
                            height: Get.height * 0.4,
                            child: Center(
                              child: CustomText(
                                text: "No Data found",
                                size: 16,
                              ),
                            ),
                          )
              ],
            ),
          );
        });
  }
}
