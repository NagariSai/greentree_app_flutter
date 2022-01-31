import 'package:dotted_border/dotted_border.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ReferEarn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: "Refer & Earn",
      ),
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RoundedCornerButton(
          height: 50,
          width: Get.width - 32,
          buttonText: "Refer Now",
          buttonColor: FF025074,
          borderColor: FF025074,
          fontSize: 14,
          radius: 12,
          isIconWidget: false,
          iconAndTextColor: Colors.white,
          iconData: null,
          onPressed: () {},
        ),
      ),*/
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Column(
            children: [
              Divider(),
              const SizedBox(height: 60),
              Image.asset(
                Assets.referEarn,
                height: 144,
                width: 144,
              ),
              const SizedBox(height: 34),
              CustomText(
                text: "Invite your friend",
                size: 14,
                fontWeight: FontWeight.w600,
                color: FF050707,
              ),
              const SizedBox(height: 60),
              CustomText(
                text: "Your friend Sign up",
                size: 14,
                fontWeight: FontWeight.w600,
                color: FF050707,
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomText(
                  text: "You & your friend both get 50 FitBeat Coins",
                  size: 14,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  color: FF050707,
                ),
              ),
              const SizedBox(height: 30),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                color: FF6BD295,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 38,
                    child: Row(
                      children: [
                        CustomText(
                          text: "SWAL58EP",
                          size: 14,
                          fontWeight: FontWeight.w600,
                          color: FF6BD295,
                        ),
                        Spacer(),
                        CustomText(
                          text: "Copy",
                          size: 12,
                          fontWeight: FontWeight.w600,
                          color: FF55B5FE,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
