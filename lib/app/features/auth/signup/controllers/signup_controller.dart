import 'dart:io';

import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/app/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/api_repository.dart';

class SignUpController extends GetxController {
  final ApiRepository repository;

  SignUpController({@required this.repository}) : assert(repository != null);

  RxString usernameErrorMsg = "".obs;
  RxString passwordErrorMsg = "".obs;
  RxString emailErrorMsg = "".obs;
  RxString phoneNoErrorMsg = "".obs;

  final username = "".obs;
  final password = "".obs;
  final email = "".obs;
  final phoneNo = "".obs;
  final isValid = false.obs;
  final isObscureText = true.obs;
  final referralCode = "".obs;
  String countryCode = "+91";
  @override
  void onInit() {
    everAll([username, password, email, phoneNo], (_) {
      var user = Validators.isValidName(username.value);
      var pass = Validators.isValidPassword(password.value);
      var emailId = Validators.isValidEmailId(email.value);
      var phone = Validators.isValidPhoneNo(phoneNo.value);

      isValid.value =
          (user == "" && pass == "" && emailId == "" && phone == "");
    });

    ever(password, (_) {
      passwordErrorMsg.value = Validators.isValidPassword(password.value);
      // updateIsValid();
    });

    ever(username, (_) {
      usernameErrorMsg.value = Validators.isValidName(username.value);
      // updateIsValid();
    });

    ever(email, (_) {
      emailErrorMsg.value = Validators.isValidEmailId(email.value);
      // updateIsValid();
    });
    ever(phoneNo, (_) {
      phoneNoErrorMsg.value = Validators.isValidPhoneNo(phoneNo.value);
      // updateIsValid();
    });

    /* everAll([usernameErrorMsg,emailErrorMsg,passwordErrorMsg,phoneNoErrorMsg], (_) {

    });*/
    /* everAll([usernameErrorMsg, usernameErrorMsg], (_) {
      updateIsValid();
    });*/
    /*ever(password, (_) {
      passwordErrorMsg.value = Validators.isValidPassword(password.value);
//      updateIsValid();
    });

    ever(usernameErrorMsg, (_) {
      updateIsValid();
    });
    ever(passwordErrorMsg, (_) {
      updateIsValid();
    });*/
  }

  void updateIsValid() {
    isValid.value = (usernameErrorMsg.value == "" &&
        passwordErrorMsg.value == "" &&
        emailErrorMsg.value == "" &&
        phoneNoErrorMsg.value == "");
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  // need to change
  Future<void> doSignUp() async {
    Utils.showLoadingDialog();

    try {
      var deviceType = Platform.isAndroid ? "2" : "1";
      var response = await repository.doSignUp(
          false,
          email.value,
          password.value,
          username.value,
          phoneNo.value,
          referralCode.value,
          deviceType,
          "",
          "manual",
          "",
          countryCode);

      Utils.dismissKeyboard();
      Utils.dismissLoadingDialog();

      if (response.status) {
        Get.offAndToNamed(Routes.verifyOtp, parameters: {
          "userEmailOrNumber": "$countryCode ${phoneNo.value}",
          "userId": response.data.userId.toString(),
          "isForgotFlow": "false"
        });

        Utils.showSucessSnackBar(response.message);
      } else {
        Utils.dismissKeyboard();
        Utils.showErrorSnackBar(response.message);
      }
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(error.toString());
    }
  }

  void addPassword(String value) {
    password.value = value;
  }

  void addReferral(String value) {
    referralCode.value = value;
  }

  void addUsername(String value) {
    username.value = value;
  }

  void addPhoneNo(String value) {
    phoneNo.value = value;
  }

  void addEmailId(String value) {
    email.value = value;
  }

  void toggleShowPassword() {
    this.isObscureText.value = !isObscureText.value;
  }

  void showReferralDialog() {
    DialogUtils.referralDialog();
  }

  void addCountryCode(String value) {
    countryCode = value;
  }
}
