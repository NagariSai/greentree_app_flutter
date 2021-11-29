import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/chat/controllers/connection_status_controller.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    ApiRepository apiRepository = Get.find<ApiRepository>();
    Get.put(MainController(repository: apiRepository));
    Get.lazyPut<UserDetailController>(
      () => UserDetailController(repository: apiRepository),
    );

    Get.put(ConnectionStatusController(repository: apiRepository));
  }
}
