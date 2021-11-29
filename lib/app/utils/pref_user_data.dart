import 'package:fit_beat/app/data/model/auth/login_response.dart'
    as LoginResponse;
import 'package:fit_beat/app/data/model/master/master_category_entity.dart';
import 'package:fit_beat/app/data/model/master/master_cuisine_entity.dart';
import 'package:fit_beat/app/data/model/master/master_tag_entity.dart';
import 'package:fit_beat/app/data/model/user/user_detail_entity.dart'
    as UserDetailEntity;
import 'package:get_storage/get_storage.dart';

class PrefData {
  static final PrefData _singleton = PrefData._internal();

  factory PrefData() {
    return _singleton;
  }

  var userDetailDataListener;

  PrefData._internal();

  bool isLogin = false;

  bool isUserLoginIn() {
    return GetStorage().read("isUserLogin") ?? false;
  }

  LoginResponse.UserData getUserData() {
    var user = GetStorage().read("userData");
    return user != null ? LoginResponse.UserData.fromJson(user) : null;
  }

  void setUserData(LoginResponse.UserData userData) async {
    await GetStorage().write("userData", userData.toJson());
  }

  void setUserLogin(bool isLogin) async {
    await GetStorage().write("isUserLogin", isLogin);
  }

  void setAuthToken(String accessToken) {
    GetStorage().write("accessToken", accessToken);
  }

  String getAuthToken() {
    return GetStorage().read("accessToken");
  }

  setCoach(bool isCoach) {
    GetStorage().write("isCoach", isCoach);
  }

  isCoach() {
    return GetStorage().read("isCoach") != null
        ? GetStorage().read("isCoach")
        : false;
  }

  UserDetailEntity.UserDetailData getUserDetailData() {
    var user = GetStorage().read("userDetailData") ?? null;
    return user != null ? UserDetailEntity.UserDetailData.fromMap(user) : null;
  }

  void setUserDetailData(UserDetailEntity.UserDetailData userData) {
    GetStorage().write("userDetailData", userData.toMap());
  }

  clearData() {
    /* GetStorage().remove("isUserLogin");
    GetStorage().remove("userData");
    GetStorage().remove("accessToken");*/
    GetStorage().erase();
  }

  void saveMasterTags(MasterTagEntity response) {
    GetStorage().write("masterTags", response.toMap());
  }

  void saveMasterCuisines(MasterCuisineEntity response) {
    GetStorage().write("masterCuisines", response.toMap());
  }

  void saveMasterCategories(MasterCategoryEntity response) {
    GetStorage().write("masterCategories", response.toMap());
  }

  MasterTagEntity getMasterTags() {
    var user = GetStorage().read("masterTags") ?? null;
    return user != null ? MasterTagEntity.fromMap(user) : null;
  }

  MasterCuisineEntity getMasterCuisines() {
    var user = GetStorage().read("masterCuisines") ?? null;
    return user != null ? MasterCuisineEntity.fromMap(user) : null;
  }

  MasterCategoryEntity getMasterCategories() {
    var user = GetStorage().read("masterCategories") ?? null;
    return user != null ? MasterCategoryEntity.fromMap(user) : null;
  }

  void setProfileUrl(String profileUrl) {
    print("profileUrl : ======== ${profileUrl}");
    GetStorage().write("profileUrl", profileUrl);
  }

  String getProfileUrl() {
    print("profileUrl : ======== ${GetStorage().read("profileUrl")}");
    if (GetStorage().read("profileUrl") != null) {
      return GetStorage().read("profileUrl");
    }
    return "";
  }

  void setCoachProfileUrl(String coachUrl) {
    GetStorage().write("coachUrl", coachUrl);
  }

  String getCoachProfileUrl() {
    if (GetStorage().read("coachUrl") != null) {
      return GetStorage().read("coachUrl");
    }
    return "";
  }

  void setGender(int gender) {
    GetStorage().write("gender", gender);
  }

  int getGender() {
    if (GetStorage().read("gender") != null) {
      return GetStorage().read("gender");
    }
    return -1;
  }

  void setDOB(String dob) {
    GetStorage().write("dob", dob);
  }

  String getDOB() {
    if (GetStorage().read("dob") != null) {
      return GetStorage().read("dob");
    }
    return "";
  }

  void setHeight(String height) {
    GetStorage().write("height", height);
  }

  String getHeight() {
    if (GetStorage().read("height") != null) {
      return GetStorage().read("height");
    }
    return "";
  }

  void setHeightUnit(int heightUnit) {
    GetStorage().write("heightUnit", heightUnit);
  }

  int getHeightUnit() {
    if (GetStorage().read("heightUnit") != null) {
      return GetStorage().read("heightUnit");
    }
    return -1;
  }

  void setWeightUnit(int heightUnit) {
    GetStorage().write("weightUnit", heightUnit);
  }

  int getWeightUnit() {
    if (GetStorage().read("weightUnit") != null) {
      return GetStorage().read("weightUnit");
    }
    return -1;
  }

  void setWidth(String width) {
    GetStorage().write("width", width);
  }

  String getWidth() {
    if (GetStorage().read("width") != null) {
      return GetStorage().read("width");
    }
    return "";
  }

  bool isTokenSent() {
    var token = GetStorage().read("token") ?? false;
    return token;
  }

  void setToken() {
    GetStorage().write("token", true);
  }
}
