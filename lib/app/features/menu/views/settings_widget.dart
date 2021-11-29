import 'package:fit_beat/app/common_widgets/custom_expansion_tile.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/menu/controllers/menu_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsWidget extends StatelessWidget {
  var _controller = Get.find<MenuController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.08),
            blurRadius: 16,
            offset: Offset(
              0,
              2.0,
            ),
          ),
        ],
      ),
      child: ConfigurableExpansionTile(
        topBorderOn: false,
        animatedWidgetFollowingHeader: Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: RotatedBox(
            quarterTurns: 45,
            child: Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
              size: 22,
            ),
          ),
        ),
        header: SettingTile(),
        headerExpanded: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingTile(),
            SizedBox(
              height: 4,
            ),
            Divider(
              color: otherDividerColor,
              thickness: 0.4,
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
        children: List.generate(
            _controller.settingChildList.length,
            (index) => InkWell(
                  onTap: () {
                    if (_controller.settingChildList[index].title
                        .contains("Reset")) {
                      Get.toNamed(Routes.changePasswordPage);
                    } else if (_controller.settingChildList[index].title
                        .contains("Blocked")) {
                      Get.toNamed(Routes.blockUserListPage);
                    } else if (_controller.settingChildList[index].title
                        .contains("Pending")) {
                      Get.toNamed(Routes.chatRequestPage);
                    } else if (_controller.settingChildList[index].title
                        .contains("Account")) {
                      Get.toNamed(Routes.accountSettingPage);
                    }
                  },
                  child: SettingChildTile(
                    title: _controller.settingChildList[index].title,
                    iconPath: _controller.settingChildList[index].icon,
                  ),
                )),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: settingBgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Image.asset(
                Assets.settingsIcon,
                width: 18,
                height: 18,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CustomText(
            text: "Settings",
            color: titleBlackColor,
            size: 15,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class SettingChildTile extends StatelessWidget {
  final String title;
  final String iconPath;

  const SettingChildTile({Key key, this.title, this.iconPath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      decoration: BoxDecoration(
        color: settingBgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            iconPath,
            width: 15,
            height: 18,
          ),
          SizedBox(
            width: 13,
          ),
          Expanded(
            child: CustomText(
              text: title,
              color: descriptionColor,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
