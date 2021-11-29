import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType inputType;
  final String hintText;
  final TextEditingController controller;
  final Function onChanged;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function onIconTap;
  final Color hintColor;
  final inputFormatter;
  final bool obscureText;
  final bool showIcon;
  final Color bgColor;
  final Color cursorColor;
  final bool autoFocus;
  final bool showCursor;
  final Color textColor;
  final IconData endIcon;
  final double height;
  final double width;
  final Widget prefixIcon;
  final bool isPaddingRequired;
  final dynamic maxlines;
  const CustomTextField(
      {Key key,
      this.inputType = TextInputType.text,
      this.hintText,
      this.height = 50,
      this.width,
      this.isPaddingRequired = true,
      this.controller,
      this.onChanged,
      this.onFieldSubmitted,
      this.onIconTap,
      this.focusNode,
      this.hintColor,
      this.inputFormatter,
      this.obscureText = false,
      this.showIcon = false,
      this.prefixIcon,
      this.bgColor = const Color(0xFFE4ECEF),
      this.cursorColor = Colors.white,
      this.autoFocus = false,
      this.showCursor = true,
      this.maxlines = 1,
      this.endIcon = FontAwesomeIcons.eye,
      this.textColor = primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: isPaddingRequired
              ? bgColor == primaryColor
                  ? 0
                  : 16
              : 0),
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onFieldSubmitted,
        controller: controller,
        focusNode: focusNode,
        cursorColor: cursorColor,
        keyboardType: inputType,
        obscureText: obscureText,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
        ),
        autofocus: autoFocus,
        maxLines: maxlines,
        showCursor: showCursor,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          prefixIcon: prefixIcon ?? null,
          suffixIcon: showIcon
              ? IconButton(
                  icon: Icon(
                    obscureText ? FontAwesomeIcons.eyeSlash : endIcon,
                    color: primaryColor,
                  ),
                  onPressed: onIconTap,
                )
              : SizedBox(),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 16,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: bgColor,
          border: Border.all(
              color: bgColor == primaryColor ? primaryColor : FFC4CACC,
              width: bgColor == primaryColor ? 1.0 : 0.4)),
    );
  }
}
