import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorMessage;

  const ErrorText({Key key, @required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return errorMessage.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 2),
            child: CustomText(
              text: errorMessage,
              color: errorColor,
              size: 14,
              fontWeight: FontWeight.w300,
            ),
          )
        : SizedBox();
  }
}
