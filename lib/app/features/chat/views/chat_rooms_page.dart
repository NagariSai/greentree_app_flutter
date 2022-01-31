import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/chat/controllers/chat_rooms_controller.dart';
import 'package:fit_beat/app/features/chat/views/chat_rooms_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ChatRoomsPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
        appBar: AppBar(
          backgroundColor: appbgColor,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 28,

            ),
            onPressed: () => Get.back(),
            color: Colors.white,
          ),
          title: null,
          actions: [
            IconButton(

                icon: Image.asset(

                  Assets.friendsIcon,
                  color: bottombgColor,
                  width: 24,
                  height: 24,
                ),

                onPressed: () => Get.toNamed(Routes.chatRequestPage)),
            IconButton(

                icon: Image.asset(
                  Assets.newChatIcon,
                  color: bottombgColor,
                  width: 24,
                  height: 24,
                ),

                onPressed: () => Get.toNamed(Routes.inviteUserToChatPage))
          ],
        ),
        body:
    Container(
      color: bodybgColor,
      child:
        Column(


          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              child: CustomText(
                text: "Chats",
                color: titleBlackColor,
                fontWeight: FontWeight.w600,
                size: 21,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: NormalTextField(
                controller: textController,
                bgColor: settingBgColor,
                showPrefixIcon: true,
                hintColor: descriptionColor,
                hintText: "Search",
                onChanged: (String value) {
                  if (value.isEmpty) {
                    Get.find<ChatRoomsController>().searchChatUsers("");
                  }

                  if (value.length > 2) {
                    Get.find<ChatRoomsController>()
                        .searchChatUsers(value.trim());
                  }
                },
                onIconTap: () {
                  var controller = Get.find<ChatRoomsController>();

                  if (textController.text != "") {
                    textController.clear();
                    controller.searchChatUsers("");
                  }
                },
                showIcon: true,
                endIcon: Icons.close,
              ),
            ),
            GetBuilder<ChatRoomsController>(
                init: ChatRoomsController(
                    repository: ApiRepository(apiClient: ApiClient())),
                builder: (_) {
                  return _.isLoading
                      ? Flexible(
                          child: Center(child: CircularProgressIndicator()))
                      : Flexible(
                          fit: FlexFit.loose,
                          child: _.userList.length > 0
                              ? LazyLoadScrollView(
                                  onEndOfPage: () => _.loadNextFeed(),
                                  isLoading: _.feedLastPage,
                                  child: RefreshIndicator(
                                    key: _.indicator,
                                    onRefresh: _.reloadList,
                                    child: ListView.separated(
                                      itemCount: _.userList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ChatRoomWidget(
                                            data: _.userList[index],
                                            onTap: () async {
                                              await Get.toNamed(Routes.chatPage,
                                                  arguments: [
                                                    _.userList[index].userId,
                                                    _.userList[index].fullName,
                                                    _.userList[index]
                                                        .profileUrl,
                                                    _.userList[index]
                                                        .userChatConnectionId,
                                                  ]);
                                              _.reloadPage();
                                            });
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: dividerColor,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Center(
                                      child: CustomText(
                                    text: "No Data Found",
                                    color: FF050707,
                                    size: 16,
                                  )),
                                ),
                        );
                }),
          ],
        ))
    );
  }
}
