import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:get/get.dart';

class NutritionScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NutritionController>(
          () => NutritionController(repository: ApiRepository(apiClient: ApiClient())),
    );
  }
}
