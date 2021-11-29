import 'dart:io';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/add_post/media_upload_response.dart';
import 'package:fit_beat/app/data/model/exercise_muscle_type_model.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart'
    as data;
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_exercise_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddExerciseController extends GetxController
    with SingleGetTickerProviderMixin {
  final ApiRepository repository;

  AddExerciseController({@required this.repository})
      : assert(repository != null);

  List<ExerciseMuscleType> exerciseTypeList = [];
  List<data.ExerciseData> exerciseList = [];
  ExerciseMuscleType selectedExerciseType;

  String exerciseTitle = "";
  String exerciseDuration = "";
  String description = "";

  List<File> mediaPathList = [];

  var selectedVideoUrl = <VideoUrl>[];
  List<MediaUrl> mediaUrls = [];

  bool isLoading = true;

  TextEditingController urlController = TextEditingController();
  TabController tabController;

  final List<Widget> tabs = <Widget>[
    Container(height: 35, width: Get.width / 3, child: Tab(text: "Duration")),
    Container(height: 35, width: Get.width / 3, child: Tab(text: "Reps")),
    Container(
        height: 35, width: Get.width / 3, child: Tab(text: "Weight & Reps")),
  ];

  //specification
  List<TextEditingController> setsDurationList = [];
  TextEditingController restSetController = TextEditingController();
  TextEditingController restExerciseController = TextEditingController();

  List<TextEditingController> repsList = [];
  TextEditingController repsSetController = TextEditingController();
  TextEditingController repsExerciseController = TextEditingController();

  List<WeightAndRepsController> weightRepsList = [];
  TextEditingController weightRepsSetController = TextEditingController();
  TextEditingController weightRepsExerciseController = TextEditingController();

  List<ExerciseSpecification> exercisesSpecifications = [];

  @override
  void onInit() {
    super.onInit();
    tabController = new TabController(vsync: this, length: tabs.length);
    setsDurationList.add(TextEditingController());
    repsList.add(TextEditingController());
    weightRepsList.add(WeightAndRepsController(
        repsController: TextEditingController(),
        weightController: TextEditingController()));
    getExerciseTypeList();
  }

  List<Widget> getExerciseTypeWidgetList() {
    List<Widget> exerciseTypeWidgetList = [];
    for (ExerciseMuscleType exerciseType in exerciseTypeList) {
      exerciseTypeWidgetList.add(InkWell(
        onTap: () {
          selectedExerciseType = exerciseType;
          update();
        },
        child: CommonContainer(
            height: 31,
            width: Utils.getLength(exerciseType.title, 14, FontFamily.poppins) +
                40,
            borderRadius: 24,
            backgroundColor: selectedExerciseType.exerciseMuscleTypeId ==
                    exerciseType.exerciseMuscleTypeId
                ? FFB2C8D2
                : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color: selectedExerciseType.exerciseMuscleTypeId ==
                        exerciseType.exerciseMuscleTypeId
                    ? FFB2C8D2
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: exerciseType.title,
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }
    return exerciseTypeWidgetList;
  }

  void getExerciseTypeList() async {
    try {
      isLoading = true;
      var response = await repository.getExerciseMuscleType();
      isLoading = false;
      if (response.status) {
        exerciseTypeList.clear();
        exerciseTypeList.addAll(response.data);
        selectedExerciseType = exerciseTypeList[0];
      }
      update();
    } catch (e) {
      isLoading = false;
      print("error ${e.toString()}");
      update();
    }
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

      // var file = await MediaPickerService().pickVideo();
      var file = Platform.isAndroid
          ? await MediaPickerService().pickVideo()
          : await MediaPickerService()
              .pickGalleryVideo(source: ImageSource.gallery);

      if (file != null) {
        if (Utils.isFileImageOrVideo(file)) {
          mediaPathList.add(file);
          update();
        } else {
          Utils.showErrorSnackBar("Please select video");
        }
      } else {
        Utils.showErrorSnackBar("Please select video");
      }
    } catch (_) {
      Utils.showErrorSnackBar("exception");
    }
  }

  void removeMedia(int position) {
    mediaPathList.removeAt(position);
    update();
  }

  void addExercise() async {
    try {
      if (exerciseTitle.isEmpty) {
        Utils.showErrorSnackBar("Enter exercise name");
      } else if (selectedExerciseType == null) {
        Utils.showErrorSnackBar("Select muscle type");
      } /*else if (exerciseDuration.isEmpty) {
        Utils.showErrorSnackBar("Select exercise duration");
      } */
      else if (mediaPathList.length == 0 && urlController.text.isEmpty) {
        Utils.showErrorSnackBar("add video");
      } else {
        if (mediaPathList.length > 0) {
          Get.find<ProgressController>().progress = 0.0;
          Utils.showProgressLoadingDialog();
          var response = await repository.uploadMedia(mediaPathList, 0);
          if (response.status) {
            Utils.dismissLoadingDialog();
            mediaUrls = response.url;
            for (MediaUrl mediaUrl in mediaUrls) {
              selectedVideoUrl.add(VideoUrl(videoUrl: mediaUrl.mediaUrl));
            }
          }
        } else {
          selectedVideoUrl
              .add(VideoUrl(videoUrl: urlController.text.toString()));
        }
        Utils.showLoadingDialog();
        exercisesSpecifications = [];

        String rest_bw_exercises = "";
        String rest_bw_sets = "";
        if (tabController.index == 0) {
          repsList = [];
          weightRepsList = [];
          rest_bw_sets = restSetController.text.toString();
          rest_bw_exercises = restExerciseController.text.toString();

          for (int i = 0; i < setsDurationList.length; i++) {
            //if (setsDurationList[i].text.toString().isNotEmpty) {
            exercisesSpecifications.add(ExerciseSpecification(
                specificationType: 1,
                user_schedule_activity_specification_id: 0,
                restBwExercises: restSetController.text.toString(),
                restBwSets: restExerciseController.text.toString(),
                setVal1: setsDurationList[i].text.toString(),
                setVal2: ""));
            //}
          }
        } else if (tabController.index == 1) {
          setsDurationList = [];
          weightRepsList = [];
          rest_bw_sets = repsSetController.text.toString();
          rest_bw_exercises = repsExerciseController.text.toString();
          for (int i = 0; i < repsList.length; i++) {
            //if (repsList[i].text.toString().isNotEmpty) {
            exercisesSpecifications.add(ExerciseSpecification(
                specificationType: 2,
                user_schedule_activity_specification_id: 0,
                restBwExercises: repsSetController.text.toString(),
                restBwSets: repsExerciseController.text.toString(),
                setVal1: repsList[i].text.toString(),
                setVal2: ""));
            //}
          }
        } else if (tabController.index == 2) {
          setsDurationList = [];
          repsList = [];
          rest_bw_sets = weightRepsSetController.text.toString();
          rest_bw_exercises = weightRepsSetController.text.toString();
          for (int i = 0; i < weightRepsList.length; i++) {
            // if (weightRepsList[i].repsController.text.toString().isNotEmpty) {
            exercisesSpecifications.add(ExerciseSpecification(
                specificationType: 3,
                user_schedule_activity_specification_id: 0,
                restBwExercises: weightRepsExerciseController.text.toString(),
                restBwSets: weightRepsSetController.text.toString(),
                setVal1: weightRepsList[i].repsController.text.toString(),
                setVal2: weightRepsList[i].weightController.text.toString()));
          }
          //}
        }

        var response = await repository.addExercises(
            title: exerciseTitle,
            description: description,
            exerciseMuscleTypeId: selectedExerciseType.exerciseMuscleTypeId,
            duration: exerciseDuration.toString(),
            exerciseVideo: selectedVideoUrl,
            rest_bw_exercises: rest_bw_exercises,
            rest_bw_sets: rest_bw_sets,
            exercisesSpecifications: exercisesSpecifications);
        Utils.dismissLoadingDialog();
        if (response.status) {
          Get.find<SelectExerciseController>().getExerciseList();
          Get.back();
          Utils.showSucessSnackBar(response.message);
        } else {
          Utils.showErrorSnackBar(response.message);
        }
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
    }
  }

  addDuration() {
    setsDurationList.add(TextEditingController());
    update();
  }

  removeDuration(textEditController) {
    if (setsDurationList.length > 1) {
      setsDurationList.remove(textEditController);
    }
    update();
  }

  addReps() {
    repsList.add(TextEditingController());
    update();
  }

  removeReps(textEditController) {
    if (repsList.length > 1) {
      repsList.remove(textEditController);
    }
    update();
  }

  addWeightReps() {
    weightRepsList.add(WeightAndRepsController(
        weightController: TextEditingController(),
        repsController: TextEditingController()));
    update();
  }

  removeWeightReps(textEditController) {
    if (weightRepsList.length > 1) {
      weightRepsList.remove(textEditController);
    }
    update();
  }
}

class WeightAndRepsController {
  TextEditingController weightController;
  TextEditingController repsController;

  WeightAndRepsController({this.weightController, this.repsController});
}

class ExerciseSpecification {
  ExerciseSpecification(
      {this.exercisesSpecificationId,
      this.exerciseId,
      this.specificationType,
      this.setVal1,
      this.setVal2,
      this.createDatetime,
      this.createDatetimeUnix,
      this.updateDatetime,
      this.updateDatetimeUnix,
      this.textEditingController,
      this.weightAndRepsController,
      this.restBwSets,
      this.restBwExercises,
      this.isExerciseStarted = 0,
      this.is_done,
      this.user_schedule_activity_specification_id = 0});

  var exercisesSpecificationId;
  var exerciseId;
  var specificationType;
  var setVal1;
  var setVal2;
  dynamic createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  String updateDatetimeUnix;
  TextEditingController textEditingController = TextEditingController();
  WeightAndRepsController weightAndRepsController = WeightAndRepsController(
      repsController: TextEditingController(),
      weightController: TextEditingController());
  String restBwSets;
  String restBwExercises;
  int user_schedule_activity_specification_id;
  int isExerciseStarted;
  int is_done;

  factory ExerciseSpecification.fromJson(Map<String, dynamic> json) =>
      ExerciseSpecification(
        is_done: json["is_done"] == null ? 0 : json["is_done"],
        isExerciseStarted: json["is_done"] == null
            ? 0
            : json["is_done"] == 1
                ? 2
                : 0,
        user_schedule_activity_specification_id:
            json["user_schedule_activity_specification_id"] == null
                ? 0
                : json["user_schedule_activity_specification_id"],
        exercisesSpecificationId: json["exercises_specification_id"] == null
            ? null
            : json["exercises_specification_id"],
        exerciseId: json["exercise_id"] == null ? null : json["exercise_id"],
        specificationType: json["specification_type"] == null
            ? null
            : json["specification_type"],
        setVal1: json["set_val_1"] == null ? null : json["set_val_1"],
        setVal2: json["set_val_2"] == null ? null : json["set_val_2"],
        createDatetime: json["create_datetime"],
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"] == null
            ? null
            : json["update_datetime_unix"],
        restBwSets: json["rest_bw_sets"] == null ? null : json["rest_bw_sets"],
        restBwExercises: json["rest_bw_exercises"] == null
            ? null
            : json["rest_bw_exercises"],
      );

  Map<String, dynamic> toJson() => {
        "user_schedule_activity_specification_id":
            user_schedule_activity_specification_id == null
                ? null
                : user_schedule_activity_specification_id,
        "exercises_specification_id":
            exercisesSpecificationId == null ? null : exercisesSpecificationId,
        "exercise_id": exerciseId == null ? null : exerciseId,
        "specification_type":
            specificationType == null ? null : specificationType,
        "set_val_1": setVal1 == null ? null : setVal1,
        "set_val_2": setVal2 == null ? null : setVal2,
        "create_datetime": createDatetime,
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix":
            updateDatetimeUnix == null ? null : updateDatetimeUnix,
        "rest_bw_sets": restBwSets == null ? null : restBwSets,
        "rest_bw_exercises": restBwExercises == null ? null : restBwExercises,
      };
}
