import 'dart:convert';
//import 'dart:html';

import 'package:dio/dio.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/auth/login_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/provider/dio_client.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/recipe/controller/recipe_controller.dart';
import 'package:fit_beat/app/features/search/controller/search_controller.dart';
import 'package:fit_beat/app/features/user_detail/views/user_detail_page.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (s) => Scaffold(

        appBar:Utils.isAppbarVisible ? AppBar(
            backgroundColor:appbgColor,
            elevation: 0,
            title: Text(
              s.titleName,
              style: TextStyle(
                  fontSize: 22,
                  color: bottombgColor,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  icon: Image.asset(
                    Assets.chat,
                    color: bottombgColor,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () => Get.toNamed(Routes.chatRoomsPage)),
              IconButton(
                  icon: Image.asset(
                    Assets.bell,
                    color: bottombgColor,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.notificationPage);
                  })
            ]):PreferredSize(
          child: Container(),
          preferredSize: Size(0.0, 0.0),
        ),
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
                            onPressed: () {

                            }),
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
        builder: (_) =>

        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/more.png'),
              fit: BoxFit.cover,
            ),
          ),
            child:
            BottomNavigationBar(
              elevation: 0,

              selectedFontSize: 0.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,

              backgroundColor: bottombgColor,

              selectedItemColor: titleBlackColor,
              unselectedItemColor: unSelectedColor,
              currentIndex: _.selectedIndex,
              onTap: (index) {
                if (index == 1) {
                  Utils.isAppbarVisible=false;
                  _.onItemTapped(index);
               //  Get.toNamed(Routes.searchPage);
                }
               /* if (index == 1) {
                  _.onItemTapped(index);
                  Get.find<RecipeController>()?.loadRecipe();
                }*/
                else if (index == 2) {
                  Utils.isAppbarVisible=true;

                  _openAddDialog(context);
                } else if (index == 3) {
                  Utils.isAppbarVisible=true;
                  _.onItemTapped(index);
                  Get.find<RecipeController>()?.loadRecipe();
                } else {
                  Utils.isAppbarVisible=true;
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

                    child: Center(child:Image.asset('assets/images/home.png'))
                    ),
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
                        child: Center(child:Image.asset('assets/images/search.png'))),
                       // child: Center(child: Icon(Icons.search, size: 28))),
                    label: "Search"),
                BottomNavigationBarItem(

                  label: "Add Post",
                  icon: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: unSelectedColor,
                      shape: BoxShape.circle,
                    ),
                 child: Center(child:Image.asset('assets/images/plus_circle.png',))),
                 //   child: Center(child: Icon(Icons.add,size: 24,color: Colors.white,),), ),
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
                   child: Center(child:Image.asset('assets/images/receipe.png'))),
                    //  child: Center(child: Icon(Icons.rice_bowl, size: 28))),
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
                      child: Center(child:Image.asset('assets/images/user.png'))),
                     // child: Center(child: Icon(Icons.menu, size: 28))),
                  label: "Menu",
                ),
              ],
            ))
    );
  }


  /*Container(
  decoration: BoxDecoration(
  image: DecorationImage(image: AssetImage('assets/images/bottombar.png'), fit: BoxFit.fill),
  ),
  child: BottomNavigationBar(
  backgroundColor: bottombgColor,
  type: BottomNavigationBarType.fixed, // new line
  elevation: 0,
  items: [
  BottomNavigationBarItem(icon: Image.asset("assets/images/home.png")),
  BottomNavigationBarItem(icon: Image.asset("assets/images/search.png"),),
  BottomNavigationBarItem(icon: Image.asset("assets/images/plus_circle.png"),),
  BottomNavigationBarItem(icon: Image.asset("assets/images/receipe.png")),
  BottomNavigationBarItem(icon: Image.asset("assets/images/user.png")),

  ],
  ),
  ),*/
  void _openAddDialog(BuildContext context) {
    /// postType 0 => Start a discussion, 1 => Post your challenge, 2 => Post an update,
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          actions: <Widget>[

          CupertinoActionSheetAction(
              child: CustomText(
                text: "Share on instagram",
                size: 17,
                fontWeight: FontWeight.w500,
                color: titleBlackColor,
              ),
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.ssharePage, parameters: {
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
