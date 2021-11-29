import 'package:country_code_picker/country_code_picker.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/constant/strings.dart';
import 'package:fit_beat/app/features/auth/coach_register/controller/coach_register_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoachRegisterController>(builder: (_) {
      return Container(
        child: Column(
          children: [
            TextField(
              controller: _.mobileController,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: FF025074,
                  fontFamily: FontFamily.poppins),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: FFB0B8BB),
                  //  when the TextFormField in unfocused
                ),
                labelText: "Mobile Number",
                labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: FF6D7274,
                    fontFamily: FontFamily.poppins),
                prefixIcon: CountryCodePicker(
                  showDropDownButton: true,
                  padding: const EdgeInsets.only(left: 6),
                  onChanged: (c) => _.addCountryCode(c.dialCode),
                  initialSelection: 'IN',
                  showCountryOnly: false,
                  showFlagDialog: true,
                  showFlag: false,
                  countryList: Strings.codes,
                  favorite: [
                    '+46',
                  ],
                ),
              ),
              autocorrect: false,
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
