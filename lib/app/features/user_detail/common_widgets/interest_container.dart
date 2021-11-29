import 'package:flutter/material.dart';

class InterestContainer extends StatelessWidget {
  String label;
  bool isSelected;
  bool isColored;
  double borderRadius;
  Color backgroundColor;
  Decoration decoration;
  GestureTapCallback onTap;

  InterestContainer(
      {@required this.label,
      @required this.isSelected,
      this.isColored = false,
      this.backgroundColor = Colors.white,
      this.borderRadius = 24,
      this.decoration,
      this.onTap}) {
    if (this.decoration == null) {
      this.decoration = BoxDecoration(
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
      child: Container(
        decoration: this.decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(this.borderRadius),
          child: Container(
              color: isSelected ? this.backgroundColor : null,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                this.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : isColored
                          ? this.backgroundColor
                          : Colors.black,
                  fontSize: 15,
                ),
              )),
        ),
      ),
    );
  }
}
