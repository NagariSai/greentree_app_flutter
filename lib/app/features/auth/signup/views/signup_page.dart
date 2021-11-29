import 'package:country_code_picker/country_code_picker.dart';
import 'package:fit_beat/app/common_widgets/app_logo_widget.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/common_widgets/error_text.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/features/auth/signup/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_text.dart';
import '../../../../theme/app_colors.dart';

class SignUpPage extends GetWidget<SignUpController> {
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
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: primaryColor,
                      size: 28,
                    ),
                    onPressed: () => Get.back()),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: AppLogoWidget(),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomText(
                  text: 'Sign Up',
                  size: 26,
                  fontWeight: FontWeight.w600,
                  color: titleBlackColor,
                ),
                SizedBox(
                  height: 32,
                ),
                _buildUserField(controller),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.usernameErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildEmailField(controller),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.emailErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildPhoneField(controller),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.phoneNoErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildPasswordField(controller),
                Obx(
                  () => ErrorText(
                    errorMessage: controller.passwordErrorMsg.value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildReferralField(controller),
                /* Obx(
                  () => ErrorText(
                    errorMessage: controller.passwordErrorMsg.value,
                  ),
                ),*/
                SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildCreateButton(controller),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: "Already have an account?",
                          color: titleBlackColor,
                          size: 13,
                        ),
                        SizedBox(width: 4),
                        _buildExistingButton(),
                      ],
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

Widget _buildUserField(SignUpController controller) {
  return CustomTextField(
    hintText: "Name",
    hintColor: hintColor,
    inputType: TextInputType.text,
    onChanged: (value) {
      controller.addUsername(value);
    },
  );
}

Widget _buildPhoneField(SignUpController controller) {
  return CustomTextField(
    isPaddingRequired: false,
    prefixIcon: CountryCodePicker(
      showDropDownButton: true,
      padding: const EdgeInsets.only(left: 6),
      onChanged: (c) => controller.addCountryCode(c.dialCode),
      initialSelection: 'IN',
      showCountryOnly: false,
      showFlagDialog: true,
      showFlag: false,
      countryList: Strings.codes,
      favorite: [
        '+46',
      ],
    ),
    hintText: "Mobile number to verify",
    hintColor: hintColor,
    inputType: TextInputType.phone,
    // inputFormatter: [
    //   LengthLimitingTextInputFormatter(10),
    // ],

    onChanged: (value) {
      print("sdadd");
      controller.addPhoneNo(value);
    },
  );
}

Widget _buildEmailField(SignUpController controller) {
  return CustomTextField(
    hintText: "Email",
    hintColor: hintColor,
    inputType: TextInputType.text,
    onChanged: (value) {
      controller.addEmailId(value);
    },
  );
}

Widget _buildPasswordField(SignUpController controller) {
  return Obx(
    () => CustomTextField(
      hintText: "Password",
      hintColor: hintColor,
      inputType: TextInputType.text,
      showIcon: true,
      obscureText: controller.isObscureText.value,
      onChanged: (value) {
        controller.addPassword(value);
      },
      onIconTap: () => controller.toggleShowPassword(),
    ),
  );
}

Widget _buildReferralField(SignUpController controller) {
  return CustomTextField(
    hintText: "Referral code",
    hintColor: hintColor,
    inputType: TextInputType.text,
    showIcon: true,
    endIcon: Icons.info_outline_rounded,
    onIconTap: () => controller.showReferralDialog(),
    onChanged: (value) {},
  );
}

Widget _buildExistingButton() {
  return TextButton(
    onPressed: () => Get.back(),
    child: CustomText(
      text: 'Sign In',
      color: primaryColor,
      size: 14,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget _buildCreateButton(SignUpController controller) {
  return Obx(() => ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 50, height: 50),
        child: ElevatedButton(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            if (controller.isValid.value) controller.doSignUp();
          },
          style: ElevatedButton.styleFrom(
            primary: controller.isValid.value
                ? primaryColor
                : primaryColor.withOpacity(0.36),
            shadowColor: hintColor,
            shape: CircleBorder(),
          ),
        ),
      ));
}
