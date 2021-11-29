import 'dart:io';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/fitness_catgory_model.dart';
import 'package:fit_beat/app/data/model/language_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/auth/coach_register/view/coach_register_success.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CoachRegisterController extends GetxController
    with SingleGetTickerProviderMixin {
  final ApiRepository repository;
  CoachRegisterController({@required this.repository})
      : assert(repository != null);

  String gender = "";
  String dob = "";
  bool isRegisterLoading = false;
  RxString selectedGender = RxString("MALE");
  List<FitnessCategory> fitnessCategoryList = [];
  List<FitnessCategory> selectedFitnessCategoryList = [];

  List<Language> languageList = [];
  List<Language> selectedLanguageList = [];

  var selectedSpecialityStringTags = <String>[];
  var workExpDesc = "";
  List<File> mediaPathList = [];
  File camerasSelectFile;
  final currentDate = DateTime.now();
  Rx<DateTime> dobValue;
  RxString dobValueLabel;
  final dobFormat = new DateFormat("d MMM yyyy");
  String formattedDob(DateTime dateTime) => dobFormat.format(dateTime);

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController yearExpController = TextEditingController();
  String code = "+91";
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  TabController tabController;
  int tabIndex = 0;
  final List<Widget> tabs = <Widget>[
    Container(
        height: 44, width: Get.width / 2, child: Tab(text: "Personal Info.")),
    Container(
        height: 44, width: Get.width / 2, child: Tab(text: "Contact Info.")),
  ];

  @override
  void onInit() {
    super.onInit();
    Get.put(ProgressController());
    tabController = new TabController(vsync: this, length: tabs.length);

    tabController.addListener(() {
      if (tabController.index == 0) {
        tabIndex = 0;
      } else {
        tabIndex = 1;
      }
      update();
    });
    initData();
  }

  void initData() {
    dobValue = DateTime(2015, currentDate.month, currentDate.day).obs;
    dobValueLabel = RxString(formattedDob(dobValue.value));
    getLanguage();
    geCoachCategory();
  }

  openCamera() async {
    var file =
        await MediaPickerService().pickImage(source: ImageSource.gallery);
    if (file != null) {
      camerasSelectFile = file;
      update();
    }
  }

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

  void getLanguage() async {
    try {
      isRegisterLoading = true;
      var response = await repository.getLanguageList();
      if (response.status) {
        languageList.clear();
        languageList.addAll(response.data);
      }
      update();
    } catch (e) {
      print("Language API Error : ${e.toString()}");
      isRegisterLoading = false;
    }
  }

  void geCoachCategory() async {
    try {
      isRegisterLoading = true;
      var response = await repository.getFitnessCategory();
      isRegisterLoading = false;
      if (response.status) {
        fitnessCategoryList.clear();
        fitnessCategoryList.addAll(response.fitnessCategory);
      }
      update();
    } catch (e) {
      isRegisterLoading = false;
    }
  }

  List<Widget> getFitnessCategoryWidgetList() {
    List<Widget> fitnessCategoryWidgetList = [];
    for (FitnessCategory fitnessCategory in fitnessCategoryList) {
      fitnessCategoryWidgetList.add(InkWell(
        onTap: () {
          FitnessCategory selectedCategory = FitnessCategory(
              fitnessCategoryId: fitnessCategory.fitnessCategoryId,
              title: fitnessCategory.title);
          if (isFitenessCatgorySelected(fitnessCategory)) {
            selectedFitnessCategoryList.removeWhere((item) =>
                item.fitnessCategoryId == fitnessCategory.fitnessCategoryId);
          } else {
            selectedFitnessCategoryList.add(selectedCategory);
          }
          update();
        },
        child: CommonContainer(
            height: 31,
            width:
                Utils.getLength(fitnessCategory.title, 14, FontFamily.poppins) +
                    40,
            borderRadius: 24,
            backgroundColor: isFitenessCatgorySelected(fitnessCategory)
                ? FFB2C8D2
                : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color: isFitenessCatgorySelected(fitnessCategory)
                    ? FFB2C8D2
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: fitnessCategory.title,
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }
    return fitnessCategoryWidgetList;
  }

  bool isFitenessCatgorySelected(FitnessCategory fitnessCategory) {
    for (FitnessCategory seletedCatgory in selectedFitnessCategoryList) {
      if (seletedCatgory.fitnessCategoryId ==
          fitnessCategory.fitnessCategoryId) {
        return true;
      }
    }
    return false;
  }

  bool isLanguageSelected(Language language) {
    for (Language seletedLanguage in selectedLanguageList) {
      if (seletedLanguage.masterLanguageId == language.masterLanguageId) {
        return true;
      }
    }
    return false;
  }

  void addMedia(BuildContext context) async {
    try {
      PermissionService getPermission = PermissionService.gallery();
      await getPermission.getPermission(context);

      if (getPermission.granted == false) {
        print("permission false");
        //Permission is not granted
        return;
      }

      var file = await MediaPickerService().pickImageOrVideo();
      if (file != null) {
        if (Utils.isFileImageOrVideo(file)) {
          mediaPathList.add(file);
          update();
        } else {
          Utils.showErrorSnackBar("Please select image or video");
        }
      } else {
        Utils.showErrorSnackBar("Please select image or video");
      }
    } catch (_) {
      Utils.showErrorSnackBar("exception");
    }
  }

  void removeMedia(int position) {
    mediaPathList.removeAt(position);
    update();
  }

  List<Widget> getLanguageWidgetList() {
    List<Widget> languageWidgetList = [];
    for (Language language in languageList) {
      languageWidgetList.add(InkWell(
        onTap: () {
          Language selectedLanguage = language;
          if (isLanguageSelected(language)) {
            selectedLanguageList.removeWhere(
                (item) => item.masterLanguageId == language.masterLanguageId);
          } else {
            selectedLanguageList.add(selectedLanguage);
          }
          update();
        },
        child: CommonContainer(
            height: 31,
            width: Utils.getLength(language.title, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor:
                isLanguageSelected(language) ? FFB2C8D2 : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color: isLanguageSelected(language)
                    ? FFB2C8D2
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: language.title,
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }
    return languageWidgetList;
  }

  Future<String> getProfileUrl() async {
    List<File> profilemediaPathList = [];
    if (camerasSelectFile != null) {
      profilemediaPathList.add(camerasSelectFile);
      var response = await repository.uploadCoachMedia(profilemediaPathList, 0);
      if (response.status) {
        return response.url[0].mediaUrl;
      }
    }
    return "";
  }

  void validatePersonalInfo() {
    String name = nameController.text.toString();
    int gender = -1;
    if (genderController.text.toString() == "MALE") {
      gender = 1;
    } else if (genderController.text.toString() == "FEMALE") {
      gender = 2;
    } else if (genderController.text.toString() == "OTHER") {
      gender = 3;
    }
    final requestDobFormat = new DateFormat("yyyy-MM-dd");
    String dob = requestDobFormat.format(dobValue.value);
    //int yearOfExp = int.parse(yearExpController.text.toString());
    String workExp = workExpDesc;

    if (name.isBlank) {
      Utils.showErrorSnackBar("Please enter name");
    } else if (gender == -1) {
      Utils.showErrorSnackBar("Please select gender");
    } else if (dobController.text.toString().isBlank) {
      Utils.showErrorSnackBar("Please select date of birth");
    } else if (yearExpController.text.toString().isBlank) {
      Utils.showErrorSnackBar("Please enter year of experience");
    } else if (selectedFitnessCategoryList.isEmpty) {
      Utils.showErrorSnackBar("Please select category");
    } else if (selectedSpecialityStringTags.isEmpty) {
      Utils.showErrorSnackBar("Please add speciality");
    } else if (selectedLanguageList.isEmpty) {
      Utils.showErrorSnackBar("Please select languages");
    } else if (workExpDesc.isEmpty) {
      Utils.showErrorSnackBar("Please enter work experience");
    } else {
      tabController.animateTo(1);
    }
  }

  void registerCoach() async {
    String name = nameController.text.toString();
    int gender = -1;
    if (genderController.text.toString() == "MALE") {
      gender = 1;
    } else if (genderController.text.toString() == "FEMALE") {
      gender = 2;
    } else if (genderController.text.toString() == "OTHER") {
      gender = 3;
    }
    final requestDobFormat = new DateFormat("yyyy-MM-dd");
    String dob = requestDobFormat.format(dobValue.value);
    //int yearOfExp = int.parse(yearExpController.text.toString());
    String workExp = workExpDesc;

    if (name.isBlank) {
      Utils.showErrorSnackBar("Please enter name");
      tabController.animateTo(0);
    } else if (gender == -1) {
      Utils.showErrorSnackBar("Please select gender");
      tabController.animateTo(0);
    } else if (dobController.text.toString().isBlank) {
      Utils.showErrorSnackBar("Please select date of birth");
      tabController.animateTo(0);
    } else if (yearExpController.text.toString().isBlank) {
      Utils.showErrorSnackBar("Please enter year of experience");
      tabController.animateTo(0);
    } else if (selectedFitnessCategoryList.isEmpty) {
      Utils.showErrorSnackBar("Please select category");
      tabController.animateTo(0);
    } else if (selectedSpecialityStringTags.isEmpty) {
      Utils.showErrorSnackBar("Please add speciality");
      tabController.animateTo(0);
    } else if (selectedLanguageList.isEmpty) {
      Utils.showErrorSnackBar("Please select languages");
      tabController.animateTo(0);
    } else if (workExpDesc.isEmpty) {
      Utils.showErrorSnackBar("Please enter work experience");
      tabController.animateTo(0);
    } else if (code.isBlank) {
      Utils.showErrorSnackBar("Please enter country code");
    } else if (mobileController.text.toString().isBlank) {
      Utils.showErrorSnackBar("Please enter mobile number");
    } else if (emailController.text.toString().isBlank) {
      Utils.showErrorSnackBar("Please enter email");
    } else if (countryController.text.toString().isBlank) {
      Utils.showErrorSnackBar("Please enter country");
    } else {
      /* try {

      } catch (e) {
        print("register error ${e.toString()}");
        Utils.dismissLoadingDialog();
      }*/
      print("else");
      Get.find<ProgressController>().progress = 0.0;
      Utils.showProgressLoadingDialog();
      print("mediaPathList : ${mediaPathList.length}");
      var profileUploadUrl = await getProfileUrl();
      Get.find<ProgressController>().progress = 0.0;
      var response = await repository.uploadCoachMedia(mediaPathList, 0);
      if (response.status) {
        Utils.dismissLoadingDialog();
        Utils.showLoadingDialog();
        var registerResponse = await repository.registerCoach(
            userInterestId: selectedSpecialityStringTags,
            profileUrl: profileUploadUrl,
            fullName: name,
            gender: gender,
            dateOfBirth: dob,
            noOfExperience: int.parse(yearExpController.text),
            fitnessCategory: selectedFitnessCategoryList,
            userLanguages: selectedLanguageList,
            workExperience: workExpDesc,
            userCertificates: response.url,
            countryCode: code,
            phoneNumber: mobileController.text.toString(),
            emailAddress: emailController.text.toString(),
            country: countryController.text.toString());
        Utils.dismissLoadingDialog();
        if (registerResponse.status) {
          Get.off(
              CoachRegisterSuccessPage(
                message: registerResponse.message,
              ),
              arguments: registerResponse.message);
          Utils.showSucessSnackBar(registerResponse.message);
        } else {
          Utils.showErrorSnackBar(registerResponse.message);
        }
      } else {
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(response.message ?? "Unable to add post");
      }
    }
  }

  addCountryCode(String dialCode) {
    code = dialCode;
  }
}
