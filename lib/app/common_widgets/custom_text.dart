import 'package:fit_beat/app/constant/font_family.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final TextAlign textAlign;
  final int maxLines;
  final FontWeight fontWeight;
  final TextOverflow overflow;

  const CustomText(
      {Key key,
      @required this.text,
      this.size,
      this.color,
      this.textAlign,
      this.maxLines,
      this.fontWeight = FontWeight.normal,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          fontFamily: FontFamily.poppins,
          decoration: TextDecoration.none),
    );
  }
}
