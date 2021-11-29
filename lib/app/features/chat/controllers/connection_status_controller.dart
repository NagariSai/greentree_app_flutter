import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ConnectionStatusController extends GetxController {
  final ApiRepository repository;

  ConnectionStatusController({@required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> sendChatInvite(var userProfileId, var message) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.sendChatInvite(
          userProfileId: userProfileId, message: message);
      Utils.dismissLoadingDialog();
      if (response.status) {
        // Utils.showSucessSnackBar("Invitation sent");
        return true;
      } else {
        Utils.showErrorSnackBar(response.message);
        return false;
      }
    } catch (e) {
      print("followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar("Unable to send invite");
      return false;
    }
  }

  Future<bool> cancelChatInvite(var userProfileId) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.cancelChatInvite(
        userProfileId: userProfileId,
      );
      Utils.dismissLoadingDialog();
      if (response.status) {
        Utils.showSucessSnackBar(response.message);
        return true;
      } else {
        Utils.showErrorSnackBar(response.message);
        return false;
      }
    } catch (e) {
      print("followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar("Unable to cancel invite");
      return false;
    }
  }

  Future<bool> acceptChatInvite(var userProfileId) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.acceptChatInvite(
        userProfileId: userProfileId,
      );
      Utils.dismissLoadingDialog();
      if (response.status) {
        Utils.showSucessSnackBar(response.message);
        return true;
      } else {
        Utils.showErrorSnackBar(response.message);
        return false;
      }
    } catch (e) {
      print("followUser error ${e.toString()}");
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar("Unable to cancel invite");
      return false;
    }
  }
}
