import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach/controller/coach_enroll_request_controller.dart';
import 'package:get/get.dart';

class CoachEnrollRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoachEnrollRequestController>(
      () => CoachEnrollRequestController(
          repository: ApiRepository(apiClient: ApiClient())),
    );
  }
}
