import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  double height;
  double width;
  double borderRadius;

  double selectorHeight;
  double selectorWidth;
  double selectorRadius;

  bool isFirstTabValue;
  bool isSecondTabValue;

  Color backgroundColor;
  String firstTabName;
  String secondTabName;

  Function onClick;

  CustomSwitch(
      {this.height,
      this.width,
      @required this.firstTabName,
      @required this.secondTabName,
      this.onClick,
      this.borderRadius,
      this.selectorHeight,
      this.selectorWidth,
      this.selectorRadius,
      this.isFirstTabValue,
      this.backgroundColor,
      this.isSecondTabValue});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isFirstTabSelected = false;
  bool isSecondTabSelected = false;
  @override
  void initState() {
    super.initState();
    isFirstTabSelected = widget.isFirstTabValue;
    isSecondTabSelected = widget.isSecondTabValue;
  }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        height: widget.height,
        width: widget.width,
        backgroundColor: FFE0EAEE,
        borderRadius: widget.borderRadius,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                onFirsTabSelect();
              },
              child: Container(
                margin: EdgeInsets.only(left: 2),
                child: CommonContainer(
                    height: widget.selectorHeight,
                    width: widget.selectorWidth,
                    borderRadius: widget.selectorRadius,
                    backgroundColor:
                        isFirstTabSelected ? FF025074 : Colors.transparent,
                    child: CustomText(
                      text: widget.firstTabName,
                      textAlign: TextAlign.center,
                      color: isFirstTabSelected ? Colors.white : Colors.black,
                      size: 12,
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                onSecondTabSelect();
              },
              child: Container(
                margin: EdgeInsets.only(right: 2),
                child: CommonContainer(
                    height: widget.selectorHeight,
                    width: widget.selectorWidth,
                    borderRadius: widget.selectorRadius,
                    backgroundColor:
                        isSecondTabSelected ? FF025074 : Colors.transparent,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: widget.secondTabName,
                      color: isSecondTabSelected ? Colors.white : Colors.black,
                      size: 12,
                    )),
              ),
            )
          ],
        ));
  }

  onFirsTabSelect() {
    setState(() {
      this.isFirstTabSelected = true;
      this.isSecondTabSelected = false;
      widget.onClick(isFirstTabSelected, isSecondTabSelected);
    });
  }

  onSecondTabSelect() {
    setState(() {
      this.isFirstTabSelected = false;
      this.isSecondTabSelected = true;
      widget.onClick(isFirstTabSelected, isSecondTabSelected);
    });
  }
}
