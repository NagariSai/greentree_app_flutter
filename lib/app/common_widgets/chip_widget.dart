import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart' as colors;
import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onTap;
  final String title;

  const ChipWidget(
      {Key key,
      @required this.title,
      this.backgroundColor = colors.tagBgColor,
      this.textColor = colors.titleBlackColor,
      this.borderColor = colors.borderColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          border: Border.all(width: 1, color: this.borderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(24), //
          ),
        ),
        child: CustomText(
          text: title,
          color: textColor,
          size: 14,
        ),
      ),
    );
  }
}
