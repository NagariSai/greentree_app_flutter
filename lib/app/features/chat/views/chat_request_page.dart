import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_tab_indicator.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/chat/chat_request_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/chat/controllers/chat_request_controller.dart';
import 'package:fit_beat/app/features/chat/views/chat_request_row.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRequestPage extends StatefulWidget {
  @override
  _ChatRequestPageState createState() => _ChatRequestPageState();
}

class _ChatRequestPageState extends State<ChatRequestPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> tabs = <Widget>[
    Container(height: 44, width: Get.width / 2, child: Tab(text: "Received")),
    Container(height: 44, width: Get.width / 2, child: Tab(text: "Sent")),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Chat Requests",
      ),
      body: GetBuilder<ChatRequestController>(
          init: ChatRequestController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return Column(
              children: [
                SizedBox(height: 4),
                CommonContainer(
                  height: 44,
                  width: Get.width,
                  borderRadius: 38,
                  backgroundColor: FFE0EAEE,
                  child: TabBar(
                    isScrollable: false,
                    unselectedLabelColor: FF6D7274,
                    labelColor: FF050707,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: CustomTabIndicator(
                      indicatorHeight: 31.0,
                      indicatorColor: FFFFFFFF,
                      indicatorRadius: 40,
                    ),
                    tabs: tabs,
                    controller: _tabController,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _.isReceivedLoading
                          ? Center(child: CircularProgressIndicator())
                          : _.receivedList.length > 0
                              ? ListView.separated(
                                  itemCount: _.receivedList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ChatRequestData data =
                                        _.receivedList[index];

                                    return ChatRequestRow(
                                      data: data,
                                      onAccept: () =>
                                          _.onAccept(data.userChatConnectionId),
                                      onCancel: () => _.onCancel(
                                          data.userChatConnectionId, true),
                                      isReceived: true,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      thickness: 0.4,
                                      color: dividerColor,
                                    );
                                  },
                                )
                              : Center(
                                  child: Container(
                                    child: CustomText(
                                      text: "No Request found",
                                    ),
                                  ),
                                ),
                      _.isSentLoading
                          ? Center(child: CircularProgressIndicator())
                          : _.sentList.length > 0
                              ? ListView.separated(
                                  itemCount: _.sentList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ChatRequestData data = _.sentList[index];

                                    return ChatRequestRow(
                                      isReceived: false,
                                      data: data,
                                      onCancel: () => _.onCancel(
                                          data.userChatConnectionId, false),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      thickness: 0.4,
                                      color: dividerColor,
                                    );
                                  },
                                )
                              : Center(
                                  child: Container(
                                    child: CustomText(
                                      text: "No Request found",
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
