import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/menu/category_fourthlet.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryFourthlet data;

  const CategoryWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      width: 102,
      height: 122,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.08),
            blurRadius: 22,
            offset: Offset(
              0,
              4.0,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: data.bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: data.shadowColor,
                  blurRadius: 16,
                  offset: Offset(
                    0.0,
                    6.0,
                  ),
                )
              ],
            ),
            child: Center(
              child: Image.asset(
                data.icon,
                width: 16,
                height: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            text: data.title,
            size: 13,
            color: titleBlackColor,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
