import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach_trained_pople/controller/coach_trained_pople_controller.dart';
import 'package:get/get.dart';

class CoachTrainedPeopleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoachTrainedPopleController>(
      () => CoachTrainedPopleController(
          repository: ApiRepository(apiClient: ApiClient())),
    );
  }
}
