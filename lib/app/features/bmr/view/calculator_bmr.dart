import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/my_profile/view/custom_switch.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import '../controller/calculator_bmr_controller.dart';

class CalculatorBMRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalculatorBMRController>(
        init: CalculatorBMRController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return Scaffold(
            backgroundColor: bodybgColor,
            appBar: CustomAppBar(
              title: "BMR Calc.",
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundedCornerButton(
                height: 50,
                buttonText: "Calculate BMR",
                buttonColor: FF025074,
                borderColor: FF025074,
                fontSize: 14,
                radius: 12,
                isIconWidget: false,
                iconAndTextColor: Colors.white,
                iconData: null,
                onPressed: () {
                  _.calculateBMR();
                },
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: FFB0B8BB,
                  ),
                  InkWell(
                    onTap: () {
                      _.showGenderPicker(context);
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
                  TextField(
                    controller: _.ageController,
                    keyboardType: TextInputType.number,
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
                        labelText: "Age",
                        hintText: "Enter Age",
                        labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: FF6D7274,
                            fontFamily: FontFamily.poppins)),
                    autocorrect: false,
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
                            _.showHeightPicker(context);
                          },
                          child: GetX<CalculatorBMRController>(builder: (_) {
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
                        isFirstTabValue:
                            _.selectedHeightUnit == HEIGHT_UNIT.INCH
                                ? true
                                : false,
                        isSecondTabValue: _.selectedHeightUnit == HEIGHT_UNIT.CM
                            ? true
                            : false,
                        onClick: (bool isInUnit, bool isCmUnit) {
                          print("isInUnit ${isInUnit}");
                          print("isCmUnit ${isCmUnit}");
                          if (isInUnit) {
                            _.showFeetHeightPicker(context);
                          } else if (isCmUnit) {
                            _.showCMHeightPicker(context);
                          }

                          // _.showHeightPicker(context);
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
                      GetX<CalculatorBMRController>(builder: (_) {
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              _.showWeightPicker(context);
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
                            _.showLBWeightPicker(context);
                          } else if (isKgUnit) {
                            _.selectedWeightUnit.value = WEIGHT_UNIT.KG;
                            _.showKgWeightPicker(context);
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: FFB0B8BB,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
