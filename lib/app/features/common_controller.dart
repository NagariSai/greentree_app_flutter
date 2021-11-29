import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/coach_home/controller/coach_all_post_controller.dart';
import 'package:fit_beat/app/features/coach_home/controller/coach_my_post_controller.dart';
import 'package:fit_beat/app/features/home/controllers/home_controller.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/recipe/controller/recipe_controller.dart';
import 'package:fit_beat/app/features/search/controller/search_controller.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  final ApiRepository repository;

  CommonController({this.repository});

  @override
  void onInit() {
    super.onInit();
  }

  updateUI() {
    if (Get.find<MainController>().selectedIndex == 3) {
      Get.find<RecipeController>().updateRecipeList();
    } else {
      Get.find<HomeController>().updateHomeList();
    }

    if (PrefData().isCoach()) {
      try {
        Get.find<CoachMyPostController>().updateHomeList();
      } catch (_) {}

      try {
        Get.find<CoachAllPostController>().updateHomeList();
      } catch (_) {}
    }
  }

  updateData() {
    if (Get.find<MainController>().selectedIndex == 3) {
      Get.find<RecipeController>().reloadFeeds();
    } else {
      Get.find<HomeController>().reloadFeeds();
    }

    if (PrefData().isCoach()) {
      try {
        Get.find<CoachMyPostController>().updateHomeList();
      } catch (_) {}

      try {
        Get.find<CoachAllPostController>().updateHomeList();
      } catch (_) {}
    }

    try {
      Get.find<SearchController>().reloadSearch();
    } catch (_) {}
  }

  void likePost({var uniqueId, var type}) async {
    try {
      updateUI();
      var response = await repository.likePost(uniqueId: uniqueId, type: type);
      if (response.status) {
        updateData();
      }
    } catch (e) {
      print("error likePost  ${e.toString()}");
    }
  }

  void bookmarkPost({var uniqueId, var type}) async {
    try {
      updateUI();
      var response =
          await repository.bookmarkPost(uniqueId: uniqueId, type: type);
      if (response.status) {
        updateData();
      }
    } catch (e) {
      print("error bookmarkPost  ${e.toString()}");
    }
  }

  void deletePost({var uniqueId, var type}) async {
    //deletePost
    try {
      Utils.showLoadingDialog();
      var response =
          await repository.deletePost(uniqueId: uniqueId, type: type);
      Utils.dismissLoadingDialog();
      if (response.status) {
        Utils.showSucessSnackBar(response.message);
        updateData();
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
      print("error delete post  ${e.toString()}");
    }
  }
}
