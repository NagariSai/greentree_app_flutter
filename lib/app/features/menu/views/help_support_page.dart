import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/support.dart';
import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/features/main/controllers/main_controller.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportPage extends StatefulWidget {
  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  List<Support> supportList = [];
  Support selectedSupport;

  String desc = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Help & Support",
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Kindly Select the problem",
              color: FF050707,
              size: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: getInterestList(),
            ),
            SizedBox(
              height: 32,
            ),
            TextInputContainer(
              title: "",
              inputHint: "Write your issue here…",
              minLines: 5,
              maxLength: 160,
              maxLines: 7,
              onChange: (value) {
                desc = value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            RoundedCornerButton(
              height: 50,
              buttonText: "Submit",
              buttonColor: primaryColor,
              borderColor: primaryColor,
              fontSize: 14,
              radius: 6,
              isIconWidget: false,
              iconAndTextColor: FFFFFFFF,
              iconData: null,
              onPressed: () => Get.find<MainController>()
                  .submitHelpSupport(selectedSupport, desc),
            ),
            SizedBox(
              height: 90,
            ),
            CustomText(
              text: "Mail Us",
              color: FF050707,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: "Drop us a mail we will answer your queries",
              color: FF6D7274,
              size: 14,
            ),
            SizedBox(
              height: 27,
            ),
            Row(
              children: [
                Icon(
                  Icons.mail_outline,
                  color: FF55B5FE,
                  size: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "fitbeat@helpdesk.com",
                  color: FF6D7274,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getInterestList() {
    List<Widget> interestWidgetList = [];
    for (Support interest in supportList) {
      interestWidgetList.add(InkWell(
        onTap: () {
          setState(() {
            if (isSelected(interest)) {
              selectedSupport = null;
            } else {
              selectedSupport = interest;
            }
          });
        },
        child: CommonContainer(
            height: 31,
            width: Utils.getLength(interest.title, 14, FontFamily.poppins) + 40,
            borderRadius: 24,
            backgroundColor:
                isSelected(interest) ? FFB2C8D2 : Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: FFB2C8D2,
                  width: 1,
                ),
                color: isSelected(interest) ? FFB2C8D2 : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
              child: CustomText(
                text: interest.title,
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black,
              ),
            )),
      ));
    }
    return interestWidgetList;
  }

  @override
  void initState() {
    super.initState();
    supportList.add(
      Support(id: 1, title: "Request new feature"),
    );
    supportList.add(
      Support(id: 2, title: "Report user"),
    );
    supportList.add(
      Support(id: 3, title: "Problem with the app"),
    );
    supportList.add(
      Support(id: 4, title: "Coach refund"),
    );
    supportList.add(
      Support(id: 5, title: "Coach enrollment"),
    );
    supportList.add(
      Support(id: 6, title: "Other"),
    );
  }

  bool isSelected(Support interest) {
    if (selectedSupport != null && selectedSupport.id == interest.id) {
      return true;
    }
    return false;
  }
}
