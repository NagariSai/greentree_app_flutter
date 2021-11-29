import 'dart:convert';

import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';

class WeightSelectionView extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(initState: (value) {
      print("lastPageReached => ${_.lastPageReached}");
      if (_.lastPageReached == 3) {
        doOnStartup().then((value) {
          showPicker(context, _);
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
                "Your current weight",
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
                        if (_.selectedWeightUnit.value != WEIGHT_UNIT.LB) {
                          _.selectedWeight.value =
                              _.kg_to_lb(double.parse(_.selectedWeight.value));
                          _.selectedWeightUnit.value = WEIGHT_UNIT.LB;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height: 42,
                          width: 100,
                          alignment: Alignment.center,
                          color: _.selectedWeightUnit.value == WEIGHT_UNIT.LB
                              ? Colors.black
                              : unSelectedUnitColor,
                          child: Text(
                            "lb",
                            style: TextStyle(
                                color:
                                    _.selectedWeightUnit.value == WEIGHT_UNIT.LB
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
                        if (_.selectedWeightUnit.value != WEIGHT_UNIT.KG) {
                          _.selectedWeight.value =
                              _.lb_to_kg(int.parse(_.selectedWeight.value));
                          _.selectedWeightUnit.value = WEIGHT_UNIT.KG;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height: 42,
                          width: 100,
                          alignment: Alignment.center,
                          color: _.selectedWeightUnit.value == WEIGHT_UNIT.KG
                              ? Colors.black
                              : unSelectedUnitColor,
                          child: Text(
                            "kg",
                            style: TextStyle(
                                color:
                                    _.selectedWeightUnit.value == WEIGHT_UNIT.KG
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_.selectedWeightUnit.value == WEIGHT_UNIT.LB)
                  showLBHeightPicker(context, _);
                else
                  showKgHeightPicker(context, _);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 46),
                alignment: Alignment.center,
                child: Obx(
                  () => RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: _.selectedWeight.value,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: _.selectedWeightUnit.value == WEIGHT_UNIT.LB
                            ? "lb"
                            : "kg",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _.gotoMotivationSelectionPage();
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
    if (_.selectedWeightUnit.value == WEIGHT_UNIT.LB)
      showLBHeightPicker(context, _);
    else
      showKgHeightPicker(context, _);
  }

  void showKgHeightPicker(BuildContext context, UserDetailController _) {
    /*
    * min : 0 kg | 0 grms
    * max : 200 kg | 10 grms
    * */
    const Kg_Grams = '''
[
    [
        "28",
        "29",
        "30",
        "31",
        "32",
        "33",
        "34",
        "35",
        "36",
        "37",
        "38",
        "39",
        "40",
        "41",
        "42",
        "43",
        "44",
        "45",
        "46",
        "47",
        "48",
        "49",
        "50",
        "51",
        "52",
        "53",
        "54",
        "55",
        "56",
        "57",
        "58",
        "59",
        "60",
        "61",
        "62",
        "63",
        "64",
        "65",
        "66",
        "67",
        "68",
        "69",
        "70",
        "71",
        "72",
        "73",
        "74",
        "75",
        "76",
        "77",
        "78",
        "79",
        "80",
        "81",
        "82",
        "83",
        "84",
        "85",
        "86",
        "87",
        "88",
        "89",
        "90",
        "91",
        "92",
        "93",
        "94",
        "95",
        "96",
        "97",
        "98",
        "99",
        "100",
        "101",
        "102",
        "103",
        "104",
        "105",
        "106",
        "107",
        "108",
        "109",
        "110",
        "111",
        "112",
        "113",
        "114",
        "115",
        "116",
        "117",
        "118",
        "119",
        "120",
        "121",
        "122",
        "123",
        "124"
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
        "9"
    ]
]
    ''';

    /*Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: JsonDecoder().convert(Kg_Grams),
          isArray: true,
        ),
        hideHeader: true,
        selecteds: [
          int.parse(_.selectedWeight.value
              .substring(0, _.selectedWeight.value.indexOf("."))),
          int.parse(_.selectedWeight.value.substring(
              _.selectedWeight.value.indexOf(".") + 1,
              _.selectedWeight.value.length))
        ],
        magnification: 1.5,
        title: Expanded(
            flex: 1,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("Kg"), Text("Grams")],
            ))),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());

          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
          selection(
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showDialog(context);*/

    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: JsonDecoder().convert(Kg_Grams),
          isArray: true,
        ),
        selecteds: [
          int.parse(_.selectedWeight.value
                  .substring(0, _.selectedWeight.value.indexOf("."))) -
              28,
          int.parse(_.selectedWeight.value.substring(
              _.selectedWeight.value.indexOf(".") + 1,
              _.selectedWeight.value.length))
        ],
        magnification: 1.5,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text("Kg"), Text("Grams")],
        )),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());

          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
          selection(
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void showLBHeightPicker(BuildContext context, UserDetailController _) {
    /*
    * min : 0 lbs
    * max : 440 lbs
    * */

    var minLBs = 63;
    var LBs = new List<int>.generate(212, (i) => minLBs++);

    /*Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: LBs,
        ),
        hideHeader: true,
        selecteds: [int.parse(_.selectedWeight.value)],
        magnification: 1.5,
        title: Expanded(flex: 1, child: Center(child: Text("Lbs"))),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selection(picker.getSelectedValues()[0].toString());
        }).showDialog(context);*/

    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: LBs,
        ),
        selecteds: [int.parse(_.selectedWeight.value) - 63],
        magnification: 1.5,
        title: Center(child: Text("Lbs")),
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
    // if (_.selectedWeightUnit.value == WEIGHT_UNIT.KG) {
    //   double convertedValue = double.parse(value);
    //   if (convertedValue < 28.5) {
    //     unitBaseValue = "28.5 kg";
    //     _.selectedWeight.value = "28.5";
    //     Utils.showErrorSnackBar("Weight cannot be less then $unitBaseValue",
    //         instantInit: false);
    //   } else if (convertedValue > 124.7) {
    //     unitBaseValue = "124.7 kg";
    //     _.selectedWeight.value = "124.7";
    //     Utils.showErrorSnackBar("Weight cannot be more then $unitBaseValue",
    //         instantInit: false);
    //   } else {
    //     _.selectedWeight.value = value;
    //   }
    // }
    //
    // if (_.selectedWeightUnit.value == WEIGHT_UNIT.LB) {
    //   int convertedValue = int.parse(value);
    //   if (convertedValue < 63) {
    //     unitBaseValue = "63 lbs";
    //     _.selectedWeight.value = "63";
    //     Utils.showErrorSnackBar("Weight cannot be less then $unitBaseValue",
    //         instantInit: false);
    //   } else if (convertedValue > 275) {
    //     unitBaseValue = "275 lbs";
    //     _.selectedWeight.value = "275";
    //     Utils.showErrorSnackBar("Weight cannot be more then $unitBaseValue",
    //         instantInit: false);
    //   } else {
    //     _.selectedWeight.value = value;
    //   }
    // }

    _.selectedWeight.value = value;
  }
}
