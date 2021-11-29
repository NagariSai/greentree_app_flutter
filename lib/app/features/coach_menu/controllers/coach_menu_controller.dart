import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/menu/category_fourthlet.dart';
import 'package:fit_beat/app/data/model/menu/duplet.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/social_login_service.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CoachMenuController extends GetxController {
  final ApiRepository repository;

  CoachMenuController({@required this.repository}) : assert(repository != null);

  List<CategoryFourthlet> menuCategoryList;
  List<Duplet> menuOtherList;
  List<Duplet> settingChildList;
  PackageInfo packageInfo;
  String versionName;

  @override
  void onInit() {
    super.onInit();
    menuCategoryList = List();
    menuOtherList = List();
    settingChildList = List();
    setMenuCatData();
    setMenuOtherData();
    setSettingChildData();
    getBuildVersion();
  }

  getBuildVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo?.version ?? "";
  }

  void setMenuCatData() {
    menuCategoryList.add(CategoryFourthlet(
        title: "Bookmarks",
        bgColor: catGreenColor,
        icon: Assets.bookmarkIcon,
        shadowColor: catGreenColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "Fitshop",
        bgColor: catOrangeColor,
        icon: Assets.fitShopIcon,
        shadowColor: catOrangeColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "Fitcoins",
        bgColor: catVioletColor,
        icon: Assets.fitCoinIcon,
        shadowColor: catVioletColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "Prog.Track",
        bgColor: catYellowColor,
        icon: Assets.progressTrackerIcon,
        shadowColor: catYellowColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "BMR Calc.",
        bgColor: catPinkColor,
        icon: Assets.bmrIcon,
        shadowColor: catPinkColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "Kcal Calc.",
        bgColor: catDarkGreenColor,
        icon: Assets.caloriesIcon,
        shadowColor: catDarkGreenColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "Body Fat",
        bgColor: catlightPinkColor,
        icon: Assets.fatIcon,
        shadowColor: catlightPinkColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "Water Rem.",
        bgColor: catBlueColor,
        icon: Assets.waterIcon,
        shadowColor: catBlueColor.withOpacity(0.4)));
    menuCategoryList.add(CategoryFourthlet(
        title: "Payments",
        bgColor: FFF2C86B,
        icon: Assets.waterIcon,
        shadowColor: catBlueColor.withOpacity(0.4)));
  }

  void setMenuOtherData() {
    menuOtherList.add(Duplet(
      title: "Help & Support",
      icon: Assets.supportIcon,
    ));
    menuOtherList.add(Duplet(
      title: "Terms & Conditions",
      icon: Assets.termsIcon,
    ));
    menuOtherList.add(Duplet(
      title: "Privacy Policy",
      icon: Assets.privacyPolicyIcon,
    ));
    menuOtherList.add(Duplet(
      title: "Community Guideline",
      icon: Assets.communityIcon,
    ));
    menuOtherList.add(Duplet(
      title: "Refer & Earn",
      icon: Assets.referIcon,
    ));
    menuOtherList.add(Duplet(
      title: "Logout",
      icon: Assets.logoutIcon,
    ));
  }

  void setSettingChildData() {
    settingChildList.add(Duplet(
      title: "Reset Password",
      icon: Assets.resetPasswordIcon,
    ));
    settingChildList.add(Duplet(
      title: "Privacy",
      icon: Assets.privacyIcon,
    ));
    settingChildList.add(Duplet(
      title: "Account Settings",
      icon: Assets.accountIcon,
    ));
    settingChildList.add(Duplet(
      title: "Push Notifications",
      icon: Assets.bell,
    ));

    settingChildList.add(Duplet(
      title: "Location Access",
      icon: Assets.locationIcon,
    ));

    settingChildList.add(Duplet(
      title: "Blocked Users",
      icon: Assets.blockedUserIcon,
    ));

    settingChildList.add(Duplet(
      title: "Pending Requests",
      icon: Assets.pendingRequestIcon,
    ));
  }

  void handleLogout() async {
    try {
      var result = await DialogUtils.logoutDialog();
      if (result) {
        Utils.showLoadingDialog();
        var data = PrefData().getUserData();
        if (data != null) {
          var loginType = data.loginType.toLowerCase();
          if (loginType != "manual") {
            var response =
                await Get.find<SocialLoginService>().handleLogout(loginType);
          }
        }

        var logoutResponse = await repository.doLogout();

        Utils.dismissLoadingDialog();
        if (logoutResponse.status) {
          PrefData().clearData();
          Get.offAllNamed(Routes.login);
          Utils.showSucessSnackBar(logoutResponse.message);
        } else {
          Utils.showErrorSnackBar("Unable to logout");
        }
      }
    } catch (_) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar("${_.toString()}");
    }
  }
}
