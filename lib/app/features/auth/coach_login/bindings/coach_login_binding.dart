import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/auth/coach_login/controllers/coach_login_controller.dart';
import 'package:get/get.dart';

class CoachLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CoachLoginController(
        repository: ApiRepository(apiClient: ApiClient())));
  }
}
