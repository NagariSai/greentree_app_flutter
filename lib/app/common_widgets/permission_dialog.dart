import 'dart:io' show Platform;

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PermissionDialog {
  static void show(
    context,
    String heading,
    String subHeading,
    String positiveButtonText,
    Function onPressedPositive, {
    String negativeButtonText,
    Function onPressedNegative,
    bool showNegativeButton = true,
    bool isPositiveButtonDangerous = false,
  }) {
    if (Platform.isIOS) {
      // iOS-specific code
      showCupertinoDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) => CupertinoAlertDialog(
          title: _buildTitle(context, heading),
          content: _buildSubTitle(context, subHeading),
          actions: _buildActions(
            context,
            positiveButtonText,
            onPressedPositive,
            negativeButtonText,
            onPressedNegative,
            showNegativeButton,
            isPositiveButtonDangerous,
          ),
        ),
      );
    } else {
      showDialog(
        useRootNavigator: false,
        context: context,
        builder: (_) => AlertDialog(
          title: _buildTitle(context, heading),
          content: _buildSubTitle(context, subHeading),
          actions: _buildActions(
            context,
            positiveButtonText,
            onPressedPositive,
            negativeButtonText,
            onPressedNegative,
            showNegativeButton,
            isPositiveButtonDangerous,
          ),
        ),
      );
    }
  }

  static _buildTitle(context, String heading) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: CustomText(
          text: heading,
          size: 18,
          color: titleBlackColor,
        ));
  }

  static _buildSubTitle(context, String subHeading) {
    if (subHeading != null && subHeading.isNotEmpty) {
      return CustomText(text: subHeading, size: 14, color: titleBlackColor);
    }
    return SizedBox.shrink();
  }

  static List<Widget> _buildActions(
      context,
      String positiveButtonText,
      Function onPressedPositive,
      String negativeButtonText,
      Function onPressedNegative,
      bool showNegativeButton,
      bool isPositiveButtonDangerous) {
    return [
      if (showNegativeButton)
        FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            if (onPressedNegative != null) {
              onPressedNegative();
            } else {
              Navigator.pop(context);
            }
          },
          child: CustomText(
              text: negativeButtonText ?? 'Cancel',
              size: 14,
              color: isPositiveButtonDangerous ? titleBlackColor : errorColor,
              textAlign: TextAlign.center),
        ),
      FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressedPositive,
        child: CustomText(
            text: positiveButtonText,
            size: 14,
            color: isPositiveButtonDangerous ? errorColor : titleBlackColor,
            textAlign: TextAlign.center),
      ),
    ];
  }
}
