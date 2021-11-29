import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/user/user_follow.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:flutter/material.dart';

class FollowerRow extends StatelessWidget {
  String title;
  UserFollow userFollow;
  dynamic controller;
  FollowerRow({@required this.userFollow, @required this.controller});

  bool isFollwerUser = false;

  @override
  Widget build(BuildContext context) {
    if (userFollow.isFollow == 0) {
      title = "Follow";
      isFollwerUser = false;
    } else {
      title = "Following";
      isFollwerUser = true;
    }

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          CircularImage(
            height: 46,
            width: 46,
            imageUrl: userFollow.profileUrl ?? "",
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: userFollow.fullName ?? "",
                  size: 16,
                  fontWeight: FontWeight.w900,
                  color: titleBlackColor,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "${userFollow.totalPost ?? ""} Posts",
                      size: 11,
                      fontWeight: FontWeight.w200,
                      color: FF6D7274,
                    ),
                    CustomText(
                      text: " | ",
                      size: 11,
                      fontWeight: FontWeight.w200,
                      color: FF6D7274,
                    ),
                    CustomText(
                      text: "${userFollow.totalFollowers ?? ""} Followers",
                      size: 11,
                      fontWeight: FontWeight.w200,
                      color: FF6D7274,
                    ),
                  ],
                )
              ],
            ),
          ),
          if (userFollow.userId != PrefData().getUserData().userId) ...[
            RoundedCornerButton(
              height: 36,
              width: 88,
              buttonText: "$title",
              buttonColor: isFollwerUser ? FF025074 : FFFFFFFF,
              borderColor: isFollwerUser ? FF025074 : FF025074,
              fontSize: 14,
              radius: 6,
              isIconWidget: false,
              iconAndTextColor: isFollwerUser ? Colors.white : FF025074,
              iconData: null,
              onPressed: () async {
                if (!isFollwerUser) {
                  controller.followUser(userFollow.userProfileId);
                } else {
                  var result = await DialogUtils.customDialog(
                      title: "UnFollow",
                      description:
                          "Are you sure you want to UnFollow \n ${userFollow.fullName}? ",
                      firstButtonTitle: "Yes, UnFollow",
                      secondButtonTitle: "Cancel");
                  if (result) {
                    controller.unFollowUser(userFollow.userProfileId);
                  }
                }
              },
            ),
          ]
        ],
      ),
    );
  }
}
