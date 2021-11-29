import 'dart:convert';

import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/bmr/view/bmr_result.dart';
import 'package:fit_beat/app/features/kcal_cal/view/kkal_result.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalculatorkKalController extends GetxController {
  final ApiRepository repository;

  CalculatorkKalController({@required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();

    if (PrefData().getGender() != null && PrefData().getGender() != -1) {
      genderController.text = getGender();
      selectedGender.value = getGender();
    } else {
      genderController.text = "MALE";
      selectedGender.value = "1";
    }

    activityController.text = "Beginner : new to exercise";

    if (PrefData().getDOB() != null && PrefData().getDOB().isNotEmpty) {
      ageController.text = Utils()
          .calculateAge(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .parse(PrefData().getDOB()))
          .toString();
    } else {
      ageController.text = "18";
    }

    if (PrefData().getHeight() != null &&
        PrefData().getHeight() != "0" &&
        PrefData().getHeight().isNotEmpty) {
      selectedHeight = RxString(PrefData().getHeight());
      print("selectedHeight ========= : $selectedHeight");
    }

    if (PrefData().getWidth() != null && PrefData().getWidth().isNotEmpty) {
      selectedWeight = RxString(PrefData().getWidth());
    }

    if (PrefData().getWeightUnit() != null && PrefData().getWeightUnit() == 1) {
      selectedWeightUnit = Rx(WEIGHT_UNIT.LB);
    } else {
      selectedWeightUnit = Rx(WEIGHT_UNIT.KG);
    }

    if (PrefData().getHeightUnit() != null && PrefData().getHeightUnit() == 1) {
      selectedHeightUnit = Rx(HEIGHT_UNIT.INCH);
    } else {
      selectedHeightUnit = Rx(HEIGHT_UNIT.CM);
    }
  }

  TextEditingController genderController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  RxString selectedGender = RxString("MALE");
  RxString selectedActivity = RxString("Beginner : new to exercise");

  var selectedHeightUnit = Rx(HEIGHT_UNIT.INCH);
  var selectedWeightUnit = Rx(WEIGHT_UNIT.LB);

  RxString selectedHeight = RxString("4.6");
  RxString selectedWeight = RxString("63");

  void calculatekKal() {
    int height = 0;
    int weight = 0;
    int age = int.parse(ageController.text.toString());
    double _bmr;

    if (selectedGender.value == "Select Gender") {
      Utils.showErrorSnackBar("Please select gender");
    } else {
      Utils.showLoadingDialog();
      print("${selectedHeightUnit.value}");

      if (selectedHeightUnit.value == HEIGHT_UNIT.INCH) {
        height = int.parse(foot_to_cm(double.parse(selectedHeight.value)));
      } else {
        height = int.parse(selectedHeight.value);
      }
      if (selectedWeightUnit.value == WEIGHT_UNIT.LB) {
        weight =
            double.parse(lb_to_kg(double.parse(selectedWeight.value).toInt()))
                .toInt();
      } else {
        weight = double.parse(selectedWeight.value).toInt();
      }
      if (selectedGender.value == "MALE") {
        _bmr = 9.99 * weight + 6.25 * height - 4.92 * age + 5;
      } else {
        _bmr = 9.99 * weight + 6.25 * height - 4.92 * age - 161;
      }
      Utils.dismissLoadingDialog();
      Get.bottomSheet(KKalResultPage(
        kKalResult: _bmr + 100,
      ));
    }
  }

  void showGenderPicker(BuildContext context) {
    var genders = ["MALE", "FEMALE", "OTHER"];

    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: genders,
        ),
        magnification: 1.5,
        title: Center(child: Text("Gender")),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selectionGender(picker.getSelectedValues()[0].toString());
        }).showModal(context);
  }

  void selectionGender(String gender) {
    selectedGender.value = gender;
    genderController.text = gender;
  }

  void showHeightPicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    print("selectedHeightUnit.value ${selectedHeightUnit.value}");
    if (selectedHeightUnit.value == HEIGHT_UNIT.CM) {
      print("showCMHeightPicker");
      Get.find<CalculatorkKalController>().showCMHeightPicker(context);
    } else {
      print("showFeetHeightPicker");
      Get.find<CalculatorkKalController>().showFeetHeightPicker(context);
    }
  }

  void showFeetHeightPicker(BuildContext context) {
    /*
    * min : 0 feet | 0 inches
    * max : 7 feet | 12 inches
    * */

    selectedHeight.value =
        cm_to_foot(double.parse(selectedHeight.value).toInt());

    selectedHeightUnit.value = HEIGHT_UNIT.INCH;

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
          int.parse(selectedHeight.value[0]) - 4,
          int.parse(selectedHeight.value.substring(
              selectedHeight.value.indexOf(".") + 1,
              selectedHeight.value.length))
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
          selectedHeight.value =
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}";
          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void showCMHeightPicker(BuildContext context) {
    /*
    * min : 0 cms
    * max : 244 cms
    * */

    var minCMs = 137;
    var CMs = new List<int>.generate(105, (i) => minCMs++);

    if (selectedHeightUnit == HEIGHT_UNIT.CM) {
      selectedHeight.value = selectedHeight.value;
    } else if (selectedHeightUnit == HEIGHT_UNIT.INCH) {
      var condition = double.parse(selectedHeight.value);
      if (condition > 20) {
      } else {
        selectedHeight.value = foot_to_cm(double.parse(selectedHeight.value));
      }
      if (condition.toInt() - 137 < 0) {
        selectedHeight.value = "137";
      }
    }
    selectedHeightUnit.value = HEIGHT_UNIT.CM;
    //selectedHeight.value = foot_to_cm(double.parse(selectedHeight.value));

    print("_.selectedHeight.value = ${selectedHeight.value}");
    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: CMs,
        ),
        selecteds: [int.parse(selectedHeight.value) - 137],
        magnification: 1.5,
        title: Text("Centimeters"),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selectedHeight.value = picker.getSelectedValues()[0].toString();
        }).showModal(context);
  }

  void showWeightPicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (selectedWeightUnit.value == WEIGHT_UNIT.LB)
      showLBWeightPicker(context);
    else
      showKgWeightPicker(context);
  }

  void showLBWeightPicker(BuildContext context) {
    /*
    * min : 0 lbs
    * max : 440 lbs
    * */
    print("showLBWeightPicker");
    if (selectedWeightUnit.value == WEIGHT_UNIT.LB) {
      selectedWeight.value = kg_to_lb(double.parse(selectedWeight.value));
      selectedWeightUnit.value = WEIGHT_UNIT.LB;
    }

    if (double.parse(selectedWeight.value) > 212) {
      selectedWeight.value = "212";
    }

    var minLBs = 63;
    var LBs = new List<int>.generate(212, (i) => minLBs++);

    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: LBs,
        ),
        selecteds: [int.parse(selectedWeight.value) - 63],
        magnification: 1.5,
        title: Center(child: Text("Lbs")),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selectedWeight.value = picker.getSelectedValues()[0].toString();
        }).showModal(context);
  }

  void showKgWeightPicker(BuildContext context) {
    /*
    * min : 0 kg | 0 grms
    * max : 200 kg | 10 grms
    * */
    print("showKgWeightPicker");
    String lbToKg = "";
    if (selectedWeightUnit.value == WEIGHT_UNIT.KG) {
      lbToKg = lb_to_kg(double.parse(selectedWeight.value).toInt());

      selectedWeightUnit.value = WEIGHT_UNIT.KG;
    }

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
          int.parse(lbToKg.substring(0, lbToKg.indexOf("."))) - 28 < 1
              ? 28
              : int.parse(lbToKg.substring(0, lbToKg.indexOf("."))) - 28,
          int.parse(lbToKg.substring(lbToKg.indexOf(".") + 1, lbToKg.length))
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
          selectedWeight.value =
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}";
        }).showModal(context);
  }

  String foot_to_cm(double foot) {
    var foot_to_string = foot.toString();
    var onlyFoot = foot.toInt();
    var onlyInch = int.parse(foot_to_string.substring(
        foot_to_string.indexOf(".") + 1, foot_to_string.length));

    if (foot == 0.0) return "0";

    var foot_to_cm = (30.48 * onlyFoot);

    var inch_to_cm = (2.54 * onlyInch);

    var result = (foot_to_cm + inch_to_cm).floor().toString();

    print("foot_to_cm => $result");
    return result;
  }

  String cm_to_foot(int cm) {
    if (cm == 0) return "0.0";

    var value = (cm / 30.48).toStringAsFixed(2);

    var inch =
        (int.parse(value.substring(value.indexOf(".") + 1, value.length)) *
                0.12)
            .round();
    var foot = (cm / 30.48).floor();

    value = "$foot.$inch";

    print("cm_to_foot => $value");
    return value;
  }

  String kg_to_lb(double kg) {
    if (kg == 0.0) return "0";

    var value = (2.205 * kg).floor().toString();

    print("kg_to_lb => $value");
    return value;
  }

  String lb_to_kg(int lb) {
    if (lb == 0) return "0.0";

    var value = (lb / 2.205).toStringAsFixed(2);
    if (int.parse(value.substring(value.indexOf(".") + 1, value.length)) > 9) {
      value = (lb / 2.205).toStringAsFixed(1);
    }

    print("lb_to_kg => $value");
    return value;
  }

  getGender() {
    String gender = "Select Gender";
    if (PrefData().getGender() == 1) {
      gender = "MALE";
    } else if (PrefData().getGender() == 2) {
      gender = "FEMALE";
    } else if (PrefData().getGender() == 3) {
      gender = "OTHER";
    }
    return gender;
  }

  void setActivity(String activity) {
    selectedActivity.value = activity;
    activityController.text = activity;
  }

  void showActivityPicker(BuildContext context) {
    var genders = [
      "Beginner : new to exercise",
      "Intermediate:20-30 Minutes",
      "Advanced:more than 2 hrs."
    ];

    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: genders,
        ),
        magnification: 1.5,
        title: Center(child: Text("Activity")),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          setActivity(picker.getSelectedValues()[0].toString());
        }).showModal(context);
  }
}
