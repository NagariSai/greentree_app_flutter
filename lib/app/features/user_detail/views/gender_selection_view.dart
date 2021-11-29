import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/features/user_detail/controllers/user_detail_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GenderSelectionView extends StatelessWidget {
  var _ = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "Which one are you?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: Text(
                  "To give you customize experience, we need to know your gender.",
                  style: TextStyle(color: descriptionColor, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 31),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 30,
                  runSpacing: 30,
                  children: [
                    Obx(
                      () => CommonContainer(
                        onTap: () {
                          _.changeGenderValue(1);
                        },
                        height: 142,
                        width: 110,
                        borderRadius: 12,
                        backgroundColor: _.selectedGender == 1
                            ? selectionMaleColor
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipOval(
                                child: Container(
                                  color: primaryColor,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/ic_male.svg",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Male",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => CommonContainer(
                        onTap: () {
                          _.changeGenderValue(2);
                        },
                        height: 142,
                        width: 110,
                        borderRadius: 12,
                        backgroundColor: _.selectedGender == 2
                            ? selectionFemaleColor
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipOval(
                                child: Container(
                                  color: primaryColor,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/ic_female.svg",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => CommonContainer(
                        onTap: () {
                          _.changeGenderValue(3);
                        },
                        height: 142,
                        width: 110,
                        borderRadius: 12,
                        backgroundColor: _.selectedGender == 3
                            ? selectionOtherColor
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipOval(
                                child: Container(
                                  color: primaryColor,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/ic_transgender.svg",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Other",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (_.selectedGender != null) _.gotoDobSelectionPage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 42),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        color: _.selectedGender != null
                            ? primaryColor
                            : Colors.grey,
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _.updateUserData();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "I will do this later",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
