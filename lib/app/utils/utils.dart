import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:connectivity/connectivity.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Utils {
  static void back(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
  static int selectedCat;
  static bool isAppbarVisible=true;
  static String convertEpochToMonth(int dateTime) {
    print("epoch $dateTime");
    if (dateTime == null) return "";
    DateTime localTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
    return "${DateFormat("MMM").format(localTime)} ${localTime.year}"
        .toUpperCase();
  }

  static void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
    ));
  }

  static Future<bool> isConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static void showLoadingDialog() {
    Get.generalDialog(
        barrierColor: Colors.white.withOpacity(0.2),
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 0),
        pageBuilder: (context, animation, secondaryAnimation) =>
            SizedBox.expand(
              // makes widget fullscreen
              child: Center(
                child: Card(
                    color: Colors.white.withOpacity(.9),
                    elevation: 4,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    )),
              ),
            ));
  }

  static void showProgressLoadingDialog() {
    Get.generalDialog(
      barrierColor: Colors.white.withOpacity(0.2),
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) =>
          GetBuilder<ProgressController>(builder: (_) {
        print("val ${_.progress}");
        return SizedBox.expand(
          // makes widget fullscreen
          child: Center(
            child: Card(
                color: Colors.white.withOpacity(.9),
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: CircularPercentIndicator(
                    radius: 60,
                    progressColor: primaryColor,
                    percent: _.progress / 100,
                  ),
                )),
          ),
        );
      }),
    );
  }

  static void dismissLoadingDialog() {
    Get.back();
  }

  static void showErrorSnackBar(String error, {bool instantInit = true}) {
    Get.snackbar("Error", error,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        instantInit: instantInit,
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  static void showAlertSnackBar(String error, {bool instantInit = true}) {
    Get.snackbar("Alert", error,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.yellow,
        instantInit: instantInit,
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  static void showSucessSnackBar(String error) {
    Get.snackbar("Success", error,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  static DateTime convertTimeToDateTime(TimeOfDay timeOfDay) {
    final now = new DateTime.now();
    return new DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  static DateTime convertDateTimeAndAddTime(
      DateTime dateTime, int hours, int minute) {
    return new DateTime(
        dateTime.year, dateTime.month, dateTime.day, hours, minute);
  }

  static Widget getCircularProgressIndicator() {
    return Container(
        height: 40,
        width: 40,
        child: Center(child: CircularProgressIndicator()));
  }

  static Widget getNoDataWidget() {
    return Container(
        child: Center(
            child: CustomText(
      text: "No Data Found",
      size: 18,
      color: Colors.black,
    )));
  }

  static void dismissKeyboard() {
    Get.focusScope.unfocus();
  }

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String getFileExtension(File file) {
    return file.path.split('.').last.toLowerCase();
  }

  static bool isFileImageOrVideo(File file) {
    var extension = getFileExtension(file);
    if (extension.contains("jpg") ||
        extension.contains("jpeg") ||
        extension.contains("png") ||
        extension.contains("mp4") ||
        extension.contains("mkv") ||
        extension.contains("mov")) {
      return true;
    }
    return false;
  }

  static bool isFileImage(File file) {
    var extension = getFileExtension(file);
    if (extension.contains("jpg") ||
        extension.contains("jpeg") ||
        extension.contains("png")) {
      return true;
    }
    return false;
  }

  static formatVideoDuration(double time) {
    var duration = Duration(milliseconds: time.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String getMediaType(File file) {
    var data = isFileImage(file);
    if (data) {
      return "Image";
    }
    return "Video";
  }

  static int getRandomNumber() {
    int max = 5;

    return Random().nextInt(max) + 1;
  }

  static double getLength(String text, double fontSize, String fontFamily) {
    final constraints = BoxConstraints(
      maxWidth: 800.0, // maxwidth calculated
      minHeight: 0.0,
      minWidth: 0.0,
    );

    RenderParagraph renderParagraph = RenderParagraph(
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      ),
      maxLines: 1,
      textDirection: ui.TextDirection.ltr,
    );
    renderParagraph.layout(constraints);
    double textlen =
        renderParagraph.getMinIntrinsicWidth(fontSize).ceilToDouble();
    return textlen;
  }

  static String convertDateIntoDisplayString(DateTime date) {
    var format = DateFormat.yMMMEd();
    return date != null ? format.format(date) : null;
  }

  static String convertDateIntoFormattedString(DateTime date) {
    return date != null ? "${date.day}/${date.month}/${date.year}" : null;
  }

  static String getFormattedTags(List<FeedUserTag> tags) {
    var allTag = "";
    for (FeedUserTag tag in tags) {
      allTag = allTag + (allTag.isNotEmpty ? " #" : "#") + tag.title;
    }

    return allTag;
  }

  static formatFoodType(String type) {
    var foodtype = "";
    if (type == "1") {
      foodtype = "Veg";
    } else if (type == "2") {
      foodtype = "Nonveg";
    } else if (type == "3") {
      foodtype = "Eggetarian";
    } else {
      foodtype = "Vegan";
    }
    return foodtype;
  }

  static String getChatInvitationText(int status) {
    var result = "Invite";

    if (status == 0) {
      result = "Invite";
    } else if (status == 1) {
      result = "Invited";
    } else if (status == 2) {
      result = "Accept";
    } else {
      result = "Message";
    }

    return result;
  }

  String formatTimeOfDay(TimeOfDay tod) {
    if (tod == null) return "";
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  String getQuatityType(int quantityType) {
   // print("quantityType:"+quantityType.toString());
    String qtyType = "gm";
    if (quantityType == 1) {
      qtyType = "gm";
    } else if (quantityType == 2) {
      qtyType = "mg";
    } else if (quantityType == 3) {
      qtyType = "kg";
    } else if (quantityType == 4) {
      qtyType = "ml";
    } else if (quantityType == 5) {
      qtyType = "L";
    } else if (quantityType == 6) {
      qtyType = "piece";
    }
    print("qttype:"+qtyType);
    return qtyType;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String getCoachExp(int expLevel) {
    String coachExp = "Basic";
    switch (expLevel) {
      case 1:
        coachExp = "Basic";
        break;
      case 2:
        coachExp = "Standard";
        break;
      case 3:
        coachExp = "Advanced";
        break;
      case 4:
        coachExp = "Proficient";
        break;
      case 5:
        coachExp = "Expert";
        break;
    }
    return coachExp;
  }

  static String getCurrentDate(){

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);
    var format = DateFormat.yMMMEd();
    return format.format(new DateTime.now());
    //var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

   //  return formattedDate.toString() ;



  }
}
