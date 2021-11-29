import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:get/get.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailController>(
      () => UserDetailController(
          repository: ApiRepository(apiClient: ApiClient())),
    );
  }
}
