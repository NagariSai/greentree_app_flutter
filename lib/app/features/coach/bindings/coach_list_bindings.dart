import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach/controller/coach_list_controller.dart';
import 'package:get/get.dart';

class CoachListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoachListController>(
      () => CoachListController(
          repository: ApiRepository(apiClient: ApiClient())),
    );
  }
}
