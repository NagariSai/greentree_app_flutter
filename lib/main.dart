import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/di/dependency_injection.dart';
import 'package:fit_beat/app/features/common_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_theme.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:fit_beat/services/social_login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:flutter/rendering.dart';
import 'app/constant/strings.dart';
import 'app/data/repository/api_repository.dart';

void main() async {
  //debugPaintSizeEnabled = true;

  //debugPaintBaselinesEnabled = true;

  //debugPaintPointersEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    DependencyInjection.init();
    await GetStorage.init();
    await Firebase.initializeApp();
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    Get.put(
        CommonController(repository: ApiRepository(apiClient: ApiClient())));
    Get.put(SocialLoginService());
    runApp(MyApp());
  });
}

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({
     Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("login ${PrefData().isUserLoginIn()}");
    return GetMaterialApp(
      title: Strings.appName,
      initialRoute: PrefData().isUserLoginIn()? PrefData().isCoach()? Routes.coachMain: Routes.main: Routes.intro,
      getPages: AppPages.routes,
      theme: appThemeData,
      defaultTransition: Transition.fade,
    );
  }
}
