import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FCMPushNotificationsManager {
  FCMPushNotificationsManager._();

  factory FCMPushNotificationsManager() => _instance;

  static final FCMPushNotificationsManager _instance =
      FCMPushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String fcmToken = "";

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() async {
    await _firebaseMessaging.requestPermission();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'ic_launcher',
            ),
          ),
        );
      }
      // handleNotification(message.data);

      print('message ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event ${message.data}');

      handleNotification(message.data);
    });

    _firebaseMessaging.getToken().then((token) async {
      print("fcmToken : $token");
      this.fcmToken = token;

      var isTokenSent = PrefData().isTokenSent();

      if (!isTokenSent && fcmToken != "") {
        var response =
            await ApiRepository(apiClient: ApiClient()).sendFcmToken(fcmToken);
        if (response.status) {
          PrefData().setToken();
        }
      }
    });
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      var response =
          await ApiRepository(apiClient: ApiClient()).sendFcmToken(token);
      if (response.status) {
        PrefData().setToken();
      }
    });
  }

  void handleNotification(Map<String, dynamic> data) {
    try {
      var notificationType = data["notification_type"];
      if (notificationType == "1") {
        var type = data["type"];

        if (type == "1") {
          print("discussion");

          Get.toNamed(Routes.discussion_detail_page, arguments: [
            int.parse(data["unique_id"]),
            int.parse(type),
            int.parse(data["tried_count"]),
            data["title"],
          ]);
        } else if (type == "2") {
          Get.toNamed(Routes.challenge_detail_page, arguments: [
            int.parse(data["unique_id"]),
            int.parse(type),
          ]);
        } else if (type == "3") {
          Get.toNamed(Routes.transformation_detail_page, arguments: [
            int.parse(data["unique_id"]),
            int.parse(type),
          ]);
        } else if (type == "4") {
          Get.toNamed(Routes.receipe_detail_page, arguments: [
            int.parse(data["unique_id"]),
            int.parse(type),
          ]);
        } else if (type == "5") {
          Get.toNamed(Routes.post_update_detail_page, arguments: [
            int.parse(data["unique_id"]),
            int.parse(type),
          ]);
        } else if (type == "6") {
          Get.toNamed(Routes.otherFeedPage, parameters: {
            "count": data["tried_count"],
            "title": data["title"],
            "isChallenge": "true",
            "masterPostId": data["unique_id"],
          });
        }
      } else if (notificationType == "2") {
        //chat

        Get.toNamed(Routes.chatPage, arguments: [
          int.parse(data["user_id"]),
          data["full_name"],
          data["profile_url"],
          int.parse(data["user_chat_connection_id"]),
        ]);
      } else if (notificationType == "3") {
        // profile
        Get.toNamed(Routes.userProfile,
            arguments: [int.parse(data["user_id"]), 1]);
      } else if (notificationType == "4") {
        // profile
        Get.toNamed(
          Routes.waterReminderPage,
        );
      }
    } catch (_) {
      print("exception ${_.toString()}");
    }
  }
}
