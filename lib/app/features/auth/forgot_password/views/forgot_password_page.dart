import 'package:fit_beat/app/common_widgets/custom_submit_buttom.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/common_widgets/error_text.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/features/auth/forgot_password/controllers/forgot_password_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_text.dart';
import '../../../../theme/app_colors.dart';

class ForgotPasswordPage extends GetWidget<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: primaryColor,
                      size: 28,
                    ),
                    onTap: () => Get.back()),
                SizedBox(
                  height: 16,
                ),
                CustomText(
                  text: 'Forgot Password',
                  size: 32,
                  fontWeight: FontWeight.w600,
                  color: titleBlackColor,
                ),
                SizedBox(
                  height: 16,
                ),
                CustomText(
                  text: Strings.forgotDescription,
                  size: 15,
                  fontWeight: FontWeight.w300,
                  color: descriptionColor,
                  overflow: null,
                ),
                SizedBox(
                  height: 32,
                ),
                _buildUserField(controller),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.emailErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: _buildSubmitButton(controller),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget _buildUserField(ForgotPasswordController controller) {
  return CustomTextField(
    hintText: "Email ID",
    hintColor: hintColor,
    inputType: TextInputType.emailAddress,
    onChanged: (value) {
      controller.addEmailId(value);
    },
  );
}

Widget _buildSubmitButton(ForgotPasswordController controller) {
  return Obx(() => CustomSubmitButton(
        color: controller.isForgotValid.value
            ? primaryColor
            : primaryColor.withOpacity(0.36),
        onTap: () {
          if (controller.isForgotValid.value) controller.doForgotPassword();
        },
      ));
}
