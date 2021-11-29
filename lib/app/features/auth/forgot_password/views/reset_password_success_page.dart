/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: tickGreenColor,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomText(
                  text: 'Password has been updated Successfully.',
                  size: 16,
                  color: lightWhiteColor,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              FlatButton(
                minWidth: 180,
                height: 50,
                color: yellowColor,
                onPressed: _goToLoginPage,
                child: CustomText(
                  text: 'Ok',
                  color: Colors.black,
                  size: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Align(alignment: Alignment.bottomCenter, child: MusicWidget()),
        ],
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    _goToLoginPage();
    return Future.value(true);
  }

  void _goToLoginPage() {
    Get.offAllNamed(Routes.login);
  }
}
*/
