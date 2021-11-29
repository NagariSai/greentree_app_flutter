import 'dart:io';
import 'dart:io' show Platform;

import 'package:fit_beat/app/data/model/add_post/media_upload_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart' as media;
import 'package:fit_beat/app/data/model/master/master_tag_entity.dart';
import 'package:fit_beat/app/data/model/master/master_tag_entity.dart' as tags;
import 'package:fit_beat/app/data/model/recipe/add_recipe_request_entity.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/features/home/controllers/other_feed_controller.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class AddPostController extends GetxController {
  final ApiRepository repository;

  /// postType 0 => Start a discussion, 1 => Post your challenge, 2 => Post an update,
  final int postType;
  final int masterPostId;
  final String preTitle;
  final String otherType;
  final Feed feedData;

  AddPostController(
      {@required this.repository,
      @required this.postType,
      this.preTitle = "",
      this.masterPostId,
      this.otherType = "",
      this.feedData})
      : assert(repository != null && postType != null);
  List<File> mediaPathList = List();

  var selectedStringTags = <String>[];
  MasterTagEntity masterTagEntity;
  var selectedTag = <tags.Datum>[];
  String postTitle = "";
  String postDescription = "";
  final TextEditingController descController = TextEditingController();
  final TextEditingController postTitleController = TextEditingController();
  List<media.UserMedia> mediaUrlList = [];

  @override
  void onInit() {
    super.onInit();
    masterTagEntity = PrefData().getMasterTags();
    print("fdata ${feedData?.userId}");
    if (feedData != null) setData();
  }

  void addMedia(BuildContext context) async {
    try {
      PermissionService getPermission = PermissionService.gallery();
      await getPermission.getPermission(context);

      if (getPermission.granted == false) {
        print("permission false");
        //Permission is not granted
        return;
      }

      var file = Platform.isAndroid
          ? await MediaPickerService().pickImageOrVideo()
          : await MediaPickerService().pickImage(source: ImageSource.gallery);

      if (file != null) {
        if (Utils.isFileImageOrVideo(file)) {
          mediaPathList.add(file);
          update();
        } else {
          Utils.showErrorSnackBar("Please select image or video");
        }
      } else {
        Utils.showErrorSnackBar("Please select image or video");
      }
    } catch (_) {
      Utils.showErrorSnackBar("exception");
    }
  }

  void removeMedia(int position) {
    mediaPathList.removeAt(position);
    update();
  }

  void removeUrlMedia(int position) {
    mediaUrlList.removeAt(position);
    update();
  }

  void tagSelectionLogic() {
    try {
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

      print(
          "selected_and_suggested_object => : $selected_and_suggested_object");
      selectedTag = selected_and_suggested_object;
    } catch (_) {
      print(_.toString());
    }
  }

  void submitPost() async {
    try {
      tagSelectionLogic();
      if (postDescription.isNotEmpty &&
          mediaPathList.length + mediaUrlList.length > 0 &&
          selectedTag.length > 0 &&
          ((postType == 0 || postType == 1) && otherType == ""
              ? postTitle.isNotEmpty
              : true)) {
        Get.find<ProgressController>().progress = 0.0;
        Utils.showProgressLoadingDialog();

        var response =
            await repository.uploadMedia(mediaPathList, getMediaCategory());

        if (response.status) {
          Utils.dismissLoadingDialog();

          Utils.showLoadingDialog();

          var postResponse;
          if (postType == 0) {
            List<MediaUrl> mediaUrl = [];
            mediaUrl.addAll(response.url);
            for (media.UserMedia data in mediaUrlList) {
              mediaUrl.add(MediaUrl(
                  mediaType: data.mediaType,
                  mediaUrl: data.mediaUrl,
                  userMediaId: data.userMediaId));
            }
            postResponse = await repository.postDiscussion(
                mediaUrl,
                otherType == "true" ? preTitle : postTitle,
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
                otherType == "true" ? masterPostId : null,
                feedData);
          } else if (postType == 1) {
            postResponse = await repository.postChallenge(
                response.url,
                otherType == "true" ? preTitle : postTitle,
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
                otherType == "true" ? masterPostId : null,
                feedData);
          } else if (postType == 2) {
            postResponse = await repository.postUpdate(
                response.url,
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
                    .toList());
          }

          if (postResponse.status) {
            if (!PrefData().isCoach()) {
              Get.find<HomeController>()?.refreshFeeds();
              if (otherType == "true") {
                try {
                  var cont = Get.find<OtherFeedController>();
                  if (cont != null) cont.refreshFeeds();
                } catch (_) {
                  print("other feed controller not found");
                }
              }
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
          Utils.showErrorSnackBar(response.message ?? "Unable to add post");
        }
      } else {
        Utils.showErrorSnackBar("Fields cannot be empty");
      }
    } catch (_) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(_.toString());
    }
  }

  int getMediaCategory() {
    int cat = 1;
    if (postType == 0) {
      cat = 1;
    } else if (postType == 1) {
      cat = 2;
    } else {
      cat = 5;
    }
    return cat;
  }

  void setData() {
    postDescription = feedData.descriptions;
    descController.text = postDescription;

    postTitle = feedData.title;
    postTitleController.text = postTitle;
    mediaUrlList = feedData.userMedia;
    selectedStringTags = feedData.userTags.map((e) => e.title).toList();
  }
}
