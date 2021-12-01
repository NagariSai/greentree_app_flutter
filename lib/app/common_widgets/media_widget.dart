import 'dart:io';
import 'dart:typed_data';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
//import 'package:video_thumbnail/video_thumbnail.dart';

class MediaWidget extends StatefulWidget {
  final File mediaFile;
  final VoidCallback onRemove;
  final double width;
  final String beforeAfterText;
  final double height;
  final VoidCallback onTap;

  MediaWidget(
      {Key key,
      this.mediaFile,
      this.onRemove,
      this.onTap,
      this.width = 98,
      this.height = 100,
      this.beforeAfterText = ""})
      : super(key: key);

  @override
  _MediaWidgetState createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  Uint8List uint8list;
  String videoDuration = "";
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: widget.mediaFile == null ? widget?.onTap : null,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: containerBgColor,
            ),
            child: widget.mediaFile == null
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
                    child: Utils.isFileImage(widget.mediaFile)
                        ? Image.file(
                            widget.mediaFile,
                            fit: BoxFit.cover,
                          )
                        : uint8list != null
                            ? Image.memory(
                                uint8list,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: containerBorderColor,
                              ),
                  ),
          ),
        ),
        if (widget.mediaFile != null) ...[
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
        if (videoDuration.isNotEmpty) ...[
          Positioned(
            right: 4,
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
              decoration: BoxDecoration(
                color: titleBlackColor.withOpacity(0.68),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomText(
                text: videoDuration,
                color: Colors.white,
                size: 11,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
        if (widget.beforeAfterText.isNotEmpty) ...[
          Positioned.fill(
              bottom: 8,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: widget.mediaFile != null
                      ? BoxDecoration(
                          color: titleBlackColor.withOpacity(0.68),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  child: CustomText(
                    text: widget.beforeAfterText,
                    color: widget.mediaFile == null
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

 /* void getThumbnail() async {
    uint8list = await VideoThumbnail.thumbnailData(
      video: widget.mediaFile.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          98, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 75,
    );

    var data = await FlutterVideoInfo().getVideoInfo(widget.mediaFile.path);

    setState(() {
      videoDuration = Utils.formatVideoDuration(data.duration);
    });
  }*/

  @override
  void initState() {
    super.initState();
   // if (widget.mediaFile != null && !Utils.isFileImage(widget.mediaFile))
    //  getThumbnail();
  }
}
