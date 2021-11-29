import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';

class DobSelectionView extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(initState: (value) {
      print("lastPageReached => ${_.lastPageReached}");
      if (_.lastPageReached == 1) {
        doOnStartup().then((value) {
          showDatePicker(context);
        });
      }
    }, builder: (build) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "What is your DOB?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(context);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 46),
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    _.dobValueLabel.value,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _.gotoHeightSelectionPage();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 131),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: primaryColor,
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
    });
  }

  showDatePicker(BuildContext context) {
    Picker(
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        columnPadding: EdgeInsets.only(bottom: 30),
        magnification: 1.5,
        hideHeader: false,
        adapter: DateTimePickerAdapter(yearBegin: 1905, yearEnd: 2015),
        height: 200,
        onConfirm: (Picker picker, List value) {
          print("(picker.adapter as DateTimePickerAdapter).value ${(picker.adapter as DateTimePickerAdapter).value}");
          _.setDob((picker.adapter as DateTimePickerAdapter).value);
        }).showModal(context);
  }
}
