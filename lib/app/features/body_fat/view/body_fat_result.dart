import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/user_detail/common_widgets/common_container.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyFatResultPage extends StatelessWidget {
  double bodyFatResult;
  BodyFatResultPage({this.bodyFatResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 429,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 71),
          CustomText(
            text: "Body Fat",
            size: 18,
            color: FF050707,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 46),
          CommonContainer(
              height: 50,
              width: 50,
              borderRadius: 50,
              backgroundColor: FFD890D5,
              child: Center(
                  child: Image.asset(
                Assets.fatIcon,
                height: 23,
                width: 20,
              ))),
          const SizedBox(height: 12),
          CustomText(
            text: "${bodyFatResult.toStringAsFixed(2)} %",
            size: 36,
            color: FF050707,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 67),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: CommonContainer(
                height: 36,
                width: 66,
                borderRadius: 20,
                backgroundColor: FFCCE9F7,
                child: Center(
                    child: CustomText(
                  text: "Ok",
                  size: 14,
                  color: FF025074,
                  fontWeight: FontWeight.w500,
                ))),
          ),
        ],
      ),
    );
  }
}
