import 'package:fit_beat/app/data/model/notification_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queries/collections.dart';

class NotificationController extends GetxController {
  final ApiRepository repository;

  NotificationController({@required this.repository})
      : assert(repository != null);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int pageLimit = 20;
  bool feedLastPage = false;
  int pageNo = 1;
  Dictionary<String, List<UserNotification>> notificationListMap = Dictionary();

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  void getNotificationList() async {
    try {
      if (pageNo == 1) {
        _isLoading = true;
        update();
      }
      var response = await repository.notificationList(
          pageNo: pageNo, pageRecord: pageLimit);
      if (response.status) {
        if (response.data != null && response.data.rows != null) {
          if (pageNo == 1) {
            //userNotificationList.clear();
          }
          var hashMap = await getSortedData(response.data.rows);
          notificationListMap = hashMap;
        } else {
          feedLastPage = true;
        }
      }
      if (pageNo == 1) {
        _isLoading = false;
      }
      update();
    } on Exception catch (e) {
      _isLoading = false;
      update();
      print("Error => $e");
    }
  }

  void deleteNotification() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.deleteNotificationData();
      if (response.status) {
        getNotificationList();
        Utils.dismissLoadingDialog();
      }
    } catch (e) {
      Utils.dismissLoadingDialog();
    }
  }

  Future<Dictionary<String, List<UserNotification>>> getSortedData(
      List<UserNotification> data) async {
    return Collection(data)
        .groupBy((e) =>
            Utils.convertEpochToMonth(e.createDatetime.millisecondsSinceEpoch))
        .toDictionary$1((e) => e?.key, (e) => e?.toList());
  }
}
