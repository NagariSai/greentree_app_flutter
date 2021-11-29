import 'package:fit_beat/app/common_widgets/app_logo_widget.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/common_widgets/error_text.dart';
import 'package:fit_beat/app/features/auth/coach_login/controllers/coach_login_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_text.dart';

class CoachLoginPage extends GetWidget<CoachLoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      primary: true,
      appBar: CustomAppBar(),
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
                SizedBox(
                  height: 48,
                ),

                Center(
                  child: AppLogoWidget(),
                ),

//                AppNameWidget(),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CustomText(
                    text: 'Sign In as a coach',
                    size: 26,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    color: titleBlackColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _buildUserField(controller),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.emailErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildPasswordField(controller),
                Obx(() => ErrorText(
                      errorMessage: controller.passwordErrorMsg.value,
                    )),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildForgotButton(),
                    _buildLoginButton(controller),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Don't have an account?",
                      size: 13,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.coachRegisterPage),
                      child: CustomText(
                        text: "Sign Up",
                        size: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget _buildUserField(CoachLoginController controller) {
  return CustomTextField(
    hintText: "Email Id",
    hintColor: hintColor,
    inputType: TextInputType.text,
    onChanged: (value) {
      controller.addEmailId(value);
    },
  );
}

Widget _buildPasswordField(CoachLoginController controller) {
  return Obx(() => CustomTextField(
        hintText: "Password",
        hintColor: hintColor,
        inputType: TextInputType.text,
        obscureText: controller.isObscureText.value,
        showIcon: true,
        onChanged: (value) {
          controller.addPassword(value);
        },
        onIconTap: () => controller.toggleShowPassword(),
      ));
}

Widget _buildForgotButton() {
  return TextButton(
    onPressed: () => Get.toNamed(Routes.forgotPassword),
    child: CustomText(
      text: 'Forgot password?',
      color: primaryColor,
      size: 14,
      fontWeight: FontWeight.w300,
    ),
  );
}

Widget _buildLoginButton(CoachLoginController controller) {
  return Obx(
    () => ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 50, height: 50),
      child: ElevatedButton(
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 24,
        ),
        onPressed: () {
          if (controller.isValid.value) controller.doLogin(false);
        },
        style: ElevatedButton.styleFrom(
          primary: controller.isValid.value
              ? primaryColor
              : primaryColor.withOpacity(0.36),
          shadowColor: hintColor,
          shape: CircleBorder(),
        ),
      ),
    ),
  );
}
