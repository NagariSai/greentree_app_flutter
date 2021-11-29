import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/my_profile/controller/profile_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Center(
        child: Column(
          children: [
            Stack(
              children: [
                _.camerasSelectFile != null
                    ? CircularImage(
                        height: 76,
                        width: 76,
                        imageFile: _.camerasSelectFile.path,
                        isImageFile: true,
                      )
                    : CircularImage(
                        height: 76,
                        width: 76,
                        imageUrl: _.userData.userData.profileUrl,
                      ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: InkWell(
                    onTap: () {
                      _.openCamera();
                    },
                    child: CommonContainer(
                        height: 34,
                        width: 34,
                        borderRadius: 34,
                        backgroundColor: FFE0EAEE,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            Assets.ic_camera,
                          ),
                        )),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            CustomText(
              text: "${_.userData?.userData?.fullName ?? ""}",
              size: 20,
              fontWeight: FontWeight.w900,
              color: titleBlackColor,
            ),
            CustomText(
              text: "${_.userData?.userData?.emailAddress ?? ""}",
              size: 13,
              color: FF6D7274,
            )
          ],
        ),
      );
    });
  }
}
