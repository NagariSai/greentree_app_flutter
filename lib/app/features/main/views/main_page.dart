import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/recipe/controller/recipe_controller.dart';
import 'package:fit_beat/app/features/search/controller/search_controller.dart';
import 'package:fit_beat/app/features/user_detail/views/user_detail_page.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (s) => Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              s.titleName,
              style: TextStyle(
                  fontSize: 28,
                  color: titleBlackColor,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  icon: Image.asset(
                    Assets.chat,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () => Get.toNamed(Routes.chatRoomsPage)),
              IconButton(
                  icon: Image.asset(
                    Assets.bell,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.notificationPage);
                  })
            ]),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: IndexedStack(
          index: s.selectedIndex,
          children: s.pageList,
        ),
      ),
    );

    /*Obx(() => s.status.value == ViewState.SUCCESS
            ? responseHandler(s)
            : Container(
                color: Colors.white,
              )));*/
  }

  Widget responseHandler(MainController s) {
    return Obx(() =>
        (s.userDetailData.value != null && s.userDetailData.value.isSetup != 0)
            ? GetBuilder<MainController>(
                builder: (s) => Scaffold(
                  appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      title: Text(
                        s.titleName,
                        style: TextStyle(
                            fontSize: 28,
                            color: titleBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        IconButton(
                            icon: Image.asset(
                              Assets.chat,
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Image.asset(
                              Assets.bell,
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {})
                      ]),
                  bottomNavigationBar: CustomBottomNavigationBar(),
                  body: IndexedStack(
                    index: s.selectedIndex,
                    children: s.pageList,
                  ),
                ),
              )
            : UserDetailPage());
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        builder: (_) => BottomNavigationBar(
              selectedFontSize: 0.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: primaryColor,
              unselectedItemColor: unSelectedColor,
              currentIndex: _.selectedIndex,
              onTap: (index) {
                if (index == 1) {
                 // _.onItemTapped(index);
                 Get.toNamed(Routes.searchPage);
                }
               /* if (index == 1) {
                  _.onItemTapped(index);
                  Get.find<RecipeController>()?.loadRecipe();
                }*/
                else if (index == 2) {
                  _openAddDialog(context);
                } else if (index == 3) {
                  _.onItemTapped(index);
                  Get.find<RecipeController>()?.loadRecipe();
                } else {
                  Get.find<HomeController>().scrollController.jumpTo(0);
                  _.onItemTapped(index);
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: Container(
                        height: 48,
                        width: 48,
                        decoration: _.selectedIndex == 0
                            ? BoxDecoration(
                                color: blue[50],
                                shape: BoxShape.circle,
                              )
                            : null,
                        child: Center(child: Icon(Icons.home, size: 28))),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Container(
                        height: 48,
                        width: 48,
                        decoration: _.selectedIndex == 1
                            ? BoxDecoration(
                                color: blue[50],
                                shape: BoxShape.circle,
                              )
                            : null,
                        child: Center(child: Icon(Icons.search, size: 28))),
                    label: "Search"),
                BottomNavigationBarItem(
                  label: "Add Post",
                  icon: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: unSelectedColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      height: 48,
                      width: 48,
                      decoration: _.selectedIndex == 3
                          ? BoxDecoration(
                              color: blue[50],
                              shape: BoxShape.circle,
                            )
                          : null,
                      child: Center(child: Icon(Icons.rice_bowl, size: 28))),
                  label: "Recipe",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      height: 48,
                      width: 48,
                      decoration: _.selectedIndex == 4
                          ? BoxDecoration(
                              color: blue[50],
                              shape: BoxShape.circle,
                            )
                          : null,
                      child: Center(child: Icon(Icons.menu, size: 28))),
                  label: "Menu",
                ),
              ],
            ));
  }

  void _openAddDialog(BuildContext context) {
    /// postType 0 => Start a discussion, 1 => Post your challenge, 2 => Post an update,
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: CustomText(
                text: "Start a discussion",
                size: 17,
                fontWeight: FontWeight.w500,
                color: titleBlackColor,
              ),
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.addPost, parameters: {
                  "postType": "0",
                  "title": "",
                  "isOtherType": "",
                  "masterPostId": "0"
                });
                // Navigator.pop(context, 'discussion');
              },
            ),
            CupertinoActionSheetAction(
              child: CustomText(
                text: "Post your challenge",
                size: 17,
                fontWeight: FontWeight.w500,
                color: titleBlackColor,
              ),
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.addPost, parameters: {
                  "postType": "1",
                  "title": "",
                  "isOtherType": "",
                  "masterPostId": "0"
                });
              },
            ),
            CupertinoActionSheetAction(
              child: CustomText(
                text: "Post an update",
                size: 17,
                fontWeight: FontWeight.w500,
                color: titleBlackColor,
              ),
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.addPost, parameters: {
                  "postType": "2",
                  "title": "",
                  "isOtherType": "",
                  "masterPostId": "0"
                });
              },
            ),
            CupertinoActionSheetAction(
              child: CustomText(
                text: "Post your transformation",
                size: 17,
                fontWeight: FontWeight.w500,
                color: titleBlackColor,
              ),
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.addTransformationPost, arguments: null);
              },
            ),
            CupertinoActionSheetAction(
              child: CustomText(
                text: "Add a recipe",
                size: 17,
                fontWeight: FontWeight.w500,
                color: titleBlackColor,
              ),
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.ADD_RECIPE);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: CustomText(
              text: "Cancel",
              size: 17,
              fontWeight: FontWeight.w500,
              color: cancelTextColor,
            ),
            isDefaultAction: false,
            onPressed: () {
              Get.back();
            },
          )),
    );
  }
}
