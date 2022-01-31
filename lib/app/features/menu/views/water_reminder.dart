import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/features/todaySchedule/view/water_page.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WaterReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: "Water",
      ),
      body: WaterPage(),
    );
  }
}
