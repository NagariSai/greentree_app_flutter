import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: new AlwaysStoppedAnimation<Color>(primaryColor)),
    );
  }
}
