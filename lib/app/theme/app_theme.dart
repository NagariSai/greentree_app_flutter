import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/theme/app_colors.dart' as colors;
import 'package:flutter/material.dart';

final ThemeData appThemeData = new ThemeData(
    fontFamily: FontFamily.poppins,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(colors.blue[500].value, colors.blue),
    primaryColor: colors.blue[500],
    primaryColorBrightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    accentColor: colors.blue[500],
    accentColorBrightness: Brightness.light);
