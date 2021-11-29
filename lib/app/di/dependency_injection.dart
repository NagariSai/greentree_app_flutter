import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put<ApiRepository>(ApiRepository(apiClient: ApiClient()));
  }
}
