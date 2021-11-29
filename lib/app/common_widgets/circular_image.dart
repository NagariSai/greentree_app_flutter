import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final bool isImageFile;
  final String imageFile;

  const CircularImage(
      {Key key,
      this.width = 38,
      this.height = 38,
      this.imageFile,
      this.isImageFile = false,
      this.imageUrl =
          "https://www.mcodedeveloper.com/babbel/demo/data/avatars/min1/cBxzZR64qTT.jpg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor), shape: BoxShape.circle),
      child: ClipOval(
        child: isImageFile
            ? Image.file(
                File(imageFile),
                fit: BoxFit.fill,
              )
            : CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  Assets.placeholder,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => Image.asset(
                  Assets.placeholder,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
