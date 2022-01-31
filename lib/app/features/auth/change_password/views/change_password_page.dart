import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/common_widgets/error_text.dart';
import 'package:fit_beat/app/features/auth/change_password/controllers/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_text.dart';
import '../../../../theme/app_colors.dart';

class ChangePasswordPage extends GetWidget<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: bodybgColor,
        primary: true,
        appBar: CustomAppBar(
          title: "Reset Password",
          positiveText: controller.isResetValid.value ? "Save" : null,
          onPositiveTap: () => controller.doResetPassword(),
        ),
        body: SafeArea(
          child: _buildBody(),
        ),
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
                CustomText(
                  text: 'Old Password',
                  size: 12,
                  fontWeight: FontWeight.w600,
                  color: descriptionColor,
                ),
                SizedBox(
                  height: 8,
                ),
                _buildOldPasswordField(),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.oldPasswordErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                CustomText(
                  text: 'New Password',
                  size: 12,
                  fontWeight: FontWeight.w600,
                  color: descriptionColor,
                ),
                SizedBox(
                  height: 8,
                ),
                _buildPasswordField(),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.passwordErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                CustomText(
                  text: 'Confirm Password',
                  size: 12,
                  fontWeight: FontWeight.w600,
                  color: descriptionColor,
                ),
                SizedBox(
                  height: 8,
                ),
                _buildConfirmPasswordField(),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.confirmPasswordErrorMsg.value,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOldPasswordField() {
    return Obx(() => CustomTextField(
          hintText: "Old Password",
          hintColor: hintColor.withOpacity(0.5),
          inputType: TextInputType.text,
          obscureText: controller.isObscure2Text.value,
          showIcon: true,
          onIconTap: () => controller.toggleOldPassword(),
          onChanged: (value) {
            controller.addOldPassword(value);
          },
        ));
  }

  Widget _buildPasswordField() {
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

  Widget _buildConfirmPasswordField() {
    return Obx(() => CustomTextField(
          hintText: "New Password",
          hintColor: hintColor.withOpacity(0.5),
          inputType: TextInputType.text,
          obscureText: controller.isObscure1Text.value,
          showIcon: true,
          onIconTap: () => controller.toggleConfirmPassword(),
          onChanged: (value) {
            controller.addConfirmPassword(value);
          },
        ));
  }
}
