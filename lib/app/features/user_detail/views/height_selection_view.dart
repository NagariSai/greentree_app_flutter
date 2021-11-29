import 'dart:convert';

import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';

class HeightSelectionView extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(initState: (value) {
      print("lastPageReached => ${_.lastPageReached}");
      if (_.lastPageReached == 2) {
        doOnStartup().then((value) {
          showPicker(context, _);
        });
      }
    }, builder: (build) {
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "How tall are you?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (_.selectedHeightUnit.value != HEIGHT_UNIT.INCH) {
                          _.selectedHeight.value =
                              _.cm_to_foot(int.parse(_.selectedHeight.value));
                          _.selectedHeightUnit.value = HEIGHT_UNIT.INCH;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height: 42,
                          width: 100,
                          alignment: Alignment.center,
                          color: _.selectedHeightUnit.value == HEIGHT_UNIT.INCH
                              ? Colors.black
                              : unSelectedUnitColor,
                          child: Text(
                            "in",
                            style: TextStyle(
                                color: _.selectedHeightUnit.value ==
                                        HEIGHT_UNIT.INCH
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (_.selectedHeightUnit.value != HEIGHT_UNIT.CM) {
                          _.selectedHeight.value = _
                              .foot_to_cm(double.parse(_.selectedHeight.value));
                          _.selectedHeightUnit.value = HEIGHT_UNIT.CM;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height: 42,
                          width: 100,
                          alignment: Alignment.center,
                          color: _.selectedHeightUnit.value == HEIGHT_UNIT.CM
                              ? Colors.black
                              : unSelectedUnitColor,
                          child: Text(
                            "cm",
                            style: TextStyle(
                                color:
                                    _.selectedHeightUnit.value == HEIGHT_UNIT.CM
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showPicker(context, _);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 46),
                alignment: Alignment.center,
                child: Obx(() => _.selectedHeightUnit.value == HEIGHT_UNIT.CM
                    ? RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: _.selectedHeight.value,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "cm",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          )
                        ]),
                      )
                    : RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: _.selectedHeight.value[0],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "ft",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: _.selectedHeight.value.substring(
                                _.selectedHeight.value.indexOf(".") + 1,
                                _.selectedHeight.value.length),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "in",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          )
                        ]),
                      )),
              ),
            ),
            GestureDetector(
              onTap: () {
                _.gotoWeightSelectionPage();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 41),
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

  void showPicker(BuildContext context, UserDetailController _) {
    if (_.selectedHeightUnit.value == HEIGHT_UNIT.CM)
      showCMHeightPicker(context, _);
    else
      showFeetHeightPicker(context, _);
  }

  void showFeetHeightPicker(BuildContext context, UserDetailController _) {
    /*
    * min : 0 feet | 0 inches
    * max : 7 feet | 12 inches
    * */
    const Feet_Inches = '''
[
    [
        "4",
        "5",
        "6",
        "7"
    ],
    [
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11"
    ]
]
    ''';

    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: JsonDecoder().convert(Feet_Inches),
          isArray: true,
        ),
        selecteds: [
          int.parse(_.selectedHeight.value[0]) - 4,
          int.parse(_.selectedHeight.value.substring(
              _.selectedHeight.value.indexOf(".") + 1,
              _.selectedHeight.value.length))
        ],
        magnification: 1.5,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text("Feet"), Text("Inches")],
        )),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());

          selection(
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");

          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void showCMHeightPicker(BuildContext context, UserDetailController _) {
    /*
    * min : 0 cms
    * max : 244 cms
    * */

    var minCMs = 137;
    var CMs = new List<int>.generate(105, (i) => minCMs++);

    print("_.selectedHeight.value = ${_.selectedHeight.value}");
    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: CMs,
        ),
        selecteds: [int.parse(_.selectedHeight.value) - 137],
        magnification: 1.5,
        title: Text("Centimeters"),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selection(picker.getSelectedValues()[0].toString());
        }).showModal(context);
  }

  void selection(String value) {
    // String unitBaseValue;
    //
    // if (_.selectedHeightUnit.value == HEIGHT_UNIT.INCH) {
    //   double convertedValue = double.parse(value);
    //   if (convertedValue < 4.6) {
    //     unitBaseValue = "4.6 feet";
    //     _.selectedHeight.value = "4.6";
    //     Utils.showErrorSnackBar("Height cannot be less then $unitBaseValue",
    //         instantInit: false);
    //   } else if (convertedValue > 7.0) {
    //     unitBaseValue = "7.0 feet";
    //     _.selectedHeight.value = "7.0";
    //     Utils.showErrorSnackBar("Height cannot be more then $unitBaseValue",
    //         instantInit: false);
    //   } else {
    //     _.selectedHeight.value = value;
    //   }
    // }
    //
    // if (_.selectedHeightUnit.value == HEIGHT_UNIT.CM) {
    //   int convertedValue = int.parse(value);
    //   if (convertedValue < 137) {
    //     unitBaseValue = "137 cm";
    //     _.selectedHeight.value = "137";
    //     Utils.showErrorSnackBar("Height cannot be less then $unitBaseValue",
    //         instantInit: false);
    //   } else if (convertedValue > 213) {
    //     unitBaseValue = "213 cm";
    //     _.selectedHeight.value = "213";
    //     Utils.showErrorSnackBar("Height cannot be more then $unitBaseValue",
    //         instantInit: false);
    //   } else {
    //     _.selectedHeight.value = value;
    //   }
    // }

      _.selectedHeight.value = value;
  }
}
