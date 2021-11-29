import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/circular_indicator.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/notification_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/notification/controller/notification_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  List<UserNotification> data = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Notifications",
              onPositiveTap: () {
                _.deleteNotification();
              },
              positiveText: "Clear All",
            ),
            body: _.isLoading
                ? Center(child: CircularIndicator())
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Divider(),
                          _.notificationListMap.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _.notificationListMap.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var key = _.notificationListMap.keys
                                        .elementAt(index);
                                    data = _.notificationListMap[key];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: key,
                                          size: 14,
                                          fontWeight: FontWeight.bold,
                                          color: FF050707,
                                        ),
                                        const SizedBox(height: 10),
                                        ListView.builder(
                                            itemCount: data.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              String firstName;
                                              String lastName;
                                              try {
                                                firstName = data[index]
                                                        .notificationContent
                                                        .split(" ")[0] ??
                                                    "";
                                                lastName = data[index]
                                                        .notificationContent
                                                        .split(" ")[1] ??
                                                    "";
                                              } catch (e) {
                                                firstName = "";
                                                lastName = "";
                                              }
                                              return Slidable(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    redirect(data[index]);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircularImage(
                                                            height: 46,
                                                            width: 46,
                                                            imageUrl: data[
                                                                        index]
                                                                    .profileUrl ??
                                                                "",
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    /*CustomText(
                                                                      text:
                                                                          "${firstName} ${lastName} ",
                                                                      size: 14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          FF050707,
                                                                    ),*/
                                                                    Expanded(
                                                                      child:
                                                                          CustomText(
                                                                        text:
                                                                            "${data[index].notificationContent ?? ""}",
                                                                        size:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color:
                                                                            FF73787A,
                                                                        maxLines:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 6),
                                                                CustomText(
                                                                  text:
                                                                      "${Utils.convertDateIntoDisplayString(data[index].createDatetime)}",
                                                                  size: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color:
                                                                      FF6D7274,
                                                                  maxLines: 14,
                                                                ),
                                                                const SizedBox(
                                                                    height: 6),
                                                                /* index == 2
                                                                        ? Row(
                                                                            children: [
                                                                              RoundedCornerButton(
                                                                                height:
                                                                                    30,
                                                                                width:
                                                                                    94,
                                                                                buttonText:
                                                                                    "Cancel",
                                                                                buttonColor:
                                                                                    FFFFFFFF,
                                                                                borderColor:
                                                                                    FF025074,
                                                                                fontSize:
                                                                                    14,
                                                                                radius:
                                                                                    6,
                                                                                iconAndTextColor:
                                                                                    FF025074,
                                                                                onPressed:
                                                                                    () {},
                                                                              ),
                                                                              const SizedBox(
                                                                                  width:
                                                                                      20),
                                                                              RoundedCornerButton(
                                                                                height:
                                                                                    30,
                                                                                width:
                                                                                    94,
                                                                                buttonText:
                                                                                    "Accept",
                                                                                buttonColor:
                                                                                    FF6BD295,
                                                                                borderColor:
                                                                                    FF6BD295,
                                                                                fontSize:
                                                                                    14,
                                                                                radius:
                                                                                    6,
                                                                                isIconWidget:
                                                                                    false,
                                                                                iconAndTextColor:
                                                                                    Colors.white,
                                                                                iconData:
                                                                                    null,
                                                                                onPressed:
                                                                                    () {},
                                                                              )
                                                                            ],
                                                                          )
                                                                        : Container()*/
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider()
                                                    ],
                                                  ),
                                                ),
                                               /* endActionPane:
                                                    SlidableScrollActionPane(),
                                                direction: Axis.horizontal,
                                                secondaryActions: [
                                                  RoundedCornerButton(
                                                    height: 58,
                                                    width: 50,
                                                    buttonText: "Clear",
                                                    buttonColor: FFFF9B91,
                                                    borderColor: FFFF9B91,
                                                    fontSize: 14,
                                                    radius: 6,
                                                    isIconWidget: false,
                                                    iconAndTextColor:
                                                        Colors.white,
                                                    iconData: null,
                                                    onPressed: () {
                                                      _.deleteNotification();
                                                    },
                                                  )
                                                ],*/
                                              );
                                            }),
                                      ],
                                    );
                                  })
                              : Container(
                                  height: Get.height * 0.4,
                                  child: Center(
                                    child: CustomText(
                                      text: "No data found",
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
          );
        });
  }

  void redirect(UserNotification data) {
    print("discussion");
    try {
      var notificationType = data.notificationType;
      if (notificationType == 1) {
        if (data.globalType == 1) {
          print("discussion");

          Get.toNamed(Routes.discussion_detail_page, arguments: [
            data.globalId,
            data.globalType,
            data.triedCount,
            data.title,
          ]);
        } else if (data.globalType == 2) {
          Get.toNamed(Routes.challenge_detail_page, arguments: [
            data.globalId,
            data.globalType,
          ]);
        } else if (data.globalType == 3) {
          Get.toNamed(Routes.transformation_detail_page, arguments: [
            data.globalId,
            data.globalType,
          ]);
        } else if (data.globalType == 4) {
          Get.toNamed(Routes.receipe_detail_page, arguments: [
            data.globalId,
            data.globalType,
          ]);
        } else if (data.globalType == 5) {
          Get.toNamed(Routes.post_update_detail_page, arguments: [
            data.globalId,
            data.globalType,
          ]);
        } else if (data.globalType == 6) {
          Get.toNamed(Routes.otherFeedPage, parameters: {
            "count": data.triedCount.toString(),
            "title": data.title,
            "isChallenge": "true",
            "masterPostId": data.globalId.toString(),
          });
        }
      } else if (notificationType == 2) {
        //chat

        Get.toNamed(Routes.chatPage, arguments: [
          data.fromUserId,
          data.fullName,
          data.profileUrl,
          data.userNotificationId,
        ]);
      } else if (notificationType == 3) {
        // profile
        Get.toNamed(Routes.userProfile, arguments: [data.fromUserId, 1]);
      } else if (notificationType == 4) {
        // profile
        Get.toNamed(
          Routes.waterReminderPage,
        );
      }
    } catch (_) {
      print("exception ${_.toString()}");
    }
  }
}
