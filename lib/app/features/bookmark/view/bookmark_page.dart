import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/bookmark/controller/bookmark_controller.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GetX<BookMarkController>(
          init: BookMarkController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _.isLoading.value
                ? Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: CustomText(
                              text: "Bookmarks(${_.bookMarkCounter.value})",
                              size: 21,
                              color: FF050707,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          _.feedList.length > 0
                              ? ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _.feedList.length,
                                  itemBuilder: (context, index) {
                                    return FeedWidget(context,
                                      feedData: _.feedList[index],
                                      onClickLikeUnLike: () {
                                        _.reloadUserBookmarkList();
                                      },
                                      onClickBookmark: () {
                                        _.reloadUserBookmarkList();
                                      },
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
                  );
          }),
    );
  }
}
