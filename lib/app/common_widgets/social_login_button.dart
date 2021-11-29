import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;

  const SocialLoginButton(
      {Key key, @required this.onTap, @required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 50, height: 50),
      child: ElevatedButton(
        child: Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: CircleBorder(side: BorderSide(color: lightWhiteColor)),
        ),
      ),
    );
  }
}
