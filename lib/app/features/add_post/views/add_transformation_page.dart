import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/media_url_widget.dart';
import 'package:fit_beat/app/common_widgets/media_widget.dart';
import 'package:fit_beat/app/common_widgets/tag_widget.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/add_post/controllers/add_transformation_controller.dart';
import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransformationPage extends StatelessWidget {
  final String negativeText = "Cancel";
  final String positiveText = "Post";
  final String title = "Post your transformation";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        negativeText: negativeText,
        positiveText: positiveText,
        onNegativeTap: () => Get.back(),
        onPositiveTap: () =>
            Get.find<AddTransformationController>().submitPost(),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<AddTransformationController>(
        init: AddTransformationController(
          repository: ApiRepository(apiClient: ApiClient()),
        ),
        builder: (_) => SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    color: titleBlackColor,
                    size: 21,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextInputContainer(
                    controller: _.descController,
                    title: "",
                    inputHint: "More about your transformation",
                    minLines: 5,
                    maxLength: 160,
                    maxLines: 7,
                    onChange: (value) {
                      _.postDescription = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputContainer(
                          controller: _.kgController,
                          title: "Lost Kgs",
                          inputHint: "0.0",
                          textInputType: TextInputType.number,
                          onChange: (value) {
                            _.lostKgs = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: TextInputContainer(
                          controller: _.durationController,
                          title: "Duration",
                          inputHint: "Months",
                          textInputType: TextInputType.number,
                          onChange: (value) {
                            _.duration = value;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomInputContainer(
                    title: "Add photo",
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          _.beforeMediaUrl != ""
                              ? MediaUrlWidget(
                                  width: 150,
                                  height: 170,
                                  beforeAfterText: "Before",
                                  onRemove: () => _.removeMedia(1),
                                  onTap: () => _.addMedia(context, 1),
                                  mediaUrl: _.beforeMediaUrl,
                                )
                              : MediaWidget(
                                  width: 150,
                                  height: 170,
                                  beforeAfterText: "Before",
                                  onRemove: () => _.removeMedia(1),
                                  onTap: () => _.addMedia(context, 1),
                                  mediaFile: _.beforeMediaFile,
                                ),
                          SizedBox(
                            width: 7,
                          ),
                          _.afterMediaUrl != ""
                              ? MediaUrlWidget(
                                  width: 150,
                                  height: 170,
                                  beforeAfterText: "After",
                                  onRemove: () => _.removeMedia(2),
                                  onTap: () => _.addMedia(context, 2),
                                  mediaUrl: _.afterMediaUrl,
                                )
                              : MediaWidget(
                                  width: 150,
                                  height: 170,
                                  beforeAfterText: "After",
                                  onTap: () => _.addMedia(context, 2),
                                  onRemove: () => _.removeMedia(2),
                                  mediaFile: _.afterMediaFile),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TagWidget(
                    selectedString:
                        _.feedData == null ? null : _.selectedStringTags,
                    suggestedTags:
                        _.masterTagEntity.data.map((e) => e.title).toList(),
                    onTagsChanged: (value) {
                      _.selectedStringTags = value;
                      print("selectedStringTags => ${_.selectedStringTags}");
                    },
                  ),
                ],
              ),
            ));
  }
}
