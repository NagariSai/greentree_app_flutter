import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = Get.arguments ?? "";
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: title,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.comingSoon,
            ),
            const SizedBox(height: 46),
            CustomText(
              text:
                  "We are currently working on this page to launch as soon as possible, stay tuned.",
              size: 14,
              color: FF6D7274,
              maxLines: 3,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
