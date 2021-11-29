import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/app/utils/validators.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/api_repository.dart';

class ForgotPasswordController extends GetxController {
  final ApiRepository repository;

  ForgotPasswordController({@required this.repository})
      : assert(repository != null);

  RxString usernameErrorMsg = "".obs;
  RxString passwordErrorMsg = "".obs;
  RxString emailErrorMsg = "".obs;
  RxString phoneNoErrorMsg = "".obs;
  RxString passCodeErrorMsg = "".obs;

  final username = "".obs;
  final password = "".obs;
  final confirmPassword = "".obs;
  final email = "".obs;
  final phoneNo = "".obs;
  final passCode = "".obs;
  final isForgotValid = false.obs;
  final isResetValid = false.obs;
  final isObscureText = true.obs;

  int userId;

  @override
  void onInit() {
    ever(email, (_) {
      emailErrorMsg.value = Validators.isValidEmailId(email.value);
      isForgotValid.value = emailErrorMsg.value == "";
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  // need to change
  Future<void> doForgotPassword() async {
    Utils.dismissKeyboard();

    Utils.showLoadingDialog();

    var response = await repository.doForgotPassword(email.value);
    Utils.dismissLoadingDialog();

    if (response.status) {
      userId = response.data.userId;
      Get.toNamed(Routes.verifyOtp, parameters: {
        "userEmailOrNumber": email.value,
        "userId": userId.toString(),
        "isForgotFlow": "true"
      });
      // Utils.showSucessSnackBar(response.message);
      Utils.showSucessSnackBar(response.data.passcode); // need to remove later

    } else {
      Utils.showErrorSnackBar(response.message);
    }
  }

  /*Future<void> doResetPassword() async {
    Utils.dismissKeyboard();

    Utils.showLoadingDialog();

    var response = await repository.doResetPassword(
        userId, passCode.value, password.value);
    Utils.dismissLoadingDialog();

    if (response.res) {
      Get.toNamed(Routes.resetPasswordSuccess);
      Utils.showSucessSnackBar(response.msg);
    } else {
      Utils.showErrorSnackBar(response.msg);
    }
  }*/

  void addEmailId(String value) {
    email.value = value;
  }
}
