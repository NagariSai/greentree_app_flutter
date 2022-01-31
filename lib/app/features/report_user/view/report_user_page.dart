import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/features/user_profile/controller/user_profile_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class ReportUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: "Report",
      ),
      body: GetBuilder<UserProfileController>(
          init: UserProfileController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Kindly Select the problem",
                      size: 16,
                      color: FF050707,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _.getUserReportList(),
                    ),
                    const SizedBox(height: 16),
                    CommonContainer(
                      height: 144,
                      borderRadius: 8,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: FFC4CACC,
                            width: 1,
                          ),
                          color: FFC4CACC,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomText(
                              text: "Other",
                              size: 16,
                              color: FF050707,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 80,
                            child: TextField(
                              controller: _.problemTextEditController,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Write problem here...',
                                  hintStyle: TextStyle(
                                      color: FFBDC5C5,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: FontFamily.poppins,
                                      decoration: TextDecoration.none)),
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    RoundedCornerButton(
                      height: 50,
                      buttonText: "Submit",
                      buttonColor: FF025074,
                      borderColor: FF025074,
                      fontSize: 15,
                      radius: 6,
                      isIconWidget: false,
                      iconAndTextColor: Colors.white,
                      iconData: null,
                      onPressed: () {
                        if (_.from == 0) {
                          _.reportUser();
                        } else {
                          _.reportPost();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
