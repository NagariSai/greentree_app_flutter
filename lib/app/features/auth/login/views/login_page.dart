import 'dart:io';

import 'package:fit_beat/app/common_widgets/app_logo_widget.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/common_widgets/error_text.dart';
import 'package:fit_beat/app/common_widgets/social_login_button.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/auth/login/controllers/login_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_text.dart';

class LoginPage extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: 'Sign In',
                        size: 26,
                        fontWeight: FontWeight.w600,
                        color: titleBlackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //open coach login
                        Get.toNamed(Routes.coachLoginPage);
                      },
                      child: Row(
                        children: [
                          CommonContainer(
                            height: 21,
                            width: 21,
                            borderRadius: 21,
                            backgroundColor: FF025074,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          const SizedBox(width: 12),
                          CustomText(
                            text: 'Sign in as a coach',
                            size: 13,
                            fontWeight: FontWeight.w600,
                            color: FF025074,
                          ),
                        ],
                      ),
                    )
                  ],
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

                Center(
                  child: CustomText(
                    text: "Or Sign In With",
                    color: lightGreyColor,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Platform.isIOS) ...[
                      SocialLoginButton(
                          onTap: () =>
                              controller.doLogin(true, socialName: "apple"),
                          imagePath: Assets.appleLogo),
                      SizedBox(
                        width: 32,
                      ),
                    ],
                    SocialLoginButton(
                        onTap: () =>
                            controller.doLogin(true, socialName: "google"),
                        imagePath: Assets.googleLogo),
                    SizedBox(
                      width: 32,
                    ),
                    SocialLoginButton(
                        onTap: () =>
                            controller.doLogin(true, socialName: "facebook"),
                        imagePath: Assets.fbLogo),
                  ],
                ),

                SizedBox(
                  height: 40,
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
                      onTap: () => Get.toNamed(Routes.signup),
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

Widget _buildUserField(LoginController controller) {
  return CustomTextField(
    hintText: "Email Id",
    hintColor: hintColor,
    inputType: TextInputType.text,
    onChanged: (value) {
      controller.addEmailId(value);
    },
  );
}

Widget _buildPasswordField(LoginController controller) {
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

Widget _buildLoginButton(LoginController controller) {
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

    /* MaterialButton(
      onPressed: () {
        if (controller.isValid.value) doLogin(controller);
      },
      color: controller.isValid.value
          ? primaryColor
          : primaryColor.withOpacity(0.36),
      textColor: Colors.white,
      child: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 24,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    ),*/
  );

  /*  FlatButton(
        minWidth: 180,
        height: 50,
        color: controller.isValid.value
            ? yellowColor
            : yellowColor.withOpacity(0.36),
        onPressed: () {
          //   Get.toNamed(Routes.home);   // need to change
          if (controller.isValid.value) doLogin(controller);
        },
        child: CustomText(
          text: 'Log In',
          color: Colors.black,
          size: 18,
          fontWeight: FontWeight.w600,
        ),
      ));*/
}
