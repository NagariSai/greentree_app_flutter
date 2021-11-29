import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NormalTextField extends StatelessWidget {
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
  final isEndIconImage;
  final endIconImage;
  final IconData preFixIcon;
  final bool showPrefixIcon;
  final double height;
  const NormalTextField(
      {Key key,
      this.isEndIconImage = false,
      this.endIconImage,
      this.inputType = TextInputType.text,
      this.hintText,
      this.controller,
      this.onChanged,
      this.onFieldSubmitted,
      this.onIconTap,
      this.focusNode,
      this.hintColor,
      this.inputFormatter,
      this.obscureText = false,
      this.showIcon = false,
      this.showPrefixIcon = false,
      this.bgColor = const Color(0xFFE4ECEF),
      this.cursorColor = Colors.white,
      this.autoFocus = false,
      this.showCursor = true,
      this.endIcon = FontAwesomeIcons.eye,
      this.preFixIcon = Icons.search,
      this.height = 36,
      this.textColor = primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
          fontSize: 16,
        ),
        autofocus: autoFocus,
        showCursor: showCursor,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          filled: true, // <- this is required.

          contentPadding: const EdgeInsets.only(top: 2),

          prefixIcon: showPrefixIcon
              ? Icon(
                  preFixIcon,
                  color: Colors.white,
                  size: 22,
                )
              : SizedBox(),
          suffixIcon: showIcon
              ? isEndIconImage
                  ? InkWell(
                      onTap: () {
                        onIconTap.call();
                      },
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: Image.asset(endIconImage)))
                  : IconButton(
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
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: bgColor,
      ),
    );
  }
}
