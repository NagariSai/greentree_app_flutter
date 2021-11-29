import 'package:fit_beat/app/constant/assets.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final bool showWhiteBgLogo;
  final double width;
  final double height;

  const AppLogoWidget(
      {Key key,
      this.showWhiteBgLogo = false,
      this.width = 80,
      this.height = 80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      showWhiteBgLogo ? Assets.appLogoWhiteBg : Assets.appLogoBlueBg,
      width: width,
      height: height,
    );
  }
}
