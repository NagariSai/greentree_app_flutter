import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/my_profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () =>
          ProfileController(repository: ApiRepository(apiClient: ApiClient())),
    );
  }
}
