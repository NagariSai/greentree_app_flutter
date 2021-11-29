import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DummyMediaSlidableWidget extends StatefulWidget {
  final List<dynamic> mediaList;

  DummyMediaSlidableWidget({Key key, this.mediaList}) : super(key: key);

  @override
  _DummyMediaSlidableWidgetState createState() =>
      _DummyMediaSlidableWidgetState();
}

class _DummyMediaSlidableWidgetState extends State<DummyMediaSlidableWidget> {
  final _controller = PageController();
  VideoPlayerController videoPlayerController;
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
                if (position.isEven) {
                  videoPlayerController.pause();
                }
              });
            },
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: index.isEven
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.mediaList[0],
                              fit: BoxFit.cover,
                            ),
                            mediaPageUi(),
                          ],
                        )
                      : videoPlayerController != null &&
                              videoPlayerController.value.initialized
                          ? Stack(children: [
                              GestureDetector(
                                onTap: () {
                                  // Wrap the play or pause in a call to `setState`. This ensures the
                                  // correct icon is shown.
                                  setState(() {
                                    // If the video is playing, pause it.
                                    if (videoPlayerController.value.isPlaying) {
                                      videoPlayerController.pause();
                                    } else {
                                      // If the video is paused, play it.
                                      videoPlayerController.play();
                                    }
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 243,
                                  child: AspectRatio(
                                    aspectRatio:
                                        videoPlayerController.value.aspectRatio,
                                    child: VideoPlayer(videoPlayerController),
                                  ),
                                ),
                              ),
                              videoCountUi(),
                              mediaPageUi(),
                              Center(
                                  child: videoPlayerController.value.isPlaying
                                      ? SizedBox()
                                      : Image.asset(
                                          Assets.playIcon,
                                          width: 42.0,
                                          height: 42,
                                        ))
                            ])
                          : Container());
            }));
  }

  void initPlayer() {
    videoPlayerController = VideoPlayerController.network(widget.mediaList[1])
      ..initialize().then((_) {
        setState(() {
          videoPlayerController.pause();
        });
      });
  }

  Widget videoCountUi() {
    return Positioned(
      right: 16,
      top: 16,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: titleBlackColor.withOpacity(0.68),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                Assets.videoCountIcon,
                width: 16,
                height: 16,
              ),
              SizedBox(
                width: 4,
              ),
              CustomText(
                text: "240",
                color: Colors.white,
                size: 11,
              ),
            ],
          )),
    );
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
            text: "$currentPage/5",
            color: Colors.white,
            size: 11,
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }
}
