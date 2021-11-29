import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  double height;
  double width;
  double borderRadius;
  Widget child;
  double shadowBlurRadius;
  Color shadowColor;
  Color backgroundColor;
  Decoration decoration;
  GestureTapCallback onTap;
  Key key;

  CommonContainer(
      {@required this.height,
      this.width,
      this.key,
      @required this.borderRadius,
      @required this.child,
      this.shadowBlurRadius = 28.0,
      this.shadowColor = const Color.fromRGBO(74, 83, 87, 0.16),
      this.backgroundColor = Colors.white,
      this.decoration,
      this.onTap}) {
    if (this.decoration == null) {
      this.decoration = BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
        BoxShadow(
          color: this.shadowColor,
          blurRadius: this.shadowBlurRadius,
          offset: Offset(
            0.0,
            8.0,
          ),
        )
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: this.onTap,
      child: Container(
        height: this.height,
        width: this.width,
        decoration: this.decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(this.borderRadius),
          child: Container(color: this.backgroundColor, child: this.child),
        ),
      ),
    );
  }
}
