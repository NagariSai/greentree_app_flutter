import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class SwitchCoachPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Switch Coach",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            CustomText(
              text: "Note",
              size: 12,
              fontWeight: FontWeight.w400,
              color: FF6D7274,
            ),
            const SizedBox(height: 8),
            CustomText(
              text:
                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
              size: 14,
              maxLines: 20,
              color: FF050707,
            ),
            const SizedBox(height: 16),
            CommonContainer(
              height: 144,
              borderRadius: 8,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: FFC4CACC,
                    width: 1,
                  ),
                  color: FFC4CACC,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomText(
                      text: "Reason",
                      size: 16,
                      color: FF050707,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 80,
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText:
                              'Write the reason why you want to switch...',
                          hintStyle: TextStyle(
                              color: FFBDC5C5,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: FontFamily.poppins,
                              decoration: TextDecoration.none)),
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              text: "Chosen coach",
              size: 12,
              fontWeight: FontWeight.w400,
              color: FF6D7274,
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.coachListUserPage);
              },
              child: CustomText(
                text: "Choose the coach with whom you want to switch",
                size: 14,
                color: FF55B5FE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
