import 'dart:async';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final int viewCount;
  final int currentPage;
  final int totalPage;
  final int uniqueId;
  final int mediaId;

  const VideoWidget(
      {Key key,
      @required this.url,
      @required this.viewCount,
      @required this.currentPage,
      @required this.totalPage,
      this.uniqueId,
      this.mediaId})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  bool _sendVideoCount = false;

  var _seekTimer;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {

      //Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {
        videoPlayerController.pause();
      });
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              key: new PageStorageKey("${widget.url}${widget.currentPage}"),
              children: [
                GestureDetector(
                  onTap: toggleVideoPlayer,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: Colors.grey),
                    height: 243,
                    child: AspectRatio(
                      key: new PageStorageKey(
                          "${widget.url}${widget.currentPage}"),
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                ),
                videoCountUi(),
                mediaPageUi(),
                Center(
                    child: GestureDetector(
                  onTap: toggleVideoPlayer,
                  child: Icon(
                    videoPlayerController.value.isPlaying
                        ? Icons.pause_circle_outline_rounded
                        : Icons.play_circle_outline_outlined,
                    size: 42.0,
                    color: Colors.white,
                  ),
                ))
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
                text: "${widget.viewCount ?? 0}",
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
            text: "${widget.currentPage ?? 0}/${widget.totalPage ?? 0}",
            color: Colors.white,
            size: 11,
          )),
    );
  }

  _startSeekTimer() {
    _stopSeekTimer();
    _seekTimer =
        Timer.periodic(Duration(milliseconds: (1 * 1000).round()), (timer) {
      if (videoPlayerController?.value?.position?.inSeconds ==
          videoPlayerController?.value?.duration?.inSeconds) {
        timer.cancel();
      } else if ((videoPlayerController?.value?.isPlaying ?? false) &&
          !(videoPlayerController?.value?.isBuffering ?? false)) {
        sendVideoView();

//        isAtLive = isAtLivePosition();
//        _updateIsAtLive(isAtLive);
      }
    });
  }

  _stopSeekTimer() {
    _seekTimer?.cancel();
    _seekTimer = null;
  }

  void sendVideoView() {
    try {
      var ratio = videoPlayerController.value.position.inSeconds /
          videoPlayerController.value.duration.inSeconds;
      var fraction = ratio - ratio.floor();
      var percentage = 100 * fraction;
      debugPrint("percent $percentage");
      if (percentage >= 30.0) {
        if (!_sendVideoCount) {
          debugPrint("make api call $percentage");

          if (widget.uniqueId != null) {
            Get.find<MainController>()
                .sendPostVideoViewEvent(widget.uniqueId, widget.mediaId);
          }

          // showControls();
        }
        _sendVideoCount = true;
//        _showControls = true;
      } else {
        _sendVideoCount = false;
      }
    } catch (_) {
      debugPrint("percent error");
    }
  }

  void toggleVideoPlayer() {
    setState(() {
      if (videoPlayerController.value.isPlaying) {
        videoPlayerController.pause();
        _stopSeekTimer();
      } else {
        videoPlayerController.play();
        _startSeekTimer();
      }
    });
  }
}
