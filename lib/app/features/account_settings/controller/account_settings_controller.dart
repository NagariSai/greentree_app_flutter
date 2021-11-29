import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingController extends GetxController {
  final ApiRepository repository;

  AccountSettingController({@required this.repository})
      : assert(repository != null);

  Future<void> deleteAccount() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.deleteAccount();
      Utils.dismissLoadingDialog();

      if (response.status) {
        Utils.showSucessSnackBar(response.message);
        handleLogout();
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      print("error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }

  Future<void> deactivateAccount() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.deactivateAccount();
      Utils.dismissLoadingDialog();

      if (response.status) {
        Utils.showSucessSnackBar(response.message);
        handleLogout();
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      print("error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }

  void handleLogout() async {
    PrefData().clearData();
    Get.offAllNamed(Routes.login);
  }
}
