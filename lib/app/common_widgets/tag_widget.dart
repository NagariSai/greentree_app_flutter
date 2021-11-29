import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/interest_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

/*class TagWidget extends StatelessWidget {
  final List<dynamic> suggestedTags;
  final Function(dynamic) onTagsChanged;

  const TagWidget({Key key, @required this.suggestedTags, this.onTagsChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInputContainer(
      title: "Add Tag",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
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
                hintText: "+ Enter Tag",
                helperText: ""),
            onTag: (tag) {},
            onDelete: (tag) {},
          ),
          SizedBox(
            height: 8,
          ),
          CustomText(
            text: "Suggested Tags",
            color: titleBlackColor,
            size: 16,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 24,
          ),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: List<Widget>.generate(suggestedTags.length, (int index) {
              return ChipWidget(
                title: suggestedTags[index],
                onTap: () {
                  print("suggestedTags[index] => ${suggestedTags[index]}");
                },
              );
            }),
          )
        ],
      ),
    );
  }
}*/

class TagController extends GetxController {
  List<String> selected;

  TagController(this.selected);
}

class TagWidget extends StatelessWidget {
  final List<dynamic> suggestedTags;
  final Function(dynamic) onTagsChanged;
  final List<String> selectedString;

  TagWidget(
      {Key key,
      @required this.suggestedTags,
      this.onTagsChanged,
      this.selectedString})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    Get.put(TagController(selectedString != null ? selectedString : []));

    return GetBuilder<TagController>(builder: (controller) {
      return CustomInputContainer(
        title: "Add Tag",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            TextFieldTags(
              textSeparators: [","],
              initialTags: getInitalSelectedTags(controller),
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
                tagPadding: const EdgeInsets.only(
                    left: 18, top: 6, bottom: 6, right: 10),
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
                  hintText: "+ Enter Tag",
                  helperText: ""),
              onTag: (tag) async {
                print("onTag => $tag");
                print("cont null ${controller == null}");

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
            CustomText(
              text: "Suggested Tags",
              color: titleBlackColor,
              size: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 24,
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: List<Widget>.generate(
                  suggestedTags.length,
                  (int index) => InterestContainer(
                        onTap: () {
                          if (controller.selected
                              .contains(suggestedTags[index])) {
                            controller.selected.remove(suggestedTags[index]);
                          } else {
                            controller.selected.add(suggestedTags[index]);
                          }
                          controller.update();
                          onTagsChanged(controller.selected);
                        },
                        isSelected: (controller.selected
                            .contains(suggestedTags[index])),
                        backgroundColor: Color.fromRGBO(178, 200, 210, 1),
                        label: suggestedTags[index],
                      )),
            )
          ],
        ),
      );
    });
  }

  List<String> getInitalSelectedTags(TagController controller) {
    List<String> initialTags = [];
    for (String j in controller.selected) {
      if (!suggestedTags.contains(j)) {
        initialTags.add(j);
      }
    }
    return initialTags;
  }
}
