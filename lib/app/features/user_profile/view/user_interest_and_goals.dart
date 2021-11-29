import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/features/user_profile/controller/user_profile_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class UserInterestAndGoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(builder: (_) {
      return Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            _.interest.length > 0
                ? CustomText(
                    text: "Interests",
                    size: 12,
                    fontWeight: FontWeight.normal,
                    color: FF6D7274,
                  )
                : Container(),
            _.interest.length > 0 ? const SizedBox(height: 5) : Container(),
            _.interest.length > 0
                ? Container(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _.interest.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Chip(
                              shape: StadiumBorder(
                                  side: BorderSide(color: borderColor)),
                              label: Text(_.interest[index].title),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              backgroundColor: Colors.white,
                            ),
                          );
                        }),
                  )
                : Container(),
            _.goals.length > 0 ? const SizedBox(height: 12) : Container(),
            _.goals.length > 0
                ? CustomText(
                    text: "Goals",
                    size: 12,
                    fontWeight: FontWeight.normal,
                    color: FF6D7274,
                  )
                : Container(),
            _.goals.length > 0 ? const SizedBox(height: 5) : Container(),
            _.goals.length > 0
                ? Container(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _.goals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _.goals[index].title != null
                              ? Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Chip(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: _.colorsCode[
                                                index.isEven ? 0 : 1])),
                                    label: Text(_.goals[index].title ?? ""),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    backgroundColor:
                                        _.colorsCode[index.isEven ? 0 : 1],
                                  ),
                                )
                              : SizedBox();
                        }),
                  )
                : Container(),
            _.profile.bio != null && _.profile.bio.toString().isNotEmpty
                ? const SizedBox(height: 16)
                : Container(),
            _.profile.bio != null && _.profile.bio.toString().isNotEmpty
                ? CustomText(
                    text: "Bio",
                    size: 12,
                    fontWeight: FontWeight.normal,
                    color: FF6D7274,
                  )
                : Container(),
            _.profile.bio != null && _.profile.bio.toString().isNotEmpty
                ? const SizedBox(height: 5)
                : Container(),
            _.profile.bio != null && _.profile.bio.toString().isNotEmpty
                ? CustomText(
                    text: "${_.profile.bio ?? ""}",
                    size: 14,
                    fontWeight: FontWeight.normal,
                    color: FF050707,
                  )
                : Container(),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }
}
