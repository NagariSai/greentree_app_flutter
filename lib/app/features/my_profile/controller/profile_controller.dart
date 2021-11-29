import 'dart:io';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/user/user_detail_entity.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/hex_color.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final ApiRepository repository;
  ProfileController({@required this.repository}) : assert(repository != null);

  UserDetailData userData;

  String gender = "";
  String dob = "";

  var foodPrefList = {
    1: "Veg",
    2: "Nonveg",
    3: "Eggetarian",
    4: "Vegan",
  };
  var fitLevelList = {1: "Beginner", 2: "Intermediate", 3: "Advanced"};

  int food_preference;
  int fitness_level;
  List<User> userInterests = [];
  List<User> userBrings = [];

  @override
  void onInit() {
    super.onInit();
    Get.put(ProgressController());
    dobValue = DateTime(2015, currentDate.month, currentDate.day).obs;
    dobValueLabel = RxString(formattedDob(dobValue.value));

    getMyProfile();
  }

  bool isProfileLoading = false;

  var selectedHeightUnit = Rx(HEIGHT_UNIT.INCH);
  var selectedWeightUnit = Rx(WEIGHT_UNIT.LB);

  RxString selectedHeight = RxString("4.6");
  RxString selectedWeight = RxString("63");

  RxString selectedGender = RxString("MALE");

  updateUnit() {
    selectedHeightUnit.refresh();
  }

  void getMyProfile() async {
    try {
      isProfileLoading = true;
      update();
      var response = await repository.getMyProfile();
      isProfileLoading = false;
      if (response.status) {
        userData = response.data;
        initData();
      }
      update();
    } catch (e) {
      isProfileLoading = false;
      update();
      print("profile error : ${e.toString()}");
    }
  }

  reloadProfileData() async {
    try {
      var response = await repository.getMyProfile();
      isProfileLoading = false;
      if (response.status) {
        userData = response.data;
        PrefData().setProfileUrl(userData.userData.profileUrl);
        Get.find<MainController>().profileUrl.value =
            userData.userData.profileUrl;

        PrefData().setGender(userData.userData.gender);
        PrefData().setDOB(userData.userData.dateOfBirth);
        PrefData().setHeight(userData.userData.height);
        PrefData().setWidth(userData.userData.weight);
        PrefData().setWeightUnit(userData.userData.weightType);
        PrefData().setHeightUnit(userData.userData.heightUnit);

        initData();
      }
      update();
    } catch (e) {
      print("profile error : ${e.toString()}");
    }
  }

  void initData() {
    if (userData.userData.gender == 1) {
      gender = "MALE";
    } else if (userData.userData.gender == 2) {
      gender = "FEMALE";
    } else {
      gender = "OTHER";
    }

    if (userData.userData.dateOfBirth != null) {
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(userData.userData.dateOfBirth);
      dobValue.value = parseDate;
      dobValueLabel.value = formattedDob(parseDate);
      dob = Utils.convertDateIntoDisplayString(parseDate);
    } else {
      dob = "";
    }
    dobController.text = dob;
    genderController.text = gender;

    print("gender = ${userData.userData.gender}");

    codeController.text = userData.userData.countryCode != null &&
            userData.userData.countryCode.isNotEmpty
        ? userData.userData.countryCode
        : "+91";
    mobileController.text = userData.userData.phoneNumber ?? "";
    emailController.text = userData.userData.emailAddress ?? "";
    countryController.text = userData.userData.country ?? " ";
    bioTextEditController.text = userData.userData.bio ?? "";

    bringsYouList = userData.masterBrings ?? [];
    food_preference = userData.userData.foodPreference ?? null;
    fitness_level = userData.userData.fitnessLevel ?? null;

    print("food_preference = ${food_preference}");
    print("fitness_level = ${fitness_level}");

    interestList = userData.masterInterests ?? [];

    userInterests = userData.userData.userInterests ?? [];
    userBrings = userData.userData.userBrings ?? [];

    selectedHeight.value = userData.userData.height ?? "4.6";
    selectedWeight.value = userData.userData.weight ?? "63";

    print(" userData.userData.heightUnit = ${userData.userData.heightUnit}");

    selectedHeightUnit.value =
        userData.userData.heightUnit == 1 ? HEIGHT_UNIT.INCH : HEIGHT_UNIT.CM;
    selectedWeightUnit.value =
        userData.userData.weightType == 1 ? WEIGHT_UNIT.LB : WEIGHT_UNIT.KG;
    colorCode = [FF5DD8D0, FFFF9B91, FF9586FB, FFFBAB4D, FFD890D5, FF6BD295];

    genderController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    dobController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
      refreshEdit();
    });
    codeController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
      refreshEdit();
    });

    mobileController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
      refreshEdit();
    });

    emailController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
      refreshEdit();
    });

    countryController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
      refreshEdit();
    });
    bioTextEditController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
      refreshEdit();
    });
  }

  refreshEdit() {
    // update();
  }

  RxBool isEdit = RxBool(false);
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController bioTextEditController = TextEditingController();

  List<MasterBring> bringsYouList = [];
  List<Color> colorCode = [];
  List<String> foodList = [];
  List<String> fitnessLevelList = [];
  List<MasterInterest> interestList = [];

  File camerasSelectFile;
  openCamera() async {
    isEdit.value = true;
    isEdit.refresh();
    refreshEdit();
    var file =
        await MediaPickerService().pickImage(source: ImageSource.gallery);
    if (file != null) {
      camerasSelectFile = file;
      update();
    }
  }

  List<Widget> getFitnessLevelList() {
    List<Widget> fitnessLevelWidgetList = [];
    fitLevelList.entries.map((entry) {
      return fitnessLevelWidgetList.add(InkWell(
        onTap: () {
          fitness_level = entry.key;
          update();
          print("${fitness_level} == ${fitness_level}");
        },
        child: CommonContainer(
            key: Key("$fitness_level"),
            height: 31,
            width: Utils.getLength(entry.value, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor:
                fitness_level == entry.key ? FFB2C8D2 : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color:
                    fitness_level == entry.key ? FFB2C8D2 : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: entry.value,
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }).toList();

    return fitnessLevelWidgetList;
  }

  bool isInterestSelected(MasterInterest masterInterest) {
    for (User user in userInterests) {
      if (user.masterInterestId == masterInterest.masterInterestId) {
        return true;
      }
    }
    return false;
  }

  bool isBringYouSelected(MasterBring masterBring) {
    for (User user in userBrings) {
      //print("${user.masterBringId} == ${masterBring.masterBringId}");
      if (user.masterBringId == masterBring.masterBringId) {
        return true;
      }
    }
    return false;
  }

  List<Widget> getInterestList() {
    List<Widget> interestWidgetList = [];
    for (MasterInterest interest in interestList) {
      interestWidgetList.add(InkWell(
        onTap: () {
          print("before = ${userInterests.length}");
          isEdit.value = true;
          isEdit.refresh();
          User user = User(masterInterestId: interest.masterInterestId);
          if (isInterestSelected(interest)) {
            userInterests.removeWhere(
                (item) => item.masterInterestId == interest.masterInterestId);
          } else {
            userInterests.add(user);
          }
          update();
          print("after = ${userInterests.length}");
        },
        child: CommonContainer(
            height: 31,
            width: Utils.getLength(interest.title, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor:
                isInterestSelected(interest) ? FFB2C8D2 : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color: isInterestSelected(interest)
                    ? FFB2C8D2
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: interest.title,
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }
    return interestWidgetList;
  }

  List<Widget> getFoodList() {
    List<Widget> foodWidgetList = [];
    foodPrefList.entries.map((entry) {
      foodWidgetList.add(InkWell(
        onTap: () {
          isEdit.value = true;
          isEdit.refresh();
          food_preference = entry.key;
          update();
        },
        child: CommonContainer(
            height: 31,
            width: Utils.getLength(entry.value, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor: food_preference == entry.key
                ? colorCode[entry.key]
                : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: colorCode[entry.key],
                  width: 1,
                ),
                color: food_preference == entry.key
                    ? colorCode[entry.key]
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: entry.value,
                textAlign: TextAlign.center,
                size: 14,
                color: food_preference == entry.key
                    ? Colors.white
                    : colorCode[entry.key],
              ),
            )),
      ));
    }).toList();

    return foodWidgetList;
  }

  List<Widget> getBringsYouList() {
    List<Widget> bringsYouWidgetList = [];
    int index = 0;
    for (MasterBring bringsYou in bringsYouList) {
      bringsYouWidgetList.add(InkWell(
        onTap: () {
          print("before = ${userBrings.length}");
          isEdit.value = true;
          isEdit.refresh();
          User user = User(masterBringId: bringsYou.masterBringId);
          if (isBringYouSelected(bringsYou)) {
            userBrings.removeWhere(
                (item) => item.masterBringId == bringsYou.masterBringId);
          } else {
            userBrings.add(user);
          }
          update();
          print("after = ${userBrings.length}");
        },
        child: CommonContainer(
            height: 31,
            width:
                Utils.getLength(bringsYou.title, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor: isBringYouSelected(bringsYou)
                ? HexColor(bringsYou.color)
                : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: HexColor(bringsYou.color),
                  width: 1,
                ),
                color: isBringYouSelected(bringsYou)
                    ? HexColor(bringsYou.color)
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: bringsYou.title,
                textAlign: TextAlign.center,
                size: 14,
                color: isBringYouSelected(bringsYou)
                    ? Colors.white
                    : HexColor(bringsYou.color),
              ),
            )),
      ));
      index++;
    }
    return bringsYouWidgetList;
  }

  final currentDate = DateTime.now();
  Rx<DateTime> dobValue;
  RxString dobValueLabel;
  final dobFormat = new DateFormat("d MMM yyyy");

  void setDob(DateTime dob) {
    var dobBugFix = dob;
    if (dobBugFix.year == currentDate.year) {
      dobBugFix = DateTime(2015, dobBugFix.month, dobBugFix.day);
    }
    dobValue.value = dobBugFix;
    dobValueLabel.value = formattedDob(dobBugFix);
    dobController.text = Utils.convertDateIntoDisplayString(dobValue.value);
    print("dobValue : ${dobValue.value}");
    print("dobValueLabel : ${dobValueLabel.value}");
  }

  String formattedDob(DateTime dateTime) => dobFormat.format(dateTime);

  String foot_to_cm(double foot) {
    var foot_to_string = foot.toString();
    var onlyFoot = foot.toInt();
    var onlyInch = int.parse(foot_to_string.substring(
        foot_to_string.indexOf(".") + 1, foot_to_string.length));

    if (foot == 0.0) return "0";

    var foot_to_cm = (30.48 * onlyFoot);

    var inch_to_cm = (2.54 * onlyInch);

    var result = (foot_to_cm + inch_to_cm).floor().toString();

    print("foot_to_cm => $result");
    return result;
  }

  String cm_to_foot(int cm) {
    if (cm == 0) return "0.0";

    var value = (cm / 30.48).toStringAsFixed(2);

    var inch =
        (int.parse(value.substring(value.indexOf(".") + 1, value.length)) *
                0.12)
            .round();
    var foot = (cm / 30.48).floor();

    value = "$foot.$inch";

    print("cm_to_foot => $value");
    return value;
  }

  String kg_to_lb(double kg) {
    if (kg == 0.0) return "0";

    var value = (2.205 * kg).floor().toString();

    print("kg_to_lb => $value");
    return value;
  }

  String lb_to_kg(int lb) {
    if (lb == 0) return "0.0";

    var value = (lb / 2.205).toStringAsFixed(2);
    if (int.parse(value.substring(value.indexOf(".") + 1, value.length)) > 9) {
      value = (lb / 2.205).toStringAsFixed(1);
    }

    print("lb_to_kg => $value");
    return value;
  }

  Future<String> getProfileUrl() async {
    List<File> profilemediaPathList = [];
    if (camerasSelectFile != null) {
      profilemediaPathList.add(camerasSelectFile);
      var response = await repository.uploadMedia(profilemediaPathList, 0);
      if (response.status) {
        return response.url[0].mediaUrl;
      }
    }
    return "";
  }

  void editMyProfileDetails() async {
    try {
      final requestDobFormat = new DateFormat("yyyy-MM-dd");
      int genderVal = -1;
      var profileUploadUrl;

      if (genderController.text.toString() == "MALE") {
        genderVal = 1;
      } else if (genderController.text.toString() == "FEMALE") {
        genderVal = 2;
      } else {
        genderVal = 3;
      }

      if (camerasSelectFile != null) {
        Get.find<ProgressController>().progress = 0.0;
        Utils.showProgressLoadingDialog();
        profileUploadUrl = await getProfileUrl();
        Utils.dismissLoadingDialog();
      }
      Utils.showLoadingDialog();
      var response = await repository.editMyProfile(
          fitnessLevel: fitness_level.toString(),
          foodPreference: food_preference.toString(),
          height: selectedHeight.value.toString(),
          heightUnit: selectedHeightUnit.value == HEIGHT_UNIT.INCH ? 1 : 2,
          weight: selectedWeight.value.toString(),
          weightType: selectedWeightUnit.value == WEIGHT_UNIT.LB ? 1 : 2,
          dateofbirth: requestDobFormat.format(dobValue.value),
          gender: genderVal,
          bio: bioTextEditController.text.toString(),
          userInterests: userInterests,
          userBrings: userBrings,
          profileUrl: profileUploadUrl,
          phone_number: mobileController.text.toString(),
          country: countryController.text.toString(),
          country_code: codeController.text.toString());

      if (response.status) {
        if (profileUploadUrl != null) {
          print("profileUploadUrl ============ ${profileUploadUrl}");
          PrefData().setProfileUrl(profileUploadUrl);
          Get.find<MainController>().profileUrl.value = profileUploadUrl;
        }
        reloadProfileData();
        Utils.dismissLoadingDialog();
        Utils.showSucessSnackBar(response.message);
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }
}
