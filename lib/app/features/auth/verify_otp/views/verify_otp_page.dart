import 'package:fit_beat/app/common_widgets/custom_submit_buttom.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/features/auth/verify_otp/controllers/verify_otp_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common_widgets/custom_text.dart';
import '../../../../theme/app_colors.dart';

class VerifyOtpPage extends GetWidget<VerifyOtpController> {
  @override
  Widget build(BuildContext context) {
    print("arg ${Get.parameters}");

    controller.userEmailOrNumber.value = Get.parameters["userEmailOrNumber"];
    controller.userId = int.parse(Get.parameters["userId"]);
    controller.isForgotFlow.value =
        Get.parameters["isForgotFlow"].toLowerCase() == "true";
    return Scaffold(
      primary: true,
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
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
                  text: 'OTP Verification',
                  size: 32,
                  fontWeight: FontWeight.w600,
                  color: titleBlackColor,
                ),
                SizedBox(
                  height: 16,
                ),
                Obx(
                  () => RichText(
                    text: TextSpan(
                      text: controller.isForgotFlow.value
                          ? Strings.emailVerify1
                          : Strings.mobileVerify1,
                      style: TextStyle(color: descriptionColor, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: controller.userEmailOrNumber.value,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: controller.isForgotFlow.value
                              ? Strings.emailVerify2
                              : Strings.mobileVerify2,
                          style: TextStyle(
                            color: descriptionColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: Get.width / 2, height: 50),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v.length < 4) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    errorTextSpace: 22,
                    textStyle: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(6),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeColor: fieldBgColor,
                        selectedColor: fieldBgColor,
                        inactiveColor: fieldBgColor,
                        selectedFillColor: fieldBgColor,
                        activeFillColor: fieldBgColor,
                        inactiveFillColor: fieldBgColor),
                    cursorColor: primaryColor,
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.white,
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,

                    onCompleted: (v) {
                      print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      controller.addOtp(value);
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                RichText(
                  text: TextSpan(
                    text: "Didn't receive any OTP? ",
                    style: TextStyle(color: titleBlackColor, fontSize: 13),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Resend OTP",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.doResendOtp();
                              // open desired screen
                            }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
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

  Widget _buildSubmitButton(VerifyOtpController controller) {
    return Obx(() => CustomSubmitButton(
          text: "Verify",
          color: controller.isOtpValid.value
              ? primaryColor
              : primaryColor.withOpacity(0.36),
          onTap: () {
            if (controller.isOtpValid.value) controller.doVerifyOtp();
          },
        ));
  }
}
