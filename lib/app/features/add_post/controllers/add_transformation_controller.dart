import 'dart:io';

import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/model/master/master_tag_entity.dart' as tags;
import 'package:fit_beat/app/data/model/recipe/add_recipe_request_entity.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class AddTransformationController extends GetxController {
  final ApiRepository repository;

  AddTransformationController({
    @required this.repository,
  }) : assert(repository != null);

  var selectedStringTags = <String>[];
  var masterTagEntity = tags.MasterTagEntity();
  var selectedTag = <tags.Datum>[];
  String postDescription = "";
  String lostKgs = "";
  String duration = "";
  File beforeMediaFile;
  File afterMediaFile;
  String beforeMediaUrl = "";
  String afterMediaUrl = "";
  Feed feedData;
  final TextEditingController kgController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    masterTagEntity = PrefData().getMasterTags();
    feedData = Get.arguments;
    print("feed $feedData");
    if (feedData != null) setData();
  }

  void addMedia(BuildContext context, int type) async {
    try {
      PermissionService getPermission = PermissionService.gallery();
      await getPermission.getPermission(context);

      if (getPermission.granted == false) {
        print("permission false");
        //Permission is not granted
        return;
      }

      var file =
          await MediaPickerService().pickImage(source: ImageSource.gallery);
      if (file != null) {
        if (Utils.isFileImage(file)) {
          if (type == 1) {
            beforeMediaFile = file;
          } else {
            afterMediaFile = file;
          }
          update();
        } else {
          Utils.showErrorSnackBar("Please select image");
        }
      }
    } catch (_) {
      Utils.showErrorSnackBar("Please select image");
    }
  }

  void submitPost() async {
    try {
      tagSelectionLogic();
      if (postDescription.isNotEmpty &&
          beforeMediaFile != null &&
          afterMediaFile != null &&
          selectedTag.length > 0 &&
          lostKgs.isNotEmpty &&
          duration.isNotEmpty) {
        Utils.showLoadingDialog();
        var beforeResponse;
        if (beforeMediaUrl == "") {
          beforeResponse =
              await repository.uploadSingleMedia(beforeMediaFile, 3);
        }

        if (beforeMediaUrl != "" || beforeResponse.status) {
          beforeMediaUrl = beforeMediaUrl != ""
              ? beforeMediaUrl
              : beforeResponse.url[0].mediaUrl;

          var afterResponse;
          if (afterMediaUrl == "") {
            afterResponse =
                await repository.uploadSingleMedia(afterMediaFile, 3);
          }

          if (afterMediaUrl != "" || afterResponse.status) {
            afterMediaUrl = afterMediaUrl != ""
                ? afterMediaUrl
                : afterResponse.url[0].mediaUrl;

            var postResponse = await repository.postTransformation(
                beforeMediaUrl,
                afterMediaUrl,
                postDescription,
                selectedTag
                    .map((element) => UserTag(
                        title: element.title,
                        userTagId: feedData != null
                            ? feedData.userTags
                                    .where((data) =>
                                        data.masterTagId == element.masterTagId)
                                    .isEmpty
                                ? 0
                                : feedData.userTags[0].userTagId
                            : 0,
                        masterTagId: element.masterTagId != null
                            ? element.masterTagId
                            : 0))
                    .toList(),
                lostKgs,
                duration,
                feedData);

            if (postResponse.status) {
              if (!PrefData().isCoach()) {
                Get.find<HomeController>()?.refreshFeeds();
              }
              Utils.dismissLoadingDialog();
              Get.back();
              Utils.showSucessSnackBar(postResponse.message);
            } else {
              Utils.dismissLoadingDialog();
              Utils.showErrorSnackBar(
                  postResponse.message ?? "Unable to add post");
            }
          } else {
            Utils.dismissLoadingDialog();
            Utils.showErrorSnackBar(
                afterResponse.message ?? "Unable to add post");
          }
        } else {
          Utils.dismissLoadingDialog();
          Utils.showErrorSnackBar(
              beforeResponse.message ?? "Unable to add post");
        }
      } else {
        Utils.showErrorSnackBar("Fields cannot be empty");
      }
    } catch (_) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(_.toString());
    }
  }

  void tagSelectionLogic() {
    List<String> all_selected = selectedStringTags;

    var all_suggested_as_string = masterTagEntity.data.map((e) => e.title);

    var selected_and_suggested = all_suggested_as_string
        .where((element) => all_selected.contains(element));

    var selected_but_not_suggested = all_selected
        .where((element) => !selected_and_suggested.contains(element));

    var selected_and_suggested_object = masterTagEntity.data
        .where((element) => selected_and_suggested.contains(element.title))
        .toList();

    selected_but_not_suggested.forEach((element) {
      print(element);
      selected_and_suggested_object
          .add(tags.Datum(title: element, masterTagId: 0));
    });

    print("selected_and_suggested_object => : $selected_and_suggested_object");
    selectedTag = selected_and_suggested_object;
  }

  void removeMedia(int type) {
    if (type == 1) {
      beforeMediaFile = null;
      beforeMediaUrl = "";
    } else {
      afterMediaFile = null;
      afterMediaUrl = "";
    }
    update();
  }

  void setData() {
    postDescription = feedData.descriptions;
    descController.text = postDescription;
    beforeMediaUrl = feedData.userMedia[0].mediaUrl;
    beforeMediaFile = File("");
    afterMediaFile = File("");
    afterMediaUrl = feedData.userMedia[0].mediaUrl2;
    lostKgs = feedData.lostKgs.toString();
    kgController.text = lostKgs;
    duration = feedData.duration.toString();
    durationController.text = duration;

    selectedStringTags = feedData.userTags.map((e) => e.title).toList();
  }
}
