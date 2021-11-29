import 'package:fit_beat/app/features/my_plan_coach/my_plan_coach_row.dart';
import 'package:flutter/material.dart';

class OnGoingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return MyPlanCoachRow();
        },
      ),
    );
  }
}
