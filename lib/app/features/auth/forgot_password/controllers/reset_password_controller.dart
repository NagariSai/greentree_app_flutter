import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/app/utils/validators.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/api_repository.dart';

class ResetPasswordController extends GetxController {
  final ApiRepository repository;

  ResetPasswordController({@required this.repository})
      : assert(repository != null);

  RxString passwordErrorMsg = "".obs;

  final password = "".obs;
  final confirmPassword = "".obs;
  final isResetValid = false.obs;
  final isObscureText = true.obs;

  int userId;
  String passcode;

  @override
  void onInit() {
    super.onInit();
    everAll([password, confirmPassword], (_) {
      passwordErrorMsg.value =
          Validators.isValidPasswords(password.value, confirmPassword.value);

      isResetValid.value = passwordErrorMsg.value == "";
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> doResetPassword() async {
    Utils.dismissKeyboard();

    Utils.showLoadingDialog();

    var response =
        await repository.resetPassword(userId, passcode, password.value);
    Utils.dismissLoadingDialog();

    if (response.status) {
      Get.offAllNamed(Routes.login);
      Utils.showSucessSnackBar(response.message);
    } else {
      Utils.showErrorSnackBar(response.message);
    }
  }

  void addPassword(String value) {
    password.value = value;
  }

  void addConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  void toggleShowPassword() {
    this.isObscureText.value = !isObscureText.value;
  }
}
