import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/api_endpoint.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/menu/controllers/menu_controller.dart';
import 'package:fit_beat/app/features/menu/views/category_widget.dart';
import 'package:fit_beat/app/features/menu/views/menu_other_tile.dart';
import 'package:fit_beat/app/features/menu/views/settings_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = PrefData().getUserData();
    return Scaffold(
        backgroundColor: bodybgColor,
        body: GetBuilder<MenuController>(
      init: MenuController(repository: ApiRepository(apiClient: ApiClient())),
      builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.myProfile);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 8, top: 8),
                child: Row(
                  children: [
                    Obx(
                      () => CircularImage(
                        imageUrl: Get.find<MainController>().profileUrl.value,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "${data.fullName ?? ""}",
                          color: titleBlackColor,
                          size: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        CustomText(
                          text: "Profile details",
                          color: descriptionColor,
                          size: 11,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.4,
              color: otherDividerColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _.menuCategoryList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            /*maxCrossAxisExtent: 160,*/
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18),
                        itemBuilder: (context, position) {
                          return InkWell(
                            onTap: () {
                              if (position == 0) {
                                Get.toNamed(Routes.bookmarkPage);
                              } else if (position == 1) {
                                Get.toNamed(Routes.comingSoonPage,
                                    arguments: "Fitshop");
                              } else if (position == 2) {
                                Get.toNamed(Routes.comingSoonPage,
                                    arguments: "Fitcoins");
                              } else if (position == 3) {
                                Get.toNamed(Routes.progressTrackPage);
                              } else if (position == 4) {
                                Get.toNamed(Routes.calBMRPage);
                              } else if (position == 5) {
                                Get.toNamed(Routes.kKalPage);
                              } else if (position == 6) {
                                Get.toNamed(Routes.calBodyFatPage);
                              } else if (position == 7) {
                                Get.toNamed(Routes.waterReminderPage);
                              }
                            },
                            child: CategoryWidget(
                              data: _.menuCategoryList[position],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    SettingsWidget(),
                    SizedBox(
                      height: 12,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          var data = _.menuOtherList[position];
                          return InkWell(
                            onTap: () {
                              _handleRedirection(
                                  _.menuOtherList[position].title, _);
                            },
                            child: MenuOtherTile(
                              title: data.title,
                              iconPath: data.icon,
                            ),
                          );
                        },
                        separatorBuilder: (context, position) {
                          return SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: _.menuOtherList.length),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      text: "App version ${_.versionName}",
                      color: FF6D7274,
                      size: 13,
                    )
                  ],
                ),
              ),
            ),
          ]),
    ));
  }

  void _handleRedirection(String title, MenuController menuController) {
    print("${title.toLowerCase()}");
    if (title.toLowerCase().contains("logout")) {
      menuController.handleLogout();
    } else if (title.toLowerCase().contains("community")) {
      print("community");
      Get.toNamed(Routes.communityPage);
    } else if (title.toLowerCase().contains("privacy")) {
      Get.toNamed(Routes.commonWebPage,
          arguments: ["Privacy Policy", ApiEndpoint.privacyApi]);
    } else if (title.toLowerCase().contains("terms")) {
      Get.toNamed(Routes.commonWebPage,
          arguments: ["Terms & Conditions", ApiEndpoint.termsApi]);
    } else if (title.toLowerCase().contains("refer")) {
      print("refer");
      Get.toNamed(Routes.referEarn);
    } else if (title.toLowerCase().contains("help")) {
      Get.toNamed(Routes.supportPage);
    }
  }
}
