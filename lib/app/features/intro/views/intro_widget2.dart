import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class IntroWidget2 extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;

  const IntroWidget2(
      {Key key,
      @required this.imagePath,
      @required this.title,
      @required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 250,
            height: 250,
          ),
          SizedBox(
            height: 40,
          ),
          CustomText(
            text: title,
            textAlign: TextAlign.center,
            size: 24,
            overflow: null,
            color: Colors.white,
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              textAlign: TextAlign.center,
              text: subTitle,
              size: 14,
              color: Colors.white,
              overflow: null,
            ),
          ),
        ],
      ),
    );
  }
}
