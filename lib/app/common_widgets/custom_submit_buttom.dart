import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final Color shadowColor;
  final String text;
  final Color textColor;

  const CustomSubmitButton(
      {Key key,
      this.onTap,
      this.color = primaryColor,
      this.shadowColor = hintColor,
      this.textColor = Colors.white,
      this.text = "Submit"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 110, height: 50),
      child: ElevatedButton(
        child: CustomText(
          text: text,
          size: 15,
          color: textColor,
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
      ),
    );
  }
}
