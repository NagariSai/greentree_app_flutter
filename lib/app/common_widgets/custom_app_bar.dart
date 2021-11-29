import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String positiveText;
  final String negativeText;
  final VoidCallback onPositiveTap;
  final VoidCallback onNegativeTap;
  final VoidCallback onBackPressClick;
  final String title;
  final Color positiveTextColor;
  final double elevation;

  CustomAppBar(
      {Key key,
      this.title,
      this.positiveText,
      this.negativeText,
      this.onPositiveTap,
      this.onBackPressClick,
      this.onNegativeTap,
      this.positiveTextColor = primaryColor,
      this.elevation = 0})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      elevation: elevation,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          size: 28,
        ),
        onPressed: () {
          Utils.dismissKeyboard();
          if (onBackPressClick == null) {
            Get.back();
          } else {
            onBackPressClick.call();
          }
        },
        color: primaryColor,
      ),
      title: title != null
          ? CustomText(
              text: title,
              size: 20,
              color: FF050707,
              fontWeight: FontWeight.bold,
            )
          : null,
      actions: [
        negativeText != null
            ? TextButton(
                onPressed: onNegativeTap,
                child: CustomText(
                  text: negativeText,
                  color: primaryColor,
                  size: 16,
                ),
              )
            : Container(),
        positiveText != null
            ? TextButton(
                onPressed: onPositiveTap,
                child: CustomText(
                  text: positiveText,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  size: 16,
                ),
              )
            : Container(),
      ],
    );
  }
}
