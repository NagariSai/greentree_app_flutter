import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MenuOtherTile extends StatelessWidget {
  final String title;
  final String iconPath;

  const MenuOtherTile({Key key, this.title, this.iconPath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.08),
            blurRadius: 16,
            offset: Offset(
              0,
              2.0,
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: settingBgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 18,
                height: 18,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CustomText(
            text: title,
            color: titleBlackColor,
            size: 15,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
