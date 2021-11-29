import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/coach_profile_info_model.dart';
import 'package:fit_beat/app/data/model/feed/feed_filter_type.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/model/language_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachDetailsController extends GetxController {
  final ApiRepository repository;

  CoachDetailsController({@required this.repository})
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

  Language languageModel;

  List<Language> languageList = [];

  @override
  void onInit() async {
    super.onInit();
    coachProfileId = Get.arguments;
    await getCoachDetails();
    loadLanguageList();
    getTopicList();
    getCoachFeed();
  }

  void loadLanguageList() async {
    try {
      //isLoading = true;
      var response = await repository.getLanguageList();
      if (response.status) {
        languageList = response.data;
      }
      update();
    } catch (e) {
      languageList = [];
      // isLoading = false;
      update();
    }
  }

  void getCoachFeed() async {
    try {
      isCoachProfileLoading = true;
      var response = await repository.getFeeds(pageNo, type, pageLimit,
          userProfileId: coachProfileId);
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
      update();

      Utils.showLoadingDialog();

      var response = await repository.getFeeds(1, selectedTopic.type, pageLimit,
          userProfileId: coachProfileId);

      if (response.status) {
        feedList.clear();

        if (response.data != null && response.data.feeds != null) {
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
      var response =
          await repository.getCoachProfile(coachProfileId: coachProfileId);
      if (response.status) {
        coachProfile = response.coach;

        fitnessCategoryStr = "";
        if (coachProfile.userFitnessCategories.length > 0) {
          for (var fitnessCategory in coachProfile.userFitnessCategories) {
            fitnessCategoryStr += "${fitnessCategory.title},";
            fitnessCategoryId = fitnessCategory.fitnessCategoryId;
          }
        }
        coachLevel = coachProfile.experienceLevel ?? 0;
      }
      update();
    } catch (e) {
      print("error ${e.toString()}");
      isCoachProfileLoading = false;
      update();
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
}
