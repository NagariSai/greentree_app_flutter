import 'dart:convert';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/features/my_profile/controller/profile_controller.dart';
import 'package:fit_beat/app/features/my_profile/view/custom_switch.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ProfileController>(builder: (_) {
        return Container(
          color: bodybgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showGenderPicker(context, _);
                },
                child: TextField(
                  enabled: false,
                  controller: _.genderController,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: FF025074,
                      fontFamily: FontFamily.poppins),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FFB0B8BB),
                        //  when the TextFormField in unfocused
                      ),
                      labelText: "Gender",
                      hintText: "Enter Gender",
                      labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: FF6D7274,
                          fontFamily: FontFamily.poppins)),
                  autocorrect: false,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  showDatePicker(context);
                },
                child: TextField(
                  controller: _.dobController,
                  enabled: false,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: FF025074,
                      fontFamily: FontFamily.poppins),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FFB0B8BB),
                        //  when the TextFormField in unfocused
                      ),
                      labelText: "DOB",
                      labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: FF6D7274,
                          fontFamily: FontFamily.poppins)),
                  autocorrect: false,
                ),
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "Height",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showPicker(context, _);
                      },
                      child: GetX<ProfileController>(builder: (_) {
                        return CustomText(
                          text: "${_.selectedHeight.value ?? ""}",
                          color: FF025074,
                          size: 16,
                          fontWeight: FontWeight.w700,
                        );
                      }),
                    ),
                  ),
                  CustomSwitch(
                    firstTabName: "in",
                    secondTabName: "cm",
                    width: 90,
                    height: 23,
                    borderRadius: 4,
                    selectorHeight: 17,
                    selectorWidth: 42,
                    selectorRadius: 4,
                    backgroundColor: FFE0EAEE,
                    isFirstTabValue: true,
                    isSecondTabValue: false,
                    onClick: (bool isInUnit, bool isCmUnit) {
                      print("isInUnit ${isInUnit}");
                      print("isCmUnit ${isCmUnit}");
                      if (isInUnit) {
                        showFeetHeightPicker(context, _);
                      } else if (isCmUnit) {
                        showCMHeightPicker(context, _);
                      }
                      /*_.updateUnit();*/
                    },
                  )
                ],
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "Weight",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  GetX<ProfileController>(builder: (_) {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          //showWeightPicker(context, _);
                        },
                        child: CustomText(
                          text: "${_.selectedWeight.value ?? ""}",
                          color: FF025074,
                          size: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }),
                  CustomSwitch(
                    firstTabName: "lb",
                    secondTabName: "kg",
                    width: 90,
                    height: 23,
                    borderRadius: 4,
                    selectorHeight: 17,
                    selectorWidth: 42,
                    selectorRadius: 4,
                    backgroundColor: FFE0EAEE,
                    isFirstTabValue:
                        _.selectedWeightUnit.value == WEIGHT_UNIT.LB
                            ? true
                            : false,
                    isSecondTabValue:
                        _.selectedWeightUnit.value == WEIGHT_UNIT.LB
                            ? false
                            : true,
                    onClick: (bool isLbUnit, bool isKgUnit) {
                      if (isLbUnit) {
                        _.selectedWeightUnit.value = WEIGHT_UNIT.LB;
                        showLBHeightPicker(context, _);
                      } else if (isKgUnit) {
                        _.selectedWeightUnit.value = WEIGHT_UNIT.KG;
                        showKgHeightPicker(context, _);
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              CustomText(
                text: "Bio",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                height: 70,
                child: TextField(
                  controller: _.bioTextEditController,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Write bio here...',
                      hintStyle: TextStyle(
                          color: FFBDC5C5,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamily.poppins,
                          decoration: TextDecoration.none)),
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "What brings you here?",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _.getBringsYouList(),
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "Food preferences",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _.getFoodList(),
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "Fitness Level",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _.getFitnessLevelList(),
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "Interests",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _.getInterestList(),
              ),
              const SizedBox(height: 16),
              /* Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),*/
            ],
          ),
        );
      }),
    );
  }

  showDatePicker(BuildContext context) {
    Get.find<ProfileController>().isEdit.value = true;
    Get.find<ProfileController>().isEdit.refresh();
    var _ = Get.find<ProfileController>();
    Picker(
        cancelTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        confirmTextStyle: TextStyle(fontSize: 14, color: primaryColor),
        columnPadding: EdgeInsets.only(bottom: 30),
        magnification: 1.5,
        hideHeader: false,
        adapter: DateTimePickerAdapter(yearBegin: 1905, yearEnd: 2015),
        height: 200,
        onConfirm: (Picker picker, List value) {
          print(
              "(picker.adapter as DateTimePickerAdapter).value ${(picker.adapter as DateTimePickerAdapter).value}");
          _.setDob((picker.adapter as DateTimePickerAdapter).value);
        }).showModal(context);
  }

  void showPicker(BuildContext context, ProfileController _) {
    Get.find<ProfileController>().isEdit.value = true;
    Get.find<ProfileController>().isEdit.refresh();
    if (_.selectedHeightUnit.value == HEIGHT_UNIT.CM) {
      /* _.selectedHeightUnit.value = HEIGHT_UNIT.CM;
      _.updateUnit();*/
      print("showCMHeightPicker");
      showCMHeightPicker(context, _);
    } else {
      /* _.selectedHeightUnit.value = HEIGHT_UNIT.INCH;
      _.updateUnit();*/
      print("showFeetHeightPicker");
      showFeetHeightPicker(context, _);
    }
  }

  void showCMHeightPicker(BuildContext context, ProfileController _) {
    /*
    * min : 0 cms
    * max : 244 cms
    * */

    var minCMs = 137;
    var CMs = new List<int>.generate(105, (i) => minCMs++);

    print("_.selectedHeight.value = ${_.selectedHeight.value}");
    print("  selectedHeightUnit = ${_.selectedHeightUnit.value}");
    if (_.selectedHeightUnit == HEIGHT_UNIT.CM) {
      _.selectedHeight.value = _.selectedHeight.value;
    } else if (_.selectedHeightUnit == HEIGHT_UNIT.INCH) {
      var condition = double.parse(_.selectedHeight.value);
      if (condition > 20) {
      } else {
        _.selectedHeight.value =
            _.foot_to_cm(double.parse(_.selectedHeight.value));
      }
      if (condition.toInt() - 137 < 0) {
        _.selectedHeight.value = "137";
      }
    }
    _.selectedHeightUnit.value = HEIGHT_UNIT.CM;
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
    Get.find<ProfileController>().selectedHeight.value = value;
  }

  void showFeetHeightPicker(BuildContext context, ProfileController _) {
    /*
    * min : 0 feet | 0 inches
    * max : 7 feet | 12 inches
    * */
    Get.find<ProfileController>().isEdit.value = true;
    Get.find<ProfileController>().isEdit.refresh();
    String cmToFoot =
        _.cm_to_foot(double.parse(_.selectedHeight.value).toInt());
    _.selectedHeightUnit.value = HEIGHT_UNIT.INCH;
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

          selection(
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");

          print(
              "result => ${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void showLBHeightPicker(BuildContext context, ProfileController _) {
    /*
    * min : 0 lbs
    * max : 440 lbs
    * */

    var minLBs = 63;
    var LBs = new List<int>.generate(212, (i) => minLBs++);

    print("_.selectedWeight.value ${_.selectedWeight.value}");
    if (_.selectedWeightUnit.value == WEIGHT_UNIT.LB) {
      _.selectedWeight.value = _.kg_to_lb(double.parse(_.selectedWeight.value));
    }

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
          selectionWeight(picker.getSelectedValues()[0].toString());
        }).showModal(context);
  }

  void showKgHeightPicker(BuildContext context, ProfileController _) {
    /*
    * min : 0 kg | 0 grms
    * max : 200 kg | 10 grms
    * */

    String lbToKg = "";
    if (_.selectedWeightUnit.value == WEIGHT_UNIT.KG) {
      try {
        lbToKg = _.lb_to_kg(int.parse(_.selectedWeight.value));
        _.selectedWeightUnit.value = WEIGHT_UNIT.KG;
      } catch (e) {}
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
          int.parse(lbToKg.substring(0, lbToKg.indexOf("."))) - 28,
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
          selectionWeight(
              "${picker.getSelectedValues()[0]}.${picker.getSelectedValues()[1]}");
        }).showModal(context);
  }

  void selectionWeight(String value) {
    Get.find<ProfileController>().selectedWeight.value = value;
  }

  void showWeightPicker(BuildContext context, ProfileController _) {
    print("showWeightPicker = ${_.selectedWeightUnit.value}");
    if (_.selectedWeightUnit.value == WEIGHT_UNIT.LB)
      showLBHeightPicker(context, _);
    else
      showKgHeightPicker(context, _);
  }

  void showGenderPicker(BuildContext context, ProfileController _) {
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
    Get.find<ProfileController>().selectedGender.value = gender;
    Get.find<ProfileController>().genderController.text = gender;
  }
}
