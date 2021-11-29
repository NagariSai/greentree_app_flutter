import 'package:get/get.dart';

class CustomSwitchController extends GetxController {
  bool isFirstTabSelected = false;
  bool isSecondTabSelected = false;

  CustomSwitchController({this.isFirstTabSelected, this.isSecondTabSelected});

  @override
  void onInit() {
    super.onInit();
  }

  onFirsTabSelect() {
    this.isFirstTabSelected = true;
    this.isSecondTabSelected = false;
    update();
  }

  onSecondTabSelect() {
    this.isFirstTabSelected = false;
    this.isSecondTabSelected = true;
    update();
  }
}
