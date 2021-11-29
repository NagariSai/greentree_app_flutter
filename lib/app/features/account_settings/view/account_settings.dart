import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/account_settings/controller/account_settings_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Account Settings",
      ),
      body: GetBuilder<AccountSettingController>(
          init: AccountSettingController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    const SizedBox(height: 50),
                    CustomText(
                      text: "Deactivate Account",
                      size: 16,
                      color: FF050707,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      text:
                          "Deactivating your account will disable your profile and remove your details from content you’ve posted of FitBeat.",
                      size: 14,
                      maxLines: 3,
                      color: FF6D7274,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: () async {
                        var result = await DialogUtils.deactiveDialog();
                        if (result) {
                          _.deactivateAccount();
                        }
                      },
                      child: CustomText(
                        text: "Deactivate your account",
                        size: 14,
                        color: FFFF9B91,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(),
                    const SizedBox(height: 10),
                    CustomText(
                      text: "Delete Account",
                      size: 16,
                      color: FF050707,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      text:
                          "Deleting your account will remove your profile and all your details from FitBeat. After you delete Your account, you can’t sign up gain with the same username and the account cannot be reactivated.",
                      size: 14,
                      maxLines: 3,
                      color: FF6D7274,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: () async {
                        var result = await DialogUtils.deleteAccountDialog();
                        if (result) {
                          _.deleteAccount();
                        }
                      },
                      child: CustomText(
                        text: "Delete your account",
                        size: 14,
                        color: FFFF9B91,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
