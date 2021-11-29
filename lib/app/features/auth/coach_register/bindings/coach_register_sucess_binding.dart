import 'package:fit_beat/app/features/auth/coach_register/controller/coach_register_success_controller.dart';
import 'package:get/get.dart';

class CoachRegisterSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CoachRegisterSuccessController());
  }
}
