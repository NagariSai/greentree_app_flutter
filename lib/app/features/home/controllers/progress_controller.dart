import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ProgressController extends GetxController {
  double progress = 0.0;

  void updateProgress(double value) {
    progress = value;
    Get.back();
    Utils.showProgressLoadingDialog();
  }
}
