import 'package:fit_beat/app/common_widgets/app_logo_widget.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IntroWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          AppLogoWidget(
            showWhiteBgLogo: true,
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            text: Strings.appName,
            size: 30,
            color: appNameColor,
            overflow: null,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          CustomText(
            text: 'Welcome to FitBeat',
            textAlign: TextAlign.center,
            size: 24,
            color: Colors.white,
            overflow: null,
          ),
          SizedBox(
            height: 4,
          ),
          CustomText(
            text: 'One platform Solution for your fitness!',
            size: 14,
            color: Colors.white,
            textAlign: TextAlign.center,
            overflow: null,
          ),
        ],
      ),
    );
  }
}
