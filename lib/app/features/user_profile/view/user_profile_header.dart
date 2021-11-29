import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/chat/controllers/connection_status_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/features/user_profile/controller/user_profile_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(builder: (_) {
      double horizontalPadding = _.profile.isPlan ? 20 : 60;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                Spacer(),
                CircularImage(
                  height: 76,
                  width: 76,
                  imageUrl: _.profile.profileUrl ?? "",
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    _openDialog(context, 1);
                  },
                  child: CommonContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Assets.ellipses,
                        width: 20,
                      ),
                    ),
                    borderRadius: 32,
                    height: 32,
                    width: 32,
                    backgroundColor: FFE4ECF0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          CustomText(
            text: _.profile.fullName ?? "",
            size: 20,
            fontWeight: FontWeight.w900,
            color: titleBlackColor,
          ),
          const SizedBox(height: 24),
          Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(
                      text: "${_.postCount ?? "0"}",
                      size: 18,
                      fontWeight: FontWeight.w900,
                      color: titleBlackColor,
                    ),
                    CustomText(
                      text: "Posts",
                      size: 13,
                      fontWeight: FontWeight.normal,
                      color: FF6D7274,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () =>
                      Get.toNamed(Routes.follower, arguments: _.profile.userId),
                  child: Column(
                    children: [
                      CustomText(
                        text: "${_.profile.followersCount ?? "0"}",
                        size: 18,
                        fontWeight: FontWeight.w900,
                        color: titleBlackColor,
                      ),
                      CustomText(
                        text: "Followers",
                        size: 13,
                        fontWeight: FontWeight.normal,
                        color: FF6D7274,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.following,
                      arguments: _.profile.userId),
                  child: Column(
                    children: [
                      CustomText(
                        text: "${_.profile.followingCount ?? "0"}",
                        size: 18,
                        fontWeight: FontWeight.w900,
                        color: titleBlackColor,
                      ),
                      CustomText(
                        text: "Following",
                        size: 13,
                        fontWeight: FontWeight.normal,
                        color: FF6D7274,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_.profile.isPlan == true)
                  RoundedCornerButton(
                    height: 36,
                    width: 94,
                    buttonText: "+ Add Plan",
                    buttonColor: FFFFFFFF,
                    borderColor: FF025074,
                    fontSize: 14,
                    radius: 6,
                    isIconWidget: false,
                    iconAndTextColor: FF025074,
                    iconData: null,
                    onPressed: () {
                      Get.toNamed(Routes.coachAddPage);
                    },
                  ),
                RoundedCornerButton(
                  height: 36,
                  width: 94,
                  buttonText: Utils.getChatInvitationText(_.profile.isChat),
                  buttonColor: chatStatusBgColor1[_.profile.isChat],
                  borderColor: chatStatusBorderColor[_.profile.isChat],
                  fontSize: 14,
                  radius: 6,
                  iconAndTextColor: chatStatusTextColor1[_.profile.isChat],
                  onPressed: () async {
                    if (_.profile.isChat == 0) {
                      var result =
                          await DialogUtils.sendInviteDialog(_.profile.userId);

                      print("ress");
                      if (result) _.reloadPage();
                    } else if (_.profile.isChat == 2) {
                      var result = await Get.find<ConnectionStatusController>()
                          .acceptChatInvite(_.profile.userId);
                      if (result) _.reloadPage();
                    } else if (_.profile.isChat == 3) {
                      Get.toNamed(Routes.chatPage, arguments: [
                        _.profile.userId,
                        _.profile.fullName,
                        _.profile.profileUrl,
                        _.profile.userChatConnectionId,
                      ]);
                    }
                  },
                ),
                _.profile.isFollow == 0
                    ? RoundedCornerButton(
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
                        onPressed: () {
                          _.followUser();
                        },
                      )
                    : RoundedCornerButton(
                        height: 36,
                        width: 94,
                        buttonText: "Following",
                        buttonColor: FFFFFFFF,
                        borderColor: FF025074,
                        fontSize: 14,
                        radius: 6,
                        iconAndTextColor: FF025074,
                        onPressed: () {
                          _openDialog(context, 2);
                        },
                      ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  void _openDialog(BuildContext context, int type) {
    var controller = Get.find<UserProfileController>();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          actions: <Widget>[
            if (type == 1) ...[
              CupertinoActionSheetAction(
                child: CustomText(
                  text: "Report",
                  size: 17,
                  fontWeight: FontWeight.w500,
                  color: errorColor,
                ),
                isDefaultAction: true,
                onPressed: () {
                  Get.back();
                  Get.toNamed(Routes.report_user, arguments: [
                    controller.profile.userId,
                    controller.type,
                    0
                  ]);
                  // Navigator.pop(context, 'discussion');
                },
              ),
              CupertinoActionSheetAction(
                child: CustomText(
                  text: "Block",
                  size: 17,
                  fontWeight: FontWeight.w500,
                  color: errorColor,
                ),
                isDefaultAction: true,
                onPressed: () {
                  controller.blockUser();
                  Get.back();
                },
              ),
            ],
            controller.profile.isFollow == 1 && type == 2
                ? CupertinoActionSheetAction(
                    child: CustomText(
                      text: "Unfollow",
                      size: 17,
                      fontWeight: FontWeight.w500,
                      color: errorColor,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      controller.unFollowUser();
                    },
                  )
                : Container(),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: CustomText(
              text: "Cancel",
              size: 17,
              fontWeight: FontWeight.w500,
              color: cancelTextColor,
            ),
            isDefaultAction: false,
            onPressed: () {
              Get.back();
            },
          )),
    );
  }
}
