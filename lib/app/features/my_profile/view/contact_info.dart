import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/features/my_profile/controller/profile_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Container(
        color: bodybgColor,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: _.codeController,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: FF025074,
                        fontFamily: FontFamily.poppins),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: FFB0B8BB),
                          //  when the TextFormField in unfocused
                        ),
                        labelText: "Code",
                        labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: FF6D7274,
                            fontFamily: FontFamily.poppins)),
                    autocorrect: false,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: _.mobileController,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: FF025074,
                        fontFamily: FontFamily.poppins),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: FFB0B8BB),
                          //  when the TextFormField in unfocused
                        ),
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: FF6D7274,
                            fontFamily: FontFamily.poppins)),
                    autocorrect: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _.emailController,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: FF025074,
                  fontFamily: FontFamily.poppins),
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: FFB0B8BB),
                    //  when the TextFormField in unfocused
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: FF6D7274,
                      fontFamily: FontFamily.poppins)),
              autocorrect: false,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _.countryController,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: FF025074,
                  fontFamily: FontFamily.poppins),
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: FFB0B8BB),
                    //  when the TextFormField in unfocused
                  ),
                  labelText: "Country",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: FF6D7274,
                      fontFamily: FontFamily.poppins)),
              autocorrect: false,
            ),
          ],
        ),
      );
    });
  }
}
