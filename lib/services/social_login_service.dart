import 'package:fit_beat/app/constant/strings.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginService {
  Future<Map<String, dynamic>> doSocialLogin(String loginType) async {
    Map<String, dynamic> loginData = Map();
    if (loginType.contains("google")) {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );

      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null &&
          googleSignInAccount.email != null &&
          googleSignInAccount.email.isNotEmpty) {
        loginData.putIfAbsent("email", () => googleSignInAccount.email ?? "");
        loginData.putIfAbsent("name", () => googleSignInAccount.displayName);
        loginData.putIfAbsent("id", () => googleSignInAccount.id);
        loginData.putIfAbsent("error", () => "");
        return loginData;
      }
    } else if (loginType.contains("facebook")) {
      try {
        var _accessToken = await FacebookAuth.instance
            .login(); // by the fault we request the email and the public profile

        // loginBehavior is only supported for Android devices, for ios it will be ignored
        // _accessToken = await FacebookAuth.instance.login(
        //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
        //   loginBehavior:
        //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
        // );
        // get the user data
        // by default we get the userId, email,name and picture
        loginData = await FacebookAuth.instance
            .getUserData(fields: "name,email,picture.width(200),id");
        loginData.putIfAbsent("error", () => "");

        return loginData;

        // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      } on FacebookAuthException catch (e) {
        // if the facebook login fails
        print(e.message); // print the error message in console
        print(e.errorCode); // print the error message in console
        // check the error type
        loginData.putIfAbsent("error", () => "Login Failed");
        return loginData;

        /*switch (e.errorCode) {
          case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
            print("You have a previous login operation in progress");
            break;
          case FacebookAuthErrorCode.CANCELLED:
            print("login cancelled");
            break;
          case FacebookAuthErrorCode.FAILED:
            print("login failed");
            break;
        }*/
      } catch (e, s) {
        // print in the logs the unknown errors
        loginData.putIfAbsent("error", () => "Login Failed");
        return loginData;
      }
    } else {}
  }

  Future<bool> handleLogout(String loginType) async {
    if (loginType.contains("facebook")) {
      try {
        await FacebookAuth.instance.logOut();
        return true;
      } on FacebookAuthException catch (e) {
        return false;
      }
    } else if (loginType.contains("google")) {
      try {
        var google = await GoogleSignIn().signOut();
        return true;
      } catch (_) {
        return false;
      }
    } else {}
  }
}
