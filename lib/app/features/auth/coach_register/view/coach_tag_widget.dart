import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

class CoachTagController extends GetxController {
  List<String> selected = [];
}

class CoachTagWidget extends GetWidget<CoachTagController> {
  final List<dynamic> suggestedTags;
  final Function(dynamic) onTagsChanged;

  final String title;
  final String hintText;

  CoachTagWidget(
      {Key key,
      @required this.suggestedTags,
      this.onTagsChanged,
      this.hintText = "+ Add Speciality",
      this.title = "Speciality"})
      : super(key: key) {
    Get.create(() => CoachTagController());
  }

  @override
  CoachTagController get controller => super.controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoachTagController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "$title",
            color: FF6D7274,
            size: 12,
          ),
          const SizedBox(height: 10),
          TextFieldTags(
            tagsStyler: TagsStyler(
              tagTextStyle: TextStyle(
                  fontSize: 14,
                  color: titleBlackColor,
                  fontFamily: FontFamily.poppins),
              tagDecoration: BoxDecoration(
                border: Border.all(color: borderColor),
                color: tagBgColor,
                borderRadius: BorderRadius.circular(24.0),
              ),
              tagCancelIcon: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(Icons.close, size: 20.0, color: primaryColor),
              ),
              tagPadding:
                  const EdgeInsets.only(left: 18, top: 6, bottom: 6, right: 10),
            ),
            textFieldStyler: TextFieldStyler(
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: inputHintColor,
                    fontFamily: FontFamily.poppins),
                textFieldBorder: UnderlineInputBorder(),
                textFieldEnabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: inputHintColor, width: 0.4),
                ),
                textFieldFocusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 0.4),
                ),
                hintText: "$hintText",
                helperText: ""),
            onTag: (tag) async {
              print("onTag => $tag");
              if (!controller.selected.contains(tag)) {
                controller.selected.add(tag);
                await onTagsChanged(controller.selected);
              }
            },
            onDelete: (tag) async {
              print("onDelete => $tag");
              controller.selected.remove(tag);
              await onTagsChanged(controller.selected);
            },
          ),
          SizedBox(
            height: 8,
          ),
        ],
      );
    });
  }
}
