import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/data/model/chat/invite_new_chat_user_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/chat/controllers/invite_user_to_chat_controller.dart';
import 'package:fit_beat/app/features/chat/views/invite_user_row.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class InviteUserToChatPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "New Chat",
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: CustomTextField(
                  controller: textController,
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
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      Get.find<InviteUserToChatController>()
                          .searchChatUsers("");
                    }
                    if (value.length > 2) {
                      Get.find<InviteUserToChatController>()
                          .searchChatUsers(value.trim());
                    }
                  },
                  onIconTap: () {
                    var controller = Get.find<InviteUserToChatController>();

                    if (textController.text != "") {
                      textController.clear();
                      controller.searchChatUsers("");
                    }
                  },
                ),
              ),
              GetBuilder<InviteUserToChatController>(
                  init: InviteUserToChatController(
                      repository: ApiRepository(apiClient: ApiClient())),
                  builder: (_) {
                    return _.isLoading
                        ? Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        : Expanded(
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          NewUserChat data = _.userList[index];

                                          return InviteUserRow(
                                            userData: data,
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            thickness: 0.4,
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
          ),
        ));
  }
}
