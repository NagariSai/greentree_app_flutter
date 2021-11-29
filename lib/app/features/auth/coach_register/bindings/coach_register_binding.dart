import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/auth/coach_register/controller/coach_register_controller.dart';
import 'package:get/get.dart';

class CoachRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CoachRegisterController(
        repository: ApiRepository(apiClient: ApiClient())));
  }
}
