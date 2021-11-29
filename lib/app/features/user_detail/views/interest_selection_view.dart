import 'package:fit_beat/app/features/user_detail/common_widgets/interest_container.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestSelectionView extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              "Your interests",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 31),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [...generate(_)],
                ),
              ),
            ),
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                if ((_.selectedInterestId != null &&
                    _.selectedInterestId.isNotEmpty)) _.updateUserData();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 52),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: (_.selectedInterestId != null &&
                            _.selectedInterestId.isNotEmpty)
                        ? primaryColor
                        : Colors.grey,
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _.updateUserData();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: Text(
                  "I will do this later",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> generate(UserDetailController _) {
    return _.userDetailsOptionsEntity.value.data.masterInterests
        .map((e) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: InterestContainer(
                onTap: () {
                  print(
                      "_.isInterestSelected(e.masterBringId) => ${_.isInterestSelected(e.masterInterestId)}");
                  if (_.isInterestSelected(e.masterInterestId)) {
                    _.selectedInterestId.remove(e.masterInterestId);
                  } else {
                    _.selectedInterestId.add(e.masterInterestId);
                  }
                },
                isSelected: _.isInterestSelected(e.masterInterestId),
                backgroundColor: interestColor,
                label: e.title,
              ),
            ))
        .toList();
  }
}
