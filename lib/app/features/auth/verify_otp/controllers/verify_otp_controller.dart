import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/app/utils/validators.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/api_repository.dart';

class VerifyOtpController extends GetxController {
  final ApiRepository repository;

  VerifyOtpController({@required this.repository}) : assert(repository != null);

  RxString usernameErrorMsg = "".obs;
  RxString passwordErrorMsg = "".obs;
  RxString emailErrorMsg = "".obs;
  RxString phoneNoErrorMsg = "".obs;
  RxString passCodeErrorMsg = "".obs;

  final otp = "".obs;
  final isOtpValid = false.obs;
  final isResetValid = false.obs;
  final isObscureText = true.obs;
  final isForgotFlow = false.obs;
  final userEmailOrNumber = "".obs;
  int userId;

  @override
  void onInit() {
    super.onInit();
    ever(otp, (_) {
      emailErrorMsg.value = Validators.isValidOtp(otp.value);
      isOtpValid.value = emailErrorMsg.value == "";
    });
  }

  @override
  void onReady() {
    super.onReady();

    doResendOtp();
  }

  Future<void> doVerifyOtp() async {
    Utils.dismissKeyboard();

    Utils.showLoadingDialog();

    var response = await repository.doVerifyOtp(userId, otp.value);
    Utils.dismissLoadingDialog();

    if (response.status) {
      if (isForgotFlow.value) {
        Get.offAndToNamed(Routes.resetPassword,
            parameters: {"userId": userId.toString(), "otp": otp.value});
      } else {
        Get.offAllNamed(Routes.login);
      }
      Utils.showSucessSnackBar(response.message);
    } else {
      Utils.showErrorSnackBar(response.message);
    }
  }

  Future<void> doResendOtp() async {
    Utils.dismissKeyboard();

    Utils.showLoadingDialog();

    var response = await repository.doResendOtp(
      userId,
    );
    Utils.dismissLoadingDialog();

    if (response.status) {
      // Utils.showSucessSnackBar(response.data);
    } else {
      Utils.showErrorSnackBar(response.message);
    }
  }

  void addOtp(String value) {
    otp.value = value;
  }
}
