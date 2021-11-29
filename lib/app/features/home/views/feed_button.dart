import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FeedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const FeedButton({Key key, @required this.label, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: CustomText(
          text: label,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }
}
