import 'package:flutter/material.dart';

import 'my_plan_coach_row.dart';

class CompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return MyPlanCoachRow();
        },
        separatorBuilder: (context, position) {
          return SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
