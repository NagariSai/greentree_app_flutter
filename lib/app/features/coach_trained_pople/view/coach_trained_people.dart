import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/data/model/coach_trained_people.dart';
import 'package:fit_beat/app/features/coach_trained_pople/controller/coach_trained_pople_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class CoachTrainedPeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoachTrainedPopleController>(builder: (_) {
      return Scaffold(
        appBar: CustomAppBar(
          title: "Trained People(${_.trainedPopleList.length})",
        ),
        body: LazyLoadScrollView(
          onEndOfPage: () => Get.find<CoachTrainedPopleController>().loadNext(),
          isLoading: Get.find<CoachTrainedPopleController>().feedLastPage,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: CustomTextField(
                  controller: _.trainedPeopleController,
                  hintText: "Search Trained People…",
                  height: 36,
                  /*prefixIcon: GestureDetector(
                    onTap: () {
                      _.trainedPeopleController.text = "";
                      _.clearSearch();
                    },
                    child: Icon(
                      Icons.search,
                      color: FF025074,
                    ),
                  ),*/
                  hintColor: hintColor,
                  isPaddingRequired: false,
                  inputType: TextInputType.text,
                  showIcon: true,
                  endIcon: Icons.close,
                  bgColor: FFE0EAEE,
                  onChanged: (String value) {
                    if (value.length > 1) {
                      _.getCoachTrainedPeopleData();
                    }
                  },
                ),
              ),
              Expanded(
                  child: GetBuilder<CoachTrainedPopleController>(builder: (_) {
                return _.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _.trainedPopleList.length > 0
                        ? ListView.separated(
                            itemCount: _.trainedPopleList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              CoachTrained people = _.trainedPopleList[index];

                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    CircularImage(
                                      height: 46,
                                      width: 46,
                                      imageUrl: people.profileUrl ?? "",
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(
                                              text: people.fullName ?? "",
                                              size: 16,
                                              fontWeight: FontWeight.w900,
                                              color: titleBlackColor,
                                            ),
                                            Spacer(),
                                            CustomText(
                                              text: Utils.convertDateIntoDisplayString(
                                                      people
                                                          .validUptoDatetime) ??
                                                  "",
                                              size: 11,
                                              fontWeight: FontWeight.w200,
                                              color: FF6D7274,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        CustomText(
                                          text: people.packageTitle ?? "",
                                          size: 11,
                                          fontWeight: FontWeight.w200,
                                          color: FF6D7274,
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 0.4,
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
                          );
              }))
            ],
          ),
        ),
      );
    });
  }
}
