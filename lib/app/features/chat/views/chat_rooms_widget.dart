import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/chat/my_chats_response.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/time_ago.dart';
import 'package:flutter/material.dart';

class ChatRoomWidget extends StatelessWidget {
  final VoidCallback onTap;
  final MyChat data;

  const ChatRoomWidget({Key key, this.onTap, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //color: const Color(0xffffffff),
        color: bodybgColor,
        child: Row(
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
                    CustomText(
                      text: data.fullName ?? "NA",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      color: titleBlackColor,
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
                  height: 2,
                ),
                data.chatType == 1 || data.chatType == 0
                    ? CustomText(
                        text: data.content ?? "",
                        size: 13,
                        color: FF1A98D3,
                        maxLines: 1,
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.photo,
                            size: 15,
                            color: FF1A98D3,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "Image",
                            size: 13,
                            color: FF1A98D3,
                            maxLines: 1,
                          )
                        ],
                      ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
