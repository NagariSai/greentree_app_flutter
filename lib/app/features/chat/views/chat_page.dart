import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/chat/chat_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/chat/controllers/chat_controller.dart';
import 'package:fit_beat/app/features/chat/views/chat_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _messageIsPresent = false;
  final ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodybgColor,
        appBar: CustomAppBar(),
        body: GetBuilder<ChatController>(
            init: ChatController(
                repository: ApiRepository(apiClient: ApiClient())),
            builder: (_) {
              return _.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              CircularImage(
                                imageUrl: _.toUserProfileUrl,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: _.toUserName,
                                      size: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    /* SizedBox(
                        height: 2,
                      ),
                      CustomText(
                        text: "Active 9m ago",
                        size: 11,
                        color: descriptionColor,
                        fontWeight: FontWeight.w300,
                      ),*/
                                  ],
                                ),
                              ),
                              IconButton(
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: FFE4ECF0),
                                    width: 32,
                                    height: 32,
                                    child: Center(
                                      child: Icon(
                                        Icons.more_horiz,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {})
                            ],
                          ),
                        ),
                        Divider(
                          color: dividerColor,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            key: _.indicator,
                            onRefresh: _.reloadList,
                            child: _.chatList.length > 0
                                ? GroupedListView<ChatData, DateTime>(
                                    elements: _.chatList,
                                    order: GroupedListOrder.ASC,
                                    reverse: false,
                                    floatingHeader: true,
                                    groupBy: (ChatData element) =>
                                        element.createDatetime,
                                    groupHeaderBuilder: (ChatData element) =>
                                        Align(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CustomText(
                                          text:
                                              '${Utils.convertDateIntoFormattedString(element.createDatetime.toLocal())}',
                                          textAlign: TextAlign.center,
                                          color: FF55B5FE,
                                        ),
                                      ),
                                    ),
                                    itemBuilder: (_, ChatData element) {
                                      return ChatMessage(
                                        message: element.content,
                                        messageType:
                                            PrefData().getUserData().userId ==
                                                    element.firstUserId
                                                ? MessageType.sent
                                                : MessageType.received,
                                        chatType: element.chatType,
                                      );
                                    },
                                  )

                                /*ListView.builder(
                                    controller: listScrollController,
                                    padding: const EdgeInsets.all(16),
                                    itemCount: _.chatList.length,
                                    reverse: true,
                                    itemBuilder: (context, index) {
                                      return ChatMessage(
                                        message: _.chatList[index].content,
                                        messageType: PrefData()
                                                    .getUserData()
                                                    .userId ==
                                                _.chatList[index].firstUserId
                                            ? MessageType.sent
                                            : MessageType.received,
                                        chatType: _.chatList[index].chatType,
                                      );
                                    },
                                  )*/
                                : Center(
                                    child: CustomText(
                                      text: "Start chatting...",
                                    ),
                                  ),
                          ),
                        ),
                        // SafeArea(child: ),
                        _buildMessageInputBox(_),
                      ],
                    );
            }));
  }

  AnimatedCrossFade _switchBetweenSendAndAudioButton(
      ChatController chatController) {
    return AnimatedCrossFade(
      crossFadeState: _messageIsPresent
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: _buildSendButton(chatController),
      secondChild: Container(),
      duration: Duration(milliseconds: 300),
      alignment: Alignment.center,
    );
  }

  Widget _buildMessageInputBox(ChatController chatController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x12161729),
          spreadRadius: 2,
          blurRadius: 6,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ], color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                  color: FFE8EFF2, borderRadius: BorderRadius.circular(38)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Message…",
                        hintStyle: TextStyle(
                            color: descriptionColor,
                            fontFamily: FontFamily.poppins,
                            fontSize: 14.0),
                      ),
                      controller: chatController.textController,
                      onChanged: (s) {
                        setState(() {
                          _messageIsPresent = s.trim().isNotEmpty;
                        });
                      },
                    ),
                  ),
                  /*SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.attach_file,
                    color: primaryColor,
                    size: 22,
                  ),*/
                  SizedBox(
                    width: 18,
                  ),
                  if (!_messageIsPresent) ...[
                    InkWell(
                      onTap: () => onImageClick(chatController),
                      child: Icon(
                        Icons.photo,
                        color: primaryColor,
                        size: 22,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          _switchBetweenSendAndAudioButton(chatController),
        ],
      ),
    );
  }

  /* Widget _buildAudioButton() {
    return Container(
      height: 45,
      width: 45,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Hex005479,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.mic,
        color: Colors.white,
        size: 28,
      ),
    );
  }*/

  Widget _buildSendButton(ChatController chatController) {
    return InkWell(
      onTap: () => chatController.sendChat(),
      child: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.send,
          color: primaryColor,
          size: 24,
        ),
      ),
    );
  }

  void onImageClick(ChatController chatController) async {
    try {
      var file =
          await MediaPickerService().pickImage(source: ImageSource.gallery);

      if (file != null) {
        if (Utils.isFileImage(file)) {
          var result = await DialogUtils.mediaDialog();
          if (result) {
            chatController.sendMedia(file);
          }
        } else {
          Utils.showErrorSnackBar("Please select image");
        }
      } else {
        Utils.showErrorSnackBar("Please select image");
      }
    } catch (_) {
      Utils.showErrorSnackBar("Please select image");
    }
  }

  @override
  void initState() {
    super.initState();

    listScrollController.addListener(() {
      double maxScroll = listScrollController.position.maxScrollExtent;
      double currentScroll = listScrollController.position.pixels;
      if (maxScroll == currentScroll) {
        Get.find<ChatController>().loadNextFeed();
      }
    });
  }
}
