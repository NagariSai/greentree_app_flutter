import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/auth/verify_otp/controllers/verify_otp_controller.dart';
import 'package:get/get.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        VerifyOtpController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
