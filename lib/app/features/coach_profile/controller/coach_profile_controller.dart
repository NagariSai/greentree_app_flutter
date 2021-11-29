import 'dart:io';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/coach_profile_info_model.dart';
import 'package:fit_beat/app/data/model/feed/feed_filter_type.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/model/fitness_catgory_model.dart';
import 'package:fit_beat/app/data/model/language_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach_main/controllers/coach_main_controller.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CoachProfileController extends GetxController {
  final ApiRepository repository;

  CoachProfileController({@required this.repository})
      : assert(repository != null);

  var coachProfileId;
  bool isCoachProfileLoading = false;
  CoachProfile coachProfile;

  var coachLevelList = {
    1: "Basic",
    2: "Standard",
    3: "Proficient",
    4: "Expert"
  };
  var coachLevel;

  var language;

  List<FeedFilterType> topicList = [];
  var selectedTopic;

  bool isEnroll = false;

  bool feedLastPage = false;
  int postCount = 0;
  int pageLimit = 10;
  int pageNo = 1;
  int type = 1;

  List<Feed> feedList = [];

  String fitnessCategoryStr = "";

  var fitnessCategoryId;

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController yearExpController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController workExpController = TextEditingController();

  List<FitnessCategory> fitnessCategoryList = [];
  List<FitnessCategory> selectedFitnessCategoryList = [];

  var selectedSpecialityStringTags = <String>[];
  var workExpDesc = "";
  List<File> mediaPathList = [];

  List<Language> languageList = [];
  List<Language> selectedLanguageList = [];

  String profileUploadUrl = "";

  @override
  void onInit() async {
    super.onInit();
    Get.put(ProgressController());
    coachProfileId = Get.arguments;
    dobValue = DateTime(2015, currentDate.month, currentDate.day).obs;
    dobValueLabel = RxString(formattedDob(dobValue.value));
    await getCoachDetails();
    geCoachCategory();
    getLanguage();
    getTopicList();
    getCoachFeed();
    getInit();
  }

  void getCoachFeed() async {
    try {
      isCoachProfileLoading = true;
      var response = await repository.getFeeds(pageNo, type, pageLimit,
          userProfileId: PrefData().getUserData().userId);
      isCoachProfileLoading = false;
      if (response.status) {
        if (response.data != null && response.data.feeds != null) {
          print("data");
          if (pageNo == 1) {
            feedList.clear();
          }
          postCount = response.data.count;
          feedList.addAll(response.data.feeds);
        } else {
          feedLastPage = true;
        }
      }
      update();
    } catch (e) {
      print("feed data error : ${e.toString()}");
      isCoachProfileLoading = false;
      update();
    }
  }

  void getFilteredFeed(int index) async {
    try {
      topicList.forEach((element) {
        element.isSelected = false;
      });
      selectedTopic = topicList[index];
      selectedTopic.isSelected = true;
      feedList.clear();
      update();

      Utils.showLoadingDialog();

      var response = await repository.getFeeds(1, selectedTopic.type, pageLimit,
          userProfileId: PrefData().getUserData().userId);

      if (response.status) {
        feedList.clear();

        if (response.data != null && response.data.feeds != null) {
          postCount = response.data.count;
          feedList.addAll(response.data.feeds);
        }
      }
      Utils.dismissLoadingDialog();
      update();
    } on Exception catch (e) {
      Utils.dismissLoadingDialog();
      print("Error => $e");
    }
  }

  void getTopicList() {
    topicList.add(FeedFilterType(isSelected: true, title: "All", type: 0));
    topicList
        .add(FeedFilterType(isSelected: false, title: "Challenges", type: 2));
    topicList.add(
        FeedFilterType(isSelected: false, title: "Transformations", type: 3));
    topicList.add(FeedFilterType(isSelected: false, title: "Recipe", type: 4));
    topicList
        .add(FeedFilterType(isSelected: false, title: "Discussions", type: 1));
    topicList.add(FeedFilterType(isSelected: false, title: "Updates", type: 5));
    selectedTopic = topicList[0];
  }

  void getCoachDetails() async {
    try {
      isCoachProfileLoading = true;
      var response = await repository.getCoachProfile(
          coachProfileId: PrefData().getUserData().userId);
      if (response.status) {
        coachProfile = response.coach;

        fitnessCategoryStr = "";
        if (coachProfile.userFitnessCategories.length > 0) {
          for (var fitnessCategory in coachProfile.userFitnessCategories) {
            fitnessCategoryStr += "${fitnessCategory.title},";
            fitnessCategoryId = fitnessCategory.fitnessCategoryId;
          }
        }
        setData();
      }
      update();
    } catch (e) {
      isCoachProfileLoading = false;
      update();
    }
  }

  final dobFormat = new DateFormat("d MMM yyyy");
  String formattedDob(DateTime dateTime) => dobFormat.format(dateTime);

  void setData() {
    nameController.text = coachProfile.fullName ?? "";

    String gender = "";
    if (coachProfile.gender == 1) {
      gender = "MALE";
    } else if (coachProfile.gender == 2) {
      gender = "FEMALE";
    } else if (coachProfile.gender == 3) {
      gender = "OTHER";
    }
    genderController.text = gender;

    if (coachProfile.dateOfBirth != null) {
      dobController.text = formattedDob(coachProfile.dateOfBirth);
    }
    profileUploadUrl = coachProfile.profileUrl;
    Get.find<CoachMainController>().profileUrl.value = coachProfile.profileUrl;

    PrefData().setCoachProfileUrl(coachProfile.profileUrl);

    selectedSpecialityStringTags = coachProfile.speciality.split(",");
    print(
        "selectedSpecialityStringTags ${selectedSpecialityStringTags.length}");

    yearExpController.text = "${coachProfile.noOfExperience ?? "0"}";
    codeController.text = coachProfile.countryCode ?? "";
    emailController.text = coachProfile.emailAddress ?? "";
    countryController.text = coachProfile.country ?? "";
    mobileController.text = coachProfile.phoneNumber ?? "";
    workExpController.text = coachProfile.bio ?? "";

    if (coachProfile.userFitnessCategories != null) {
      for (var fitCategory in coachProfile.userFitnessCategories) {
        FitnessCategory selectedCategory = FitnessCategory(
            fitnessCategoryId: fitCategory.fitnessCategoryId,
            title: fitCategory.title);
        selectedFitnessCategoryList.add(selectedCategory);
      }
    }
  }

  List<Widget> getCoachLevelList() {
    List<Widget> coachLevelWidgetList = [];
    coachLevelList.entries.map((entry) {
      return coachLevelWidgetList.add(InkWell(
        onTap: () {
          coachLevel = entry.key;
          update();
          print("${coachLevel} == ${coachLevel}");
        },
        child: CommonContainer(
            key: Key("$coachLevel"),
            height: 31,
            width: Utils.getLength(entry.value, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor:
                coachLevel == entry.key ? FFB2C8D2 : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color: coachLevel == entry.key ? FFB2C8D2 : Colors.transparent,
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

    return coachLevelWidgetList;
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

  void geCoachCategory() async {
    try {
      isCoachProfileLoading = true;
      var response = await repository.getFitnessCategory();
      if (response.status) {
        fitnessCategoryList.clear();
        fitnessCategoryList.addAll(response.fitnessCategory);
      }
      update();
    } catch (e) {
      isCoachProfileLoading = false;
    }
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

  int currentIndex = 0;
  void setCurrentTab(int index) {
    this.currentIndex = index;
    update();
  }

  void getLanguage() async {
    try {
      isCoachProfileLoading = true;
      var response = await repository.getLanguageList();
      if (response.status) {
        languageList.clear();
        languageList.addAll(response.data);
      }
      update();
    } catch (e) {
      print("Language API Error : ${e.toString()}");
      isCoachProfileLoading = false;
    }
  }

  RxBool isEdit = RxBool(false);

  editProfile() async {
    try {
      final requestDobFormat = new DateFormat("yyyy-MM-dd");
      int genderVal = -1;
      final name = nameController.text.toString();
      if (genderController.text.toString() == "MALE") {
        genderVal = 1;
      } else if (genderController.text.toString() == "FEMALE") {
        genderVal = 2;
      } else {
        genderVal = 3;
      }

      String speciality = "";
      for (var string in selectedSpecialityStringTags) {
        speciality += "$string,";
      }

      String bannerUploadUrl = "";
      if (camerasSelectFile != null) {
        Get.find<ProgressController>().progress = 0.0;
        Utils.showProgressLoadingDialog();
        profileUploadUrl = await getProfileUrl();
        Utils.dismissLoadingDialog();
      }

      if (bannercamerasSelectFile != null) {
        Get.find<ProgressController>().progress = 0.0;
        Utils.showProgressLoadingDialog();
        bannerUploadUrl = await getBannerUrl();
        Utils.dismissLoadingDialog();
      }

      final dob = requestDobFormat.format(dobValue.value);
      final yearOfExp = yearExpController.text.toString();
      final workExp = workExpController.text.toString();
      final country = countryController.text.toString();
      final countryCode = codeController.text.toString();
      final emailAddress = emailController.text.toString();

      Utils.showLoadingDialog();
      var response = await repository.editCoachProfile(
          fullName: name,
          gender: genderVal,
          dateOfBirth: dob,
          noOfExperience: yearOfExp,
          workExperience: workExp,
          fitnessCategory: selectedFitnessCategoryList,
          userLanguages: selectedLanguageList,
          backgroundProfileUrl: bannerUploadUrl,
          country: country,
          countryCode: countryCode,
          emailAddress: emailAddress,
          speciality: speciality,
          profileUrl: profileUploadUrl);
      Utils.dismissLoadingDialog();
      if (response.status) {
        if (profileUploadUrl != null) {
          print("profileUploadUrl ============ ${profileUploadUrl}");
          PrefData().setCoachProfileUrl(profileUploadUrl);
          Get.find<CoachMainController>().profileUrl.value = profileUploadUrl;
        }
        Utils.showSucessSnackBar(response.message);
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  void getInit() {
    nameController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    genderController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    dobController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    yearExpController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    codeController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    mobileController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    emailController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    countryController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
    workExpController.addListener(() {
      isEdit.value = true;
      isEdit.refresh();
    });
  }

  final currentDate = DateTime.now();
  Rx<DateTime> dobValue;
  RxString dobValueLabel;
  RxString selectedGender = RxString("MALE");

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

  File camerasSelectFile;
  openCamera() async {
    isEdit.value = true;
    isEdit.refresh();
    var file =
        await MediaPickerService().pickImage(source: ImageSource.gallery);
    if (file != null) {
      camerasSelectFile = file;
      update();
    }
  }

  File bannercamerasSelectFile;
  openBannerCamera() async {
    isEdit.value = true;
    isEdit.refresh();
    var file =
        await MediaPickerService().pickImage(source: ImageSource.gallery);
    if (file != null) {
      bannercamerasSelectFile = file;
      update();
    }
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

  Future<String> getBannerUrl() async {
    List<File> banneremediaPathList = [];
    if (bannercamerasSelectFile != null) {
      banneremediaPathList.add(bannercamerasSelectFile);
      var response = await repository.uploadMedia(banneremediaPathList, 0);
      if (response.status) {
        return response.url[0].mediaUrl;
      }
    }
    return "";
  }

  List<String> split(String string, String separator, {int max = 0}) {
    var result = List<String>();

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      var index = string.indexOf(separator, 0);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = string.substring(index + separator.length);
    }

    return result;
  }
}
