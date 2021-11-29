import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RoundedCornerButton extends StatelessWidget {
  final IconData iconData;
  final String buttonText;
  final Function onPressed;
  final Color buttonColor;
  final Color iconAndTextColor;
  final Color borderColor;
  final double width;
  final double height;
  final double iconSize;
  final double radius;
  final double fontSize;
  final bool enableButton;
  final bool isIconWidget;
  final Widget iconWidget;
  final bool alignInCenter;

  RoundedCornerButton({
    this.iconData,
    @required this.buttonText,
    @required this.onPressed,
    @required this.buttonColor,
    @required this.iconAndTextColor,
    @required this.borderColor,
    this.alignInCenter = true,
    this.isIconWidget = false,
    this.iconWidget,
    this.width,
    this.height = 32,
    this.iconSize = 14,
    this.radius = 5,
    this.fontSize = 18,
    this.enableButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(width: 1.0, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: (iconData != null || isIconWidget)
            ? Center(
                child: Row(
                  mainAxisAlignment: alignInCenter
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    isIconWidget
                        ? iconWidget
                        : Icon(iconData,
                            color: iconAndTextColor, size: iconSize),
                    SizedBox(width: 5),
                    CustomText(
                      text: buttonText,
                      size: fontSize,
                      color: iconAndTextColor,
                    ),
                  ],
                ),
              )
            : CustomText(
                text: buttonText,
                size: fontSize,
                color: iconAndTextColor,
              ),
      ),
    );
  }
}
