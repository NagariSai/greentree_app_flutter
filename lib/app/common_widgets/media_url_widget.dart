import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/home/views/video_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MediaUrlWidget extends StatefulWidget {
  final String mediaUrl;
  final VoidCallback onRemove;
  final double width;
  final String beforeAfterText;
  final double height;
  final int mediaType;
  final VoidCallback onTap;

  MediaUrlWidget(
      {Key key,
      this.mediaUrl,
      this.onRemove,
      this.onTap,
      this.width = 98,
      this.height = 100,
      this.mediaType = 1,
      this.beforeAfterText = ""})
      : super(key: key);

  @override
  _MediaUrlWidgetState createState() => _MediaUrlWidgetState();
}

class _MediaUrlWidgetState extends State<MediaUrlWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: widget.mediaUrl == null ? widget?.onTap : null,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: containerBgColor,
            ),
            child: widget.mediaUrl == null
                ? Center(
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    child: widget.mediaType == 1
                        ? CachedNetworkImage(imageUrl: widget.mediaUrl)
                        : VideoWidget(
                            url: widget.mediaUrl,
                            currentPage: 0,
                            totalPage: 1,
                            viewCount: 0,
                          )),
          ),
        ),
        if (widget.mediaUrl != null) ...[
          Positioned(
            right: -2,
            top: -2,
            child: InkWell(
                onTap: widget.onRemove,
                child: Image.asset(
                  Assets.removeIcon,
                  width: 38,
                  height: 38,
                )),
          )
        ],
        if (widget.beforeAfterText.isNotEmpty) ...[
          Positioned.fill(
              bottom: 8,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: widget.mediaUrl != null
                      ? BoxDecoration(
                          color: titleBlackColor.withOpacity(0.68),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  child: CustomText(
                    text: widget.beforeAfterText,
                    color: widget.mediaUrl == null
                        ? titleBlackColor
                        : Colors.white,
                    size: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ))
        ]
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
