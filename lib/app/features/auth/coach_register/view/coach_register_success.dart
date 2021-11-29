import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/auth/coach_register/controller/coach_register_success_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachRegisterSuccessPage extends StatelessWidget {
  String message;
  CoachRegisterSuccessPage({this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressClick: () {
          Get.back();
        },
      ),
      body: GetBuilder<CoachRegisterSuccessController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 56),
              child: Image.asset(
                Assets.coach_success,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: CustomText(
                text: "$message",
                color: FF050707,
                size: 14,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      }),
    );
  }
}
