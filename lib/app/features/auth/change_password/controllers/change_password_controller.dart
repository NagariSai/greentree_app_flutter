import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/app/utils/validators.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/api_repository.dart';

class ChangePasswordController extends GetxController {
  final ApiRepository repository;

  ChangePasswordController({@required this.repository})
      : assert(repository != null);

  RxString passwordErrorMsg = "".obs;
  RxString confirmPasswordErrorMsg = "".obs;
  RxString oldPasswordErrorMsg = "".obs;

  final password = "".obs;
  final confirmPassword = "".obs;
  final oldPassword = "".obs;
  final isResetValid = false.obs;
  final isObscureText = true.obs;
  final isObscure1Text = true.obs;
  final isObscure2Text = true.obs;

  int userId;
  String passcode;

  @override
  void onInit() {
    super.onInit();
    everAll([password, confirmPassword, oldPassword], (_) {
      if (password.value.isNotEmpty) {
        passwordErrorMsg.value = Validators.isValidPassword(password.value);
      }

      if (confirmPassword.value.isNotEmpty) {
        confirmPasswordErrorMsg.value =
            Validators.isSamePasswords(password.value, confirmPassword.value);
      }
      if (oldPassword.value.isNotEmpty) {
        oldPasswordErrorMsg.value =
            Validators.isValidPassword(oldPassword.value);
      }

      isResetValid.value = passwordErrorMsg.value == "" &&
          confirmPasswordErrorMsg.value == "" &&
          oldPasswordErrorMsg.value == "";
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
        await repository.changePassword(oldPassword.value, password.value);
    Utils.dismissLoadingDialog();

    if (response.status) {
      PrefData().clearData();
      Get.offAllNamed(Routes.login);
      Utils.showSucessSnackBar(response.message);
    } else {
      Utils.showErrorSnackBar(response.message);
    }
  }

  void addPassword(String value) {
    password.value = value;
  }

  void addOldPassword(String value) {
    oldPassword.value = value;
  }

  void addConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  void toggleShowPassword() {
    this.isObscureText.value = !isObscureText.value;
  }

  void toggleConfirmPassword() {
    this.isObscure1Text.value = !isObscure1Text.value;
  }

  void toggleOldPassword() {
    this.isObscure2Text.value = !isObscure2Text.value;
  }
}
