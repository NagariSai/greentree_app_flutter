import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/data/model/chat/chat_request_response.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/time_ago.dart';
import 'package:flutter/material.dart';

class ChatRequestRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onAccept;
  final ChatRequestData data;
  final bool isReceived;

  const ChatRequestRow(
      {Key key,
      this.onCancel,
      this.onAccept,
      @required this.data,
      @required this.isReceived})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
      color: const Color(0xffffffff),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: catBlueColor.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ]),
            child: CircularImage(
              width: 46,
              height: 46,
              imageUrl: data.profileUrl ?? "",
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: data.fullName,
                      size: 16,
                      fontWeight: FontWeight.w600,
                      color: titleBlackColor,
                    ),
                  ),
                  CustomText(
                    text:
                        "${TimeAgoExtension.displayTimeAgoFromTimestamp(data.createDatetime.toLocal().toIso8601String())}",
                    size: 13,
                    color: descriptionColor,
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              CustomText(
                text: data.msg,
                size: 14,
                color: FF7D8283,
                maxLines: 1,
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  RoundedCornerButton(
                    height: 29,
                    width: 88,
                    buttonText: "Cancel",
                    buttonColor: FFFFFFFF,
                    borderColor: FF025074,
                    fontSize: 14,
                    radius: 6,
                    isIconWidget: false,
                    iconAndTextColor: FF025074,
                    iconData: null,
                    onPressed: onCancel,
                  ),
                  if (isReceived) ...[
                    SizedBox(
                      width: 20,
                    ),
                    RoundedCornerButton(
                      height: 29,
                      width: 88,
                      buttonText: "Accept",
                      buttonColor: FF6BD295,
                      borderColor: FF6BD295,
                      fontSize: 14,
                      radius: 6,
                      isIconWidget: false,
                      iconAndTextColor: Colors.white,
                      iconData: null,
                      onPressed: onAccept,
                    ),
                  ]
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
