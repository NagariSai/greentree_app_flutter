import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MessageType { sent, received }

class ChatMessage extends StatelessWidget {
  final String message;
  final MessageType messageType;
  final Color backgroundColor;
  final Color textColor;
  final String time;
  final double maxWidth;
  final double minWidth;
  final int chatType;

  ChatMessage(
      {this.message,
      @required this.messageType,
      this.backgroundColor,
      this.textColor,
      this.time,
      this.minWidth,
      this.maxWidth,
      this.chatType});

  MainAxisAlignment messageAlignment() {
    if (messageType == null || messageType == MessageType.received) {
      return MainAxisAlignment.start;
    } else {
      return MainAxisAlignment.end;
    }
  }

  double topLeftRadius() {
    if (messageType == null || messageType == MessageType.received) {
      return 0.0;
    } else {
      return 12.0;
    }
  }

  double topRightRadius() {
    if (messageType == null || messageType == MessageType.received) {
      return 12.0;
    } else {
      return 0.0;
    }
  }

  Color messageBgColor(BuildContext context) {
    if (messageType == MessageType.received) {
      return Colors.white;
    } else {
      return FFE8EFF2;
    }
  }

  Color messageTextColor(BuildContext context) {
    if (messageType == MessageType.received) {
      return titleBlackColor;
    } else {
      return titleBlackColor;
    }
  }

  CustomText messageTime() {
    return CustomText(
      text: "12:01 PM",
      size: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12.0,
      ),
      child: Row(
        mainAxisAlignment: messageAlignment(),
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /*if (messageType == MessageType.sent) ...[
            messageTime(),
            SizedBox(
              width: 8,
            ),
          ],*/
          Container(
            constraints: BoxConstraints(
                minWidth: minWidth ?? 100.0, maxWidth: maxWidth ?? 250.0),
            decoration: BoxDecoration(
              color: backgroundColor ?? messageBgColor(context),
              border: Border.all(color: FFE8EFF2),
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: chatType == 1
                ? CustomText(
                    text: message ?? "Message here...",
                    size: 14,
                    color: textColor ?? messageTextColor(context),
                    overflow: null)
                : GestureDetector(
                    onTap: () =>
                        Get.toNamed(Routes.imagePage, arguments: message),
                    child: CachedNetworkImage(
                      imageUrl: message,
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
          ),
          /*if (messageType == MessageType.received) ...[
            SizedBox(
              width: 8,
            ),
            messageTime(),
          ],*/
        ],
      ),
    );
  }
}
