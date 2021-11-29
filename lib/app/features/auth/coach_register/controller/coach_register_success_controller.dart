import 'package:get/get.dart';

class CoachRegisterSuccessController extends GetxController {
  String msg;
  @override
  void onInit() {
    super.onInit();
    msg = Get.arguments ?? "";
    update();
  }
}
