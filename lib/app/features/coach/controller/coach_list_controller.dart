import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/coach_list_model.dart';
import 'package:fit_beat/app/data/model/feed/feed_filter_type.dart';
import 'package:fit_beat/app/data/model/fitness_catgory_model.dart';
import 'package:fit_beat/app/data/model/language_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachListController extends GetxController {
  final ApiRepository repository;

  CoachListController({@required this.repository}) : assert(repository != null);

  TextEditingController searchController = TextEditingController();

  List<FitnessCategory> filterFitnessCategoryList = [];
  FitnessCategory selectedFitensssCategory;
  int experienceLevel = 0;
  double rating = 0;
  int pageNo = 1;
  int pageRecord = 10;
  bool isLoading = false;
  List<Coach> coachList = [];

  List<FeedFilterType> genderList = [];
  FeedFilterType selectedGender;

  var coachLevelList = {
    1: "Basic",
    2: "Standard",
    3: "Proficient",
    4: "Expert"
  };
  var coachLevel;
  Language languageModel;

  List<Language> languageList = [];

  @override
  void onInit() async {
    await getCoachFilterList();
    loadLanguageList();
    getGenderList();
    getCoachList();
  }

  void loadLanguageList() async {
    try {
      isLoading = true;
      var response = await repository.getLanguageList();
      if (response.status) {
        languageList = response.data;
      }
      update();
    } catch (e) {
      languageList = [];
      isLoading = false;
      update();
    }
  }

  void getCoachFilterList() async {
    try {
      isLoading = true;
      var response = await repository.getFitnessCategory();
      // isLoading = false;
      if (response.status) {
        filterFitnessCategoryList.clear();
        filterFitnessCategoryList.addAll(response.fitnessCategory);
        selectedFitensssCategory = filterFitnessCategoryList[0];
      }
      update();
    } catch (e) {
      isLoading = false;
    }
  }

  void getFilteredCoach(int index) async {
    selectedFitensssCategory = filterFitnessCategoryList[index];
    try {
      Utils.showLoadingDialog();
      var response = await repository.getCoachList(
        fitnessCategoryId: selectedFitensssCategory.fitnessCategoryId,
        gender: selectedGender?.title ?? "",
        pageNo: pageNo,
        pageRecord: pageRecord,
        experienceLevel: experienceLevel ?? 0,
        rating: rating ?? 0,
        userLanguages: languageModel != null ? [languageModel.title] : [],
      );
      Utils.dismissLoadingDialog();
      if (response.status) {
        coachList.clear();
        coachList.addAll(response.data.rows);
      } else {
        coachList = [];
      }
      update();
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  void getGenderList() {
    genderList.add(FeedFilterType(isSelected: true, title: "Male", type: 0));
    genderList.add(FeedFilterType(isSelected: false, title: "Female", type: 1));
    genderList.add(FeedFilterType(isSelected: false, title: "Other", type: 2));
  }

  void getGenderCoach(int index) async {
    selectedGender = genderList[index];
    update();
  }

  List<Widget> getCoachLevelList() {
    List<Widget> coachLevelWidgetList = [];
    coachLevelList.entries.map((entry) {
      return coachLevelWidgetList.add(InkWell(
        onTap: () {
          coachLevel = entry.key;
          experienceLevel = entry.key;
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

  List<Widget> getLanguageList() {
    List<Widget> languageWidgetList = [];

    for (var language in languageList) {
      languageWidgetList.add(InkWell(
        onTap: () {
          languageModel = language;
          update();
          print("${language} == ${language.masterLanguageId}");
        },
        child: CommonContainer(
            key: Key("$language"),
            height: 31,
            width: Utils.getLength(language.title, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor: languageModel != null &&
                    languageModel.masterLanguageId == language.masterLanguageId
                ? FFB2C8D2
                : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color: languageModel != null &&
                        languageModel.masterLanguageId ==
                            language.masterLanguageId
                    ? FFB2C8D2
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: language?.title ?? "",
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }

    return languageWidgetList;
  }

  var topic;

  resetFilter() {
    selectedGender = null;
    experienceLevel = 0;
    rating = 0;
    languageModel = null;
    getCoachList();
  }

  void getCoachList() async {
    try {
      Utils.dismissKeyboard();
      isLoading = true;
      update();
      var response = await repository.getCoachList(
        fitnessCategoryId: selectedFitensssCategory.fitnessCategoryId,
        gender: selectedGender?.title ?? "",
        pageNo: pageNo,
        pageRecord: pageRecord,
        experienceLevel: experienceLevel ?? 0,
        rating: rating ?? 0,
        userLanguages: languageModel != null ? [languageModel.title] : [],
      );
      isLoading = false;
      if (response.status) {
        coachList.clear();
        coachList.addAll(response.data.rows);
      } else {
        coachList = [];
      }
      update();
    } catch (e) {
      print("error : ${e.toString()}");
      coachList = [];
      isLoading = false;
      update();
    }
  }
}
