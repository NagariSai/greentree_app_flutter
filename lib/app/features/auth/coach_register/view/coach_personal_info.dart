import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/media_widget.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/features/auth/coach_register/controller/coach_register_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'coach_tag_widget.dart';

class CoachPersonalInfo extends StatefulWidget {
  @override
  _CoachPersonalInfoState createState() => _CoachPersonalInfoState();
}

class _CoachPersonalInfoState extends State<CoachPersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CoachRegisterController>(builder: (_) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _.nameController,
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
                    labelText: "Name",
                    hintText: "Enter Name",
                    labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: FF6D7274,
                        fontFamily: FontFamily.poppins)),
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
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
                  FocusScope.of(context).unfocus();
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
              TextField(
                controller: _.yearExpController,
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
                    labelText: "Years of Experience",
                    hintText: "Enter Years of Experience",
                    labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: FF6D7274,
                        fontFamily: FontFamily.poppins)),
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "Category",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _.getFitnessCategoryWidgetList(),
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),
              CoachTagWidget(
                suggestedTags: [],
                onTagsChanged: (value) {
                  _.selectedSpecialityStringTags = value;
                  print(
                      "selectedStringTags => ${_.selectedSpecialityStringTags}");
                },
              ),
              const SizedBox(height: 16),
              CustomText(
                text: "Known Languages",
                color: FF6D7274,
                size: 12,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _.getLanguageWidgetList(),
              ),
              const SizedBox(height: 16),
              Divider(
                color: FFB0B8BB,
              ),
              const SizedBox(height: 16),
              TextInputContainer(
                title: "Work Experience",
                inputHint: "More about your previous work experience.",
                minLines: 5,
                maxLines: 7,
                onChange: (value) {
                  _.workExpDesc = value;
                },
              ),
              const SizedBox(height: 16),
              CustomInputContainer(
                title: "Certificates",
                fontWeight: FontWeight.normal,
                titleSize: 12,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    height: 100,
                    child: Row(
                      children: [
                        if (_.mediaPathList.isNotEmpty) ...[
                          Flexible(
                            fit: FlexFit.loose,
                            child: ListView.separated(
                              itemBuilder: (context, position) {
                                return MediaWidget(
                                  mediaFile: _.mediaPathList[position],
                                  onRemove: () => _.removeMedia(position),
                                );
                              },
                              itemCount: _.mediaPathList.length,
                              shrinkWrap: true,
                              separatorBuilder: (context, position) {
                                return SizedBox(
                                  width: 8,
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          _.mediaPathList.length < 5
                              ? SizedBox(
                                  width: 8,
                                )
                              : SizedBox()
                        ],
                        _.mediaPathList.length < 5
                            ? MediaWidget(
                                onTap: () => _.addMedia(context),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: "Already have an account?",
                        color: titleBlackColor,
                        size: 13,
                      ),
                      SizedBox(width: 4),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: CustomText(
                          text: 'Sign In',
                          color: primaryColor,
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  showDatePicker(BuildContext context) {
    var _ = Get.find<CoachRegisterController>();
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

  void showGenderPicker(BuildContext context, CoachRegisterController _) {
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
    Get.find<CoachRegisterController>().selectedGender.value = gender;
    Get.find<CoachRegisterController>().genderController.text = gender;
  }
}
