import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/chat/controllers/connection_status_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DialogUtils {
  static void referralDialog() {
    Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        contentPadding: const EdgeInsets.only(bottom: 22),
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Icon(
                    Icons.cancel_rounded,
                    color: closeColor,
                    size: 26,
                  ),
                  onTap: () => Get.back(),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Image.asset(
                Assets.referralIcon,
                width: 141,
                height: 144,
              ),
              SizedBox(
                height: 34,
              ),
              CustomText(
                text: "Referral Code info",
                size: 20,
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 9,
              ),
              CustomText(
                text:
                    "By entering the referral code you will earn coins. Those coins you can use for the FitBeat Shop.",
                size: 14,
                textAlign: TextAlign.center,
                color: descriptionColor,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool> logoutDialog() async {
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        contentPadding: const EdgeInsets.only(bottom: 22),
        content: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Logout",
                size: 20,
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 9,
              ),
              CustomText(
                text: "Are you sure you want to logout?",
                size: 14,
                textAlign: TextAlign.center,
                color: descriptionColor,
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: primaryColor,
                    onPressed: () => Get.back(result: true),
                    child: CustomText(
                      text: "Yes, Logout",
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: primaryColor),
                    color: Colors.white,
                    onPressed: () => Get.back(result: false),
                    child: CustomText(
                      text: "Cancel",
                      color: primaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool> customDialog(
      {@required String title,
      @required String description,
      @required String firstButtonTitle,
      @required String secondButtonTitle}) async {
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        contentPadding: const EdgeInsets.only(bottom: 22),
        content: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "$title",
                size: 20,
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 9,
              ),
              CustomText(
                text: "$description",
                size: 14,
                maxLines: 3,
                textAlign: TextAlign.center,
                color: descriptionColor,
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: primaryColor,
                    onPressed: () => Get.back(result: true),
                    child: CustomText(
                      text: "$firstButtonTitle",
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: primaryColor),
                    color: Colors.white,
                    onPressed: () => Get.back(result: false),
                    child: CustomText(
                      text: "$secondButtonTitle",
                      color: primaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool> sendRequestDialog() async {
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        contentPadding: const EdgeInsets.only(bottom: 22),
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Icon(
                    Icons.cancel_rounded,
                    color: closeColor,
                    size: 26,
                  ),
                  onTap: () => Get.back(),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              CommonContainer(
                  height: 52,
                  width: 52,
                  borderRadius: 52,
                  backgroundColor: FF01A44C,
                  decoration: BoxDecoration(
                      border: Border.all(color: FF01A44C),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  )),
              SizedBox(
                height: 34,
              ),
              CustomText(
                text: "Send Request",
                size: 20,
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 9,
              ),
              CustomText(
                text:
                    "Coach have received your request successfully, once slots are available coach will contact you.",
                size: 14,
                textAlign: TextAlign.center,
                color: descriptionColor,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<String> setKCalDialog() async {
    var texval = "";
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: CustomText(
                  text: "Set Kcal Limit",
                  size: 20,
                  color: titleBlackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                inputType: TextInputType.number,
                // ignore: deprecated_member_use
                inputFormatter: [WhitelistingTextInputFormatter.digitsOnly],
                cursorColor: FFC4CACC,
                bgColor: Colors.white,
                onChanged: (value) {
                  texval = value;
                },
                height: 44,
                hintText: "0 Kcal",
                hintColor: FFBEC6C6,
              ),
              SizedBox(
                height: 6,
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.calBMRPage),
                child: CustomText(
                  text: "Calculate BMR",
                  size: 14,
                  color: FF55B5FE,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlineButton(
                    borderSide: BorderSide(color: primaryColor),
                    color: Colors.white,
                    onPressed: () => Get.back(result: ""),
                    child: CustomText(
                      text: "Cancel",
                      color: primaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  FlatButton(
                    color: primaryColor,
                    onPressed: () {
                      Get.back(result: texval);
                    },
                    child: CustomText(
                      text: "Set",
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool> sendInviteDialog(var userProfileId) async {
    var texval = "";
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                inputType: TextInputType.text,
                cursorColor: FFC4CACC,
                bgColor: Colors.white,
                onChanged: (value) {
                  texval = value;
                },
                maxlines: null,
                height: 144,
                hintText: "write your message here...",
                hintColor: FFBEC6C6,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlineButton(
                    borderSide: BorderSide(color: primaryColor),
                    color: Colors.white,
                    onPressed: () => Get.back(result: false),
                    child: CustomText(
                      text: "Cancel",
                      color: primaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  FlatButton(
                    color: primaryColor,
                    onPressed: () async {
                      await Get.find<ConnectionStatusController>()
                          .sendChatInvite(userProfileId, texval)
                          .then((response) {
                        if (response) {
                          Get.back(result: response);
                          Utils.showSucessSnackBar("Invitation sent");
                        }
                      });
                      /*var result = await Get.find<ConnectionStatusController>()
                          .sendChatInvite(userProfileId, texval);

                      if (result) {
                        print("api res");
                        Get.back(result: true, canPop: true);
                      }*/
                    },
                    child: CustomText(
                      text: "Invite",
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool> mediaDialog() async {
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Confirm",
                size: 20,
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 16,
              ),
              CustomText(
                text: "Do you want to send image?",
                size: 14,
                textAlign: TextAlign.center,
                color: descriptionColor,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: primaryColor,
                    onPressed: () => Get.back(result: true),
                    child: CustomText(
                      text: "Yes",
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: primaryColor),
                    color: Colors.white,
                    onPressed: () => Get.back(result: false),
                    child: CustomText(
                      text: "Cancel",
                      color: primaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool> deactiveDialog() async {
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        contentPadding: const EdgeInsets.only(bottom: 22, top: 22),
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Deactivate Account",
                size: 20,
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 9,
              ),
              CustomText(
                text: "Are you sure you want to deactivate Your account?",
                size: 14,
                maxLines: 3,
                textAlign: TextAlign.center,
                color: descriptionColor,
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: catOrangeColor,
                    onPressed: () => Get.back(result: true),
                    child: CustomText(
                      text: "Yes, Deactivate",
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: primaryColor),
                    color: Colors.white,
                    onPressed: () => Get.back(result: false),
                    child: CustomText(
                      text: "Cancel",
                      color: primaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool> deleteAccountDialog() async {
    return await Get.generalDialog(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        contentPadding: const EdgeInsets.only(bottom: 22, top: 22),
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Delete Account",
                size: 20,
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 9,
              ),
              CustomText(
                text: "Are you sure you want to delete Your account?",
                size: 14,
                maxLines: 3,
                textAlign: TextAlign.center,
                color: descriptionColor,
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: catOrangeColor,
                    onPressed: () => Get.back(result: true),
                    child: CustomText(
                      text: "Yes, Delete",
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: primaryColor),
                    color: Colors.white,
                    onPressed: () => Get.back(result: false),
                    child: CustomText(
                      text: "Cancel",
                      color: primaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
