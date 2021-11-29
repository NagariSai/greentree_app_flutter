import 'package:fit_beat/app/common_widgets/custom_submit_buttom.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/common_widgets/error_text.dart';
import 'package:fit_beat/app/features/auth/forgot_password/controllers/reset_password_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_text.dart';
import '../../../../theme/app_colors.dart';

class ResetPasswordPage extends GetWidget<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    controller.userId = int.parse(Get.parameters["userId"]);
    controller.passcode = Get.parameters["otp"];
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
                  text: 'Create Password',
                  size: 32,
                  fontWeight: FontWeight.w600,
                  color: titleBlackColor,
                ),
                SizedBox(
                  height: 80,
                ),
                _buildPasswordField(controller),
                SizedBox(
                  height: 16,
                ),
                _buildConfirmPasswordField(controller),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.passwordErrorMsg.value,
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

  Widget _buildPasswordField(ResetPasswordController controller) {
    return Obx(() => CustomTextField(
          hintText: "New Password",
          hintColor: hintColor.withOpacity(0.5),
          inputType: TextInputType.text,
          obscureText: controller.isObscureText.value,
          showIcon: true,
          onIconTap: () => controller.toggleShowPassword(),
          onChanged: (value) {
            controller.addPassword(value);
          },
        ));
  }

  Widget _buildConfirmPasswordField(ResetPasswordController controller) {
    return Obx(() => CustomTextField(
          hintText: "New Password",
          hintColor: hintColor.withOpacity(0.5),
          inputType: TextInputType.text,
          obscureText: controller.isObscureText.value,
          showIcon: true,
          onIconTap: () => controller.toggleShowPassword(),
          onChanged: (value) {
            controller.addConfirmPassword(value);
          },
        ));
  }

  Widget _buildSubmitButton(ResetPasswordController controller) {
    return Obx(
      () => CustomSubmitButton(
        color: controller.isResetValid.value
            ? primaryColor
            : primaryColor.withOpacity(0.36),
        onTap: () {
          if (controller.isResetValid.value) controller.doResetPassword();
        },
      ),
    );
  }
}
