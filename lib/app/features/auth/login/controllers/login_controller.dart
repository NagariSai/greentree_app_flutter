import 'dart:io';

import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/app/utils/validators.dart';
import 'package:fit_beat/services/social_login_service.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/api_repository.dart';

class LoginController extends GetxController {
  final ApiRepository repository;

  LoginController({@required this.repository}) : assert(repository != null);

  RxString emailErrorMsg = "".obs;
  RxString passwordErrorMsg = "".obs;

  final email = "".obs;
  final password = "".obs;
  final isValid = false.obs;
  final isObscureText = true.obs;

  @override
  void onInit() {
    super.onInit();

    everAll([email, password], (_) {
      var emailId = Validators.isValidEmailId(email.value);
      var pass = Validators.isValidPassword(password.value);
      isValid.value = (emailId == "" && pass == "");
    });

    ever(email, (_) {
      emailErrorMsg.value = Validators.isValidEmailId(email.value);
    });
    ever(password, (_) {
      passwordErrorMsg.value = Validators.isValidPassword(password.value);
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  // need to change
  /* Future<User> doLogin() async {
    Utils.showLoadingDialog();
    var countryResponse = await repository.getCountry();
    var countryCode = "IN";
    var ip = "";
    if (countryResponse != null) {
      countryCode = countryResponse.countryCode;
      ip = countryResponse.query;
    }
    var response = await repository.doLogin(email.value, password.value,
        countryCode, ip, Platform.isAndroid ? 1 : 2);
    Utils.dismissLoadingDialog();

    if (response.res) {
      Utils.showSucessSnackBar(response.msg);
      GetStorage().write("authToken", response.authToken);
      GetStorage().write("countryCode", response.countryCode);
      Get.find<AnalyticsService>()
          .analytics
          .logLogin(loginMethod: "Email/Number");
      return response.data;
    } else {
      print("res block");
      Utils.showErrorSnackBar(response.msg ?? "Connection timeout");
      return null;
    }
  }*/

  void addPassword(String value) {
    password.value = value;
  }

  void addEmailId(String value) {
    email.value = value;
  }

  void toggleShowPassword() {
    this.isObscureText.value = !isObscureText.value;
  }

  void doLogin(bool isSocialLogin, {String socialName = "manual"}) async {
    try {
      var deviceType = Platform.isAndroid ? "2" : "1";
      Utils.dismissKeyboard();
      Utils.showLoadingDialog();
      Map<String, dynamic> result = Map();
      if (isSocialLogin) {
        result = await Get.find<SocialLoginService>().doSocialLogin(socialName);

        if (result != null) {
          if (result["error"] != "") {
            Utils.dismissLoadingDialog();
            print("login error block");
            Utils.showErrorSnackBar(result["error"]);
            return;
          }
        } else {
          Utils.dismissLoadingDialog();
          Utils.showErrorSnackBar("Login Cancelled");
          return;
        }
      }

      var response = await repository.doLogin(
        isSocialLogin,
        isSocialLogin ? result["email"] ?? "" : email.value.toLowerCase(),
        password.value,
        deviceType,
        "",
        socialName,
        "",
        isSocialLogin ? result["name"] : "",
        isSocialLogin ? result["id"] : "",
      );
      Utils.dismissLoadingDialog();

      if (response.status) {
        bool isCoach = response.data != null &&
                response.data.roleId != null &&
                response.data.roleId == 2
            ? true
            : false;
        PrefData().setCoach(isCoach);
        PrefData().setUserData(response.data);
        PrefData().setUserLogin(true);
        PrefData().setProfileUrl(response.data.profileUrl);
        PrefData().setAuthToken(response.accessToken);

        PrefData().setGender(response.data.gender);
        PrefData().setDOB(response.data.dateOfBirth);
        PrefData().setHeight(response.data.height);
        PrefData().setWidth(response.data.weight);
        PrefData().setWeightUnit(response.data.weightType);
        PrefData().setHeightUnit(response.data.heightUnit);

        Get.offAllNamed(Routes.main);
        Utils.showSucessSnackBar(response.message);
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (error) {
      Utils.dismissLoadingDialog();
      print("login catch block");
      Utils.showErrorSnackBar(error.toString());
      print(error.toString());
    }
  }
}
