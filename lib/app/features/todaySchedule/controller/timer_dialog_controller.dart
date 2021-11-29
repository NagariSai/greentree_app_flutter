import 'package:get/get.dart';
import 'package:simple_timer/simple_timer.dart';

class TimerDialogController extends GetxController
    with SingleGetTickerProviderMixin {
  TimerController timerController;
  @override
  void onInit() {
    super.onInit();
    timerController = TimerController(this);
  }

  @override
  void onReady() {
    timerController?.start();
    super.onReady();
  }

  @override
  void dispose() {
    timerController?.dispose();
    super.dispose();
  }
}
