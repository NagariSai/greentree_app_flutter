import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:flutter/material.dart';

class WhatBringYouHereContainer extends StatelessWidget {
  double height;
  double width;
  double borderRadius;
  Widget child;
  Color backgroundColor;
  String label;
  bool isSelected;
  double shadowBlurRadius;
  Decoration decoration;
  GestureTapCallback onTap;

  WhatBringYouHereContainer({
    @required this.height,
    @required this.width,
    @required this.borderRadius,
    @required this.child,
    @required this.backgroundColor,
    @required this.label,
    @required this.onTap,
    this.isSelected = false,
    this.shadowBlurRadius,
  }) {
    if (isSelected) {
      decoration = BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
        BoxShadow(
          color: backgroundColor.withOpacity(0.5),
          blurRadius: 10.0, // soften the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            5.0, // Move to bottom 5 Vertically
          ),
        )
      ]);
    } else {
      decoration = BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: 1, color: this.backgroundColor),
          borderRadius: BorderRadius.all(Radius.circular(24) //
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonContainer(
            height: this.height,
            width: this.width,
            borderRadius: this.borderRadius,
            child: this.child,
            shadowBlurRadius: this.shadowBlurRadius,
            shadowColor: this.backgroundColor,
            backgroundColor: isSelected ? this.backgroundColor : Colors.white,
            // backgroundColor: this.backgroundColor,
            decoration: this.decoration,
          ),
          Container(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              this.label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
