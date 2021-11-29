import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/features/home/views/video_widget.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaSlidableWidget extends StatefulWidget {
  final List<UserMedia> mediaList;
  final bool isTransformation;
  final dynamic duration;
  final dynamic lostKg;

  MediaSlidableWidget(
      {Key key,
      this.mediaList,
      this.isTransformation = false,
      this.duration,
      this.lostKg})
      : super(key: key);

  @override
  _MediaSlidableWidgetState createState() => _MediaSlidableWidgetState();
}

class _MediaSlidableWidgetState extends State<MediaSlidableWidget> {
  final _controller = PageController();
  var currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 243,
        decoration: BoxDecoration(
          color: blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: PageView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (position) {
              setState(() {
                currentPage = position + 1;
              });
            },
            itemCount: widget.isTransformation ? 2 : widget.mediaList.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  key: PageStorageKey(currentPage),
                  borderRadius: BorderRadius.circular(10),
                  child: widget.isTransformation
                      ? GestureDetector(
                          onTap: () => Get.toNamed(Routes.imagePage,
                              arguments: index == 0
                                  ? widget.mediaList[index].mediaUrl
                                  : widget.mediaList[0].mediaUrl2),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: index == 0
                                    ? widget.mediaList[index].mediaUrl
                                    : widget.mediaList[0].mediaUrl2,
                                fit: BoxFit.cover,
                              ),
                              mediaPageUi(),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: bgTextColor.withOpacity(0.85),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Lost ${widget.lostKg.toString()} kg in ${widget.duration} months",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : widget.mediaList[index].mediaType == 1
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.toNamed(Routes.imagePage,
                                      arguments:
                                          widget.mediaList[index].mediaUrl),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.mediaList[index].mediaUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                mediaPageUi(),
                              ],
                            )
                          : VideoWidget(
                              url: widget.mediaList[index].mediaUrl,
                              currentPage: currentPage,
                              totalPage: widget.mediaList.length,
                              viewCount: widget.mediaList[index].viewCount,
                              uniqueId: widget.mediaList[index].globalId,
                              mediaId: widget.mediaList[index].userMediaId,
                            ));
            }));
  }

  Widget mediaPageUi() {
    return Positioned(
      left: 16,
      top: 16,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: titleBlackColor.withOpacity(0.68),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomText(
            text:
                "$currentPage/${widget.isTransformation ? "2" : widget.mediaList.length}",
            color: Colors.white,
            size: 11,
          )),
    );
  }
}
