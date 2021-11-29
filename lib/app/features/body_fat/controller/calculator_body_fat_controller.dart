import 'dart:convert';

import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/body_fat/view/body_fat_result.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalculatorBodyFatController extends GetxController {
  final ApiRepository repository;

  CalculatorBodyFatController({@required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    genderController.text = "Select Gender";

    if (PrefData().getGender() != null) {
      genderController.text = getGender();
      selectedGender.value = getGender();
    }

    if (PrefData().getHeight() != null && PrefData().getHeight() != "0") {
      selectedHeight = RxString(PrefData().getHeight());
    }

    if (PrefData().getHeightUnit() != null && PrefData().getHeightUnit() == 1) {
      selectedHeightUnit = Rx(HEIGHT_UNIT.INCH);
    } else {
      selectedHeightUnit = Rx(HEIGHT_UNIT.CM);
    }
  }

  TextEditingController genderController = TextEditingController();

  RxString selectedGender = RxString("Select Gender");

  var selectedHeightUnit = Rx(HEIGHT_UNIT.INCH);
  var selectedWaistUnit = Rx(HEIGHT_UNIT.INCH);
  var selectedNeckUnit = Rx(HEIGHT_UNIT.INCH);
  var selectedHipUnit = Rx(HEIGHT_UNIT.INCH);

  RxString selectedHeight = RxString("70");
  RxString selectedWaist = RxString("37");
  RxString selectedNeck = RxString("19");
  RxString selectedHip = RxString("31");

  void calculateBodyFat() {
    if (selectedGender.value.compareTo("Select Gender") == 0) {
      Utils.showErrorSnackBar("Please select gender");
    } else {
      var waist = 150;
      try {
        if (selectedWaistUnit.value == HEIGHT_UNIT.CM) {
          waist = int.parse(selectedWaist.value);
        } else {
          waist = int.parse(foot_to_cm(double.parse(selectedWaist.value)));
        }
      } catch (e) {
        print("waist error ${e.toString()}");
      }

      var neck = 150;
      try {
        if (selectedNeckUnit.value == HEIGHT_UNIT.CM) {
          print("if");
          neck = int.parse(selectedNeck.value);
        } else {
          print("else");
          neck = int.parse(foot_to_cm(double.parse(selectedNeck.value)));
        }
      } catch (e) {
        print("neck error ${e.toString()}");
      }

      var hip = 150;
      try {
        if (selectedHipUnit.value == HEIGHT_UNIT.CM) {
          neck = int.parse(selectedHip.value);
        } else {
          neck = int.parse(foot_to_cm(double.parse(selectedHip.value)));
        }
      } catch (e) {
        print("hip error ${e.toString()}");
      }

      var height = 150;
      try {
        if (selectedHeightUnit.value == HEIGHT_UNIT.CM) {
          neck = int.parse(selectedHeight.value);
        } else {
          neck = int.parse(foot_to_cm(double.parse(selectedHeight.value)));
        }
      } catch (e) {
        print("height error ${e.toString()}");
      }

      double bodyFat = 0;
      var sum = waist + neck + hip + height;
      var sum2 = sum * sum;
      var age = 30;

      age = Utils().calculateAge(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(PrefData().getDOB()));

      if (selectedGender.value.compareTo("MALE") == 0) {
        bodyFat = (.29288 * sum) + (.0005 * sum2) + (.15845 * age) + 5.76377;
      } else {
        bodyFat = (.29669 * sum) + (.00043 * sum2) + (.02963 * age) + 1.4072;
      }

      Get.bottomSheet(BodyFatResultPage(
        bodyFatResult: bodyFat / 10,
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
    if (selectedHeightUnit.value == HEIGHT_UNIT.CM)
      showCMHeightPicker(context);
    else
      showFeetHeightPicker(context);
  }

  void showWaistPicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (selectedWaistUnit.value == HEIGHT_UNIT.CM)
      showCMHWaistPicker(context);
    else
      showFeetWaistPicker(context);
  }

  void showNeckPicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (selectedNeckUnit.value == HEIGHT_UNIT.CM)
      showCMHNeckPicker(context);
    else
      showFeetNeckPicker(context);
  }

  void showHipPicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (selectedHipUnit.value == HEIGHT_UNIT.CM)
      showCMHHipPicker(context);
    else
      showFeetHipPicker(context);
  }

  void showFeetHipPicker(BuildContext context) {
    /*
    * min : 0 feet | 0 inches
    * max : 7 feet | 12 inches
    * */

    String cmToFoot = cm_to_foot(double.parse(selectedHip.value).toInt());
    selectedHipUnit.value = HEIGHT_UNIT.INCH;

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
          int.parse(cmToFoot[0]) - 4,
          int.parse(
              cmToFoot.substring(cmToFoot.indexOf(".") + 1, cmToFoot.length))
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
          selectedHip.value =
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}";
          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void showCMHHipPicker(BuildContext context) {
    /*
    * min : 0 cms
    * max : 244 cms
    * */

    var minCMs = 137;
    var CMs = new List<int>.generate(105, (i) => minCMs++);

    //  selectedHip.value = foot_to_cm(double.parse(selectedHip.value));
    if (selectedHipUnit == HEIGHT_UNIT.CM) {
      selectedHip.value = selectedHip.value;
    } else if (selectedHipUnit == HEIGHT_UNIT.INCH) {
      var condition = double.parse(selectedHip.value);
      if (condition > 20) {
      } else {
        selectedHip.value = foot_to_cm(double.parse(selectedHip.value));
      }
      if (condition.toInt() - 137 < 0) {
        selectedHip.value = "137";
      }
    }
    selectedHipUnit.value = HEIGHT_UNIT.CM;

    print("_.selectedHip.value = ${selectedHip.value}");
    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: CMs,
        ),
        selecteds: [int.parse(selectedHip.value) - 137],
        magnification: 1.5,
        title: Text("Centimeters"),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selectedHip.value = picker.getSelectedValues()[0].toString();
        }).showModal(context);
  }

  void showCMHNeckPicker(BuildContext context) {
    /*
    * min : 0 cms
    * max : 244 cms
    * */

    var minCMs = 137;
    var CMs = new List<int>.generate(105, (i) => minCMs++);

    //selectedNeck.value = foot_to_cm(double.parse(selectedNeck.value));

    if (selectedNeckUnit == HEIGHT_UNIT.CM) {
      selectedNeck.value = selectedNeck.value;
    } else if (selectedNeckUnit == HEIGHT_UNIT.INCH) {
      var condition = double.parse(selectedNeck.value);
      if (condition > 20) {
      } else {
        selectedNeck.value = foot_to_cm(double.parse(selectedNeck.value));
      }
      if (condition.toInt() - 137 < 0) {
        selectedNeck.value = "137";
      }
    }

    selectedNeckUnit.value = HEIGHT_UNIT.CM;

    print("_.selectedNeck.value = ${selectedNeck.value}");
    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: CMs,
        ),
        selecteds: [int.parse(selectedNeck.value) - 137],
        magnification: 1.5,
        title: Text("Centimeters"),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selectedNeck.value = picker.getSelectedValues()[0].toString();
        }).showModal(context);
  }

  void showFeetNeckPicker(BuildContext context) {
    /*
    * min : 0 feet | 0 inches
    * max : 7 feet | 12 inches
    * */

    String cmToFeet = cm_to_foot(double.parse(selectedNeck.value).toInt());

    selectedNeckUnit.value = HEIGHT_UNIT.INCH;

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
          int.parse(cmToFeet[0]) - 4,
          int.parse(
              cmToFeet.substring(cmToFeet.indexOf(".") + 1, cmToFeet.length))
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
          selectedNeck.value =
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}";
          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void showFeetWaistPicker(BuildContext context) {
    /*
    * min : 0 feet | 0 inches
    * max : 7 feet | 12 inches
    * */

    String cmToFoot = cm_to_foot(double.parse(selectedWaist.value).toInt());

    selectedWaistUnit.value = HEIGHT_UNIT.INCH;

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
          int.parse(cmToFoot[0]) - 4,
          int.parse(
              cmToFoot.substring(cmToFoot.indexOf(".") + 1, cmToFoot.length))
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
          selectedWaist.value =
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}";
          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void showCMHWaistPicker(BuildContext context) {
    /*
    * min : 0 cms
    * max : 244 cms
    * */

    var minCMs = 137;
    var CMs = new List<int>.generate(105, (i) => minCMs++);

    if (selectedWaistUnit == HEIGHT_UNIT.CM) {
      selectedWaist.value = selectedWaist.value;
    } else if (selectedWaistUnit == HEIGHT_UNIT.INCH) {
      var condition = double.parse(selectedWaist.value);
      if (condition > 20) {
      } else {
        selectedWaist.value = foot_to_cm(double.parse(selectedWaist.value));
      }
      if (condition.toInt() - 137 < 0) {
        selectedWaist.value = "137";
      }
    }

    // selectedWaist.value = foot_to_cm(double.parse(selectedWaist.value));

    selectedWaistUnit.value = HEIGHT_UNIT.CM;

    print("_.selectedWaist.value = ${selectedWaist.value}");
    Picker(
        hideHeader: false,
        height: 200,
        columnPadding: EdgeInsets.only(bottom: 30),
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        adapter: PickerDataAdapter<String>(
          pickerdata: CMs,
        ),
        selecteds: [int.parse(selectedWaist.value) - 137],
        magnification: 1.5,
        title: Text("Centimeters"),
        selectedTextStyle: TextStyle(color: primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          selectedWaist.value = picker.getSelectedValues()[0].toString();
        }).showModal(context);
  }

  void showFeetHeightPicker(BuildContext context) {
    /*
    * min : 0 feet | 0 inches
    * max : 7 feet | 12 inches
    * */

    String cmToFeet = cm_to_foot(double.parse(selectedHeight.value).toInt());

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
          int.parse(cmToFeet[0]) - 4,
          int.parse(
              cmToFeet.substring(cmToFeet.indexOf(".") + 1, cmToFeet.length))
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

    //selectedHeight.value = foot_to_cm(double.parse(selectedHeight.value));

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
}
