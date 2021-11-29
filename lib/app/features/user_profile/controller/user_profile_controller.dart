import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/feed/feed_filter_type.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/model/user/profile_model.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final ApiRepository repository;

  UserProfileController({@required this.repository})
      : assert(repository != null);

  List<UserInterest> interest = [];
  List<UserGoal> goals = [];
  List<Color> colorsCode = [FF5DD8D0, FFFBAB4D];

  int from;

  List<FeedFilterType> filterList = List();
  FeedFilterType selectedFilterType;

  @override
  void onInit() {
    super.onInit();
    profileId = Get.arguments[0];
    type = Get.arguments[1];
    from = Get.arguments.length == 3 ? Get.arguments[2] : 0;

    feedList = List();
    filterList.add(FeedFilterType(isSelected: true, title: "All", type: 0));
    filterList
        .add(FeedFilterType(isSelected: false, title: "Challenges", type: 2));
    filterList.add(
        FeedFilterType(isSelected: false, title: "Transformations", type: 3));
    filterList.add(FeedFilterType(isSelected: false, title: "Recipe", type: 4));
    filterList
        .add(FeedFilterType(isSelected: false, title: "Discussions", type: 1));
    filterList
        .add(FeedFilterType(isSelected: false, title: "Updates", type: 5));
    selectedFilterType = filterList[0];

    reloadPage();
  }

  void reloadPage() {
    if (from == 0) {
      getUserProfileDetails();
      getUserFeed();
    } else {}
  }

  bool isProfileLoading = false;
  var profileId;
  UserProfile profile;

  bool isUserFeedLoading = false;

  int pageLimit = 10;
  int pageNo = 1;
  int type;
  List<Feed> feedList = [];
  bool feedLastPage = false;

  int postCount = 0;

  void getUserFeed() async {
    try {
      isUserFeedLoading = true;
      var response = await repository.getFeeds(
          pageNo, selectedFilterType.type, pageLimit,
          userProfileId: profileId);
      isUserFeedLoading = false;
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
      isUserFeedLoading = false;
      update();
    }
  }

  void followUser() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.followUnFollowUser(
          userProfileId: profileId, isFollow: 1);
      Utils.dismissLoadingDialog();
      if (response.status) {
        getUserProfileDetails();
      }
    } catch (e) {
      print("followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }

  void getFilteredFeed(int index) async {
    try {
      filterList.forEach((element) {
        element.isSelected = false;
      });
      selectedFilterType = filterList[index];
      selectedFilterType.isSelected = true;
      update();

      Utils.showLoadingDialog();

      var response =
          await repository.getFeeds(1, selectedFilterType.type, pageLimit);

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

  void getUserProfileDetails() async {
    try {
      isProfileLoading = true;
      var response =
          await repository.getUserProfileFromId(profileId: profileId);
      if (response.status) {
        profile = response.data;
        interest = response.data.userInterests;
        goals = response.data.userGoals;
      }
      this.isProfileLoading = false;
      update();
    } catch (e) {
      print("profile error : ${e.toString()}");
      isProfileLoading = false;
      update();
    }
  }

  bool showDivider() {
    if (profile.userInterests != null && profile.userInterests.length > 0) {
      return true;
    }
    if (profile.userGoals != null && profile.userGoals.length > 0) {
      return true;
    }

    if (profile.bio != null && profile.bio.toString().isNotEmpty) {
      return true;
    }
    return false;
  }

  List reports = [
    {"id": 1, "name": "Spam"},
    {"id": 2, "name": "Inappropriate"},
    {"id": 3, "name": "False Informarion"},
    {"id": 4, "name": "Violence"},
  ];

  int reportTagId = 0;

  TextEditingController problemTextEditController = TextEditingController();

  List<Widget> getUserReportList() {
    List<Widget> fitnessLevelWidgetList = [];
    int index = 0;
    for (var userReport in reports) {
      index++;
      fitnessLevelWidgetList.add(InkWell(
        onTap: () {
          reportTagId = userReport["id"];
          print("reportTagId : $reportTagId");
          print("index : $index");
          update();
        },
        child: CommonContainer(
            height: 31,
            width: Utils.getLength(userReport["name"], 14, FontFamily.poppins) +
                40,
            borderRadius: 24,
            backgroundColor: Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color:
                    reportTagId == index ? interestColor : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: userReport["name"],
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }
    return fitnessLevelWidgetList;
  }

  void reportUser() async {
    String problemDescription = problemTextEditController.text.toString();
    if (reportTagId == 0) {
      Utils.showErrorSnackBar("Please select problem");
    } else if (problemDescription.isEmpty) {
      Utils.showErrorSnackBar("Please write problem description");
    } else {
      try {
        Utils.showProgressLoadingDialog();
        var response = await repository.reportUser(
            userProfileId: profileId,
            reportTag: reportTagId,
            description: problemDescription);
        Utils.dismissLoadingDialog();
        if (response.status) {
          Get.back();
          Utils.showSucessSnackBar("Report Successfully");
        }
      } catch (e) {
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
      }
    }
  }

  void reportPost() async {
    String problemDescription = problemTextEditController.text.toString();
    if (reportTagId == 0) {
      Utils.showErrorSnackBar("Please select problem");
    } else if (problemDescription.isEmpty) {
      Utils.showErrorSnackBar("Please write problem description");
    } else {
      try {
        Utils.showProgressLoadingDialog();
        var response = await repository.reportPost(
            uniqueId: profileId,
            reportTag: reportTagId,
            type: type,
            description: problemDescription);
        Utils.dismissLoadingDialog();
        if (response.status) {
          Get.back();
          Utils.showSucessSnackBar("Report Successfully");
        } else {
          Utils.showErrorSnackBar(response.message);
        }
      } catch (e) {
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
      }
    }
  }

  void unFollowUser() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.followUnFollowUser(
          userProfileId: profileId, isFollow: 0);
      Utils.dismissLoadingDialog();
      if (response.status) {
        getUserProfileDetails();
        Get.back();
      }
    } catch (e) {
      print("un followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }

  void blockUser() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.blockUser(userProfileId: profileId);
      Utils.dismissLoadingDialog();
      if (response.status) {
        getUserProfileDetails();
        Get.find<HomeController>().reloadFeeds();
        Get.back();
        Utils.showSucessSnackBar("User profile block successfully");
      }
    } catch (e) {
      print("un followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }
}
