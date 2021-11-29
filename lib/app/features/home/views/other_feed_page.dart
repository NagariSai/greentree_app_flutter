import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/other_feed_controller.dart';
import 'package:fit_beat/app/features/home/views/feed_button.dart';
import 'package:fit_beat/app/features/home/views/other_feed_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherFeedPage extends StatelessWidget {
  var title = "";
  var count = 0;
  var uniqueId;
  var isChallenge = "false";
  @override
  Widget build(BuildContext context) {
    count = int.parse(Get.parameters["count"]);
    uniqueId = int.parse(Get.parameters["masterPostId"]);
    title = Get.parameters["title"] ?? "";
    isChallenge = Get.parameters["isChallenge"] ?? "false";

    return Scaffold(
      appBar: CustomAppBar(),
      body: GetBuilder<OtherFeedController>(
          init: OtherFeedController(
              repository: ApiRepository(apiClient: ApiClient()),
              uniqueId: uniqueId,
              isChallenge: isChallenge),
          builder: (_) {
            return _.isLoading
                ? Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()),
                  )
                : RefreshIndicator(
                    key: _.indicator,
                    onRefresh: _.reloadFeeds,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: isChallenge == "true"
                                            ? catYellowColor
                                            : catDarkGreenColor,
                                        shape: BoxShape.circle),
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Image.asset(
                                        isChallenge == "true"
                                            ? Assets.challengeIcon
                                            : Assets.discussionIcon,
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: title,
                                          color: titleBlackColor,
                                          size: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        CustomText(
                                          text:
                                              "${_.count} ${isChallenge == "true" ? "people tried this challenge" : "people are discussing on this"}",
                                          color: descriptionColor,
                                          size: 11,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FeedButton(
                                    label: isChallenge == "true"
                                        ? "Try Challenge"
                                        : "Start Discussion",
                                    onTap: () => Get.toNamed(Routes.addPost,
                                        parameters: {
                                          "postType":
                                              isChallenge == "true" ? "1" : "0",
                                          "title": title,
                                          "isOtherType": "true",
                                          "masterPostId": uniqueId.toString()
                                        }),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 4,
                              color: dividerColor,
                            ),
                            _.feedList.length > 0
                                ? ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _.feedList.length,
                                    itemBuilder: (context, index) {
                                      return OtherFeedWidget(
                                        feedData: _.feedList[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        thickness: 4,
                                        color: dividerColor,
                                      );
                                    },
                                  )
                                : Container(
                                    height: Get.height * 0.4,
                                    child: Center(
                                      child: CustomText(
                                        text: "No data found",
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
