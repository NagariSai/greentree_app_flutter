import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach_home/controller/coach_my_post_controller.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class CoachMyPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoachMyPostController>(
        init: CoachMyPostController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return _.isLoading
              ? Center(child: CircularProgressIndicator())
              : _.feedList.length > 0
                  ? LazyLoadScrollView(
                      onEndOfPage: () => _.loadNextFeed(),
                      isLoading: _.feedLastPage,
                      child: ListView.separated(
                        itemCount: _.feedList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FeedWidget(
                            feedData: _.feedList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 4,
                            color: dividerColor,
                          );
                        },
                      ),
                    )
                  : Container(
                      height: Get.height * 0.4,
                      child: Center(
                        child: CustomText(
                          text: "No data found",
                        ),
                      ),
                    );
        });
  }
}
