import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/user/block_user_model.dart';
import 'package:fit_beat/app/features/blockUnblockUser/controllers/block_unblock_user_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockUserRow extends StatelessWidget {
  String title;
  BlockUser blockUser;
  BlockUserRow({this.blockUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          CircularImage(
            height: 46,
            width: 46,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: blockUser.fullName ?? "",
                  size: 16,
                  fontWeight: FontWeight.w900,
                  color: titleBlackColor,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "${blockUser.totalPost ?? ""} Posts",
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
                      text: "${blockUser.totalFollowers ?? ""} Followers",
                      size: 11,
                      fontWeight: FontWeight.w200,
                      color: FF6D7274,
                    ),
                  ],
                )
              ],
            ),
          ),
          RoundedCornerButton(
            height: 36,
            width: 88,
            buttonText: "Unblock",
            buttonColor: FFFFFFFF,
            borderColor: FF025074,
            fontSize: 14,
            radius: 6,
            isIconWidget: false,
            iconAndTextColor: FF025074,
            iconData: null,
            onPressed: () async {
              var result = await DialogUtils.customDialog(
                  title: "Unblock",
                  description:
                      "Are you sure you want to Unblock \n ${blockUser.fullName}? ",
                  firstButtonTitle: "Yes, Unblock",
                  secondButtonTitle: "Cancel");

              if (result) {
                Get.find<BlockUnBlockController>()
                    .unBlockUser(blockUser.userBlockId);
              }
            },
          )
        ],
      ),
    );
  }
}
