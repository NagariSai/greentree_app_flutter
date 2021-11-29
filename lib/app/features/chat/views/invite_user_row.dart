import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/chat/invite_new_chat_user_response.dart';
import 'package:fit_beat/app/features/chat/controllers/connection_status_controller.dart';
import 'package:fit_beat/app/features/chat/controllers/invite_user_to_chat_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteUserRow extends StatelessWidget {
  String title;
  NewUserChat userData;
  bool isInvited;
  InviteUserRow({@required this.userData});

  @override
  Widget build(BuildContext context) {
    if (userData.invideFlag == 0) {
      title = "Invite";
      isInvited = false;
    } else {
      title = "Invited";
      isInvited = true;
    }

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Row(
        children: [
          CircularImage(
            height: 46,
            width: 46,
            imageUrl: userData.profileUrl ?? "",
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: userData.fullName ?? "",
                  size: 16,
                  fontWeight: FontWeight.w900,
                  color: titleBlackColor,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "${userData.totalPost ?? ""} Posts",
                      size: 11,
                      fontWeight: FontWeight.w300,
                      color: FF6D7274,
                    ),
                    CustomText(
                      text: " | ",
                      size: 11,
                      fontWeight: FontWeight.w300,
                      color: FF6D7274,
                    ),
                    CustomText(
                      text: "${userData.followersCount ?? ""} Followers",
                      size: 11,
                      fontWeight: FontWeight.w300,
                      color: FF6D7274,
                    ),
                  ],
                )
              ],
            ),
          ),
          if (userData.userId != PrefData().getUserData().userId) ...[
            RoundedCornerButton(
              height: 32,
              width: 88,
              buttonText: Utils.getChatInvitationText(userData.invideFlag),
              buttonColor: chatStatusBgColor2[userData.invideFlag],
              borderColor: chatStatusBorderColor[userData.invideFlag],
              fontSize: 14,
              radius: 6,
              isIconWidget: false,
              iconAndTextColor: chatStatusTextColor2[userData.invideFlag],
              iconData: null,
              onPressed: () async {
                if (userData.invideFlag == 0) {
                  var result =
                      await DialogUtils.sendInviteDialog(userData.userId);

                  if (result)
                    Get.find<InviteUserToChatController>().reloadPage();
                } else if (userData.invideFlag == 2) {
                  var result = await Get.find<ConnectionStatusController>()
                      .acceptChatInvite(userData.userId);
                  if (result) {
                    Get.find<InviteUserToChatController>().reloadPage();
                  }
                } else if (userData.invideFlag == 3) {
                  Get.toNamed(Routes.chatPage, arguments: [
                    userData.userId,
                    userData.fullName,
                    userData.profileUrl,
                    userData.userChatConnectionId,
                  ]);
                }
              },
            ),
          ]
        ],
      ),
    );
  }
}
