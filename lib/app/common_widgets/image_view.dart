import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var url = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(url),
      ),
    );
  }
}
