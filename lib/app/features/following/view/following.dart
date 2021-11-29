import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/data/model/user/user_follow.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/followers/view/follower_row.dart';
import 'package:fit_beat/app/features/following/controllers/following_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Following",
      ),
      body: GetBuilder<FollowingController>(
          init: FollowingController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _.isFollwingLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: CustomTextField(
                            hintText: "Search People",
                            height: 36,
                            prefixIcon: Icon(
                              Icons.search,
                              color: FF025074,
                            ),
                            hintColor: hintColor,
                            isPaddingRequired: false,
                            inputType: TextInputType.text,
                            showIcon: true,
                            endIcon: Icons.close,
                            bgColor: FFE0EAEE,
                            onChanged: (value) {},
                          ),
                        ),
                        Expanded(
                          child: _.userFollowingList.length > 0
                              ? ListView.separated(
                                  itemCount: _.userFollowingList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    UserFollow userFollower =
                                        _.userFollowingList[index];
                                    return FollowerRow(
                                      userFollow: userFollower,
                                      controller: _,
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
                                  child: Center(
                                      child: CustomText(
                                    text: "No Following Found",
                                    color: FF050707,
                                    size: 16,
                                  )),
                                ),
                        )
                      ],
                    ),
                  );
          }),
    );
  }
}
