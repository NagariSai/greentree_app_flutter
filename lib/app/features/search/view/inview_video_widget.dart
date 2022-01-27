import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:video_player/video_player.dart';

class InViewVideoWidget extends StatefulWidget {
  final Feed feedData;
  final bool play;


  final int viewCount;
  final int currentPage;
  final int totalPage;
  final int uniqueId;
  final int mediaId;
  const InViewVideoWidget(
      {Key key,
        @required this.play,
        @required this.feedData,
        @required this.viewCount,
        @required this.currentPage,
        @required this.totalPage,
        this.uniqueId,
        this.mediaId})
      : super(key: key);
 // const InViewVideoWidget({key,  this.url,  this.play}): super(key: key);
  @override
  _InViewVideoWidgetState createState() => _InViewVideoWidgetState();
}

class _InViewVideoWidgetState extends State<InViewVideoWidget> {
   VideoPlayerController _controller;
   Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.feedData.userMedia[0].mediaUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(InViewVideoWidget oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {

          return Stack(
            key: new PageStorageKey("${widget.feedData.userMedia[0].mediaUrl}${widget.currentPage}"),
            children: [
              GestureDetector(
                onTap:  ()
                {
                  Utils.selectedfeedData=widget.feedData;
                  Get.toNamed(Routes.searchDetailsPage);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.grey),
                  height: 243,
                  child: AspectRatio(
                    key: new PageStorageKey(
                        "${widget.feedData.userMedia[0].mediaUrl}${widget.currentPage}"),
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
             // videoCountUi(),
             // mediaPageUi(),
              Center(
                  child: GestureDetector(
                    onTap: ()
                    {
                      Utils.selectedfeedData=widget.feedData;
                      Get.toNamed(Routes.searchDetailsPage);
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle_outline_rounded
                          : Icons.play_circle_outline_outlined,
                      size: 42.0,
                      color: Colors.white,
                    ),
                  ))
            ],
          );

          return VideoPlayer(_controller);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
