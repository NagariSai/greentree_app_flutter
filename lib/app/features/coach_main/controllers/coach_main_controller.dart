import 'package:fit_beat/app/constant/api_endpoint.dart';
import 'package:fit_beat/app/data/model/user/user_detail_entity.dart'
    as UserDetailEntity;
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach_home/view/coach_home_screen.dart';
import 'package:fit_beat/app/features/coach_menu/view/coach_menu_page.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachMainController extends GetxController {
  final ApiRepository repository;

  CoachMainController({@required this.repository}) : assert(repository != null);

  Rx<ViewState> status = Rx();

  var userDetailData = Rx(UserDetailEntity.UserDetailData());
  var isSetup = RxInt();

  int _selectedIndex = 0;

  get selectedIndex => this._selectedIndex;

  final List<Widget> pageList = [
    CoachHomeScreen(),
    Container(),
    CoachMenuPage(),
  ];

  final List<String> _titleList = [
    "Home",
    "",
    "Menu",
  ];

  String titleName = "";

  // GlobalKey<ScaffoldState> drawerGlobalKey;

  onItemTapped(int index) {
    this._selectedIndex = index;
    titleName = _titleList[index];
    update();
  }

  @override
  void onInit() {
    super.onInit();

    Get.put(ProgressController());
    var data = PrefData().getUserDetailData();
    if (data == null || data.isSetup == 0) {
      getUser();
    }
    titleName = _titleList[_selectedIndex];
    getCategories();
    getTags();
    getCuisines();
  }

  void setUserDetailData(UserDetailEntity.UserDetailData newUserDetailData) {
    userDetailData.value = newUserDetailData;
    isSetup.value = newUserDetailData.isSetup;
    PrefData().setUserDetailData(userDetailData.value);
    // update();
  }

  Future<void> getUser() async {
    // status.value = ViewState.LOADING;
    try {
      var data = await repository.apiClient.get(
          "http://3.120.65.206:8080/app/v1/getuser",
          headers: {"Authorization": "Bearer ${PrefData().getAuthToken()}"});
      var response = UserDetailEntity.UserDetailEntity.fromMap(data);

      print("response.data : ${response.data}");
      print("Success => $response");

      if (response.status) {
        if (response.data.isSetup == 1) {
          setUserDetailData(response.data);
        } else {
          response.data.isSetup = 1;
          setUserDetailData(response.data);
          Get.toNamed(Routes.USER_DETAIL);
        }
      }

      // status.value = ViewState.SUCCESS;
    } on Exception catch (e) {
      print("Error => $e");
      // status.value = ViewState.ERROR;
    }
  }

  void getTags() async {
    try {
      var response = await repository.getTags();
      if (response.status) {
        // masterTagEntity = response;
        PrefData().saveMasterTags(response);
      }
    } on Exception catch (e) {}
  }

  void getCuisines() async {
    try {
      var response = await repository.getCuisines();
      if (response.status) {
        // masterTagEntity = response;
        PrefData().saveMasterCuisines(response);
      }
    } on Exception catch (e) {}
  }

  void getCategories() async {
    try {
      var response = await repository.getCategories();
      if (response.status) {
        // masterTagEntity = response;
        PrefData().saveMasterCategories(response);
      }
    } on Exception catch (e) {}
  }

  RxString profileUrl = PrefData().getCoachProfileUrl().obs;
}
