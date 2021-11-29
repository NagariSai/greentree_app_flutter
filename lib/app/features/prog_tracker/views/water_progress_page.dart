import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/water_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/prog_tracker/controllers/water_progress_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calender_view.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class WaterProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaterProgressController>(
        init: WaterProgressController(
            repository: ApiRepository(apiClient: ApiClient())),
        builder: (_) {
          return _.isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCalenderView(
                              selectedDate: (selectedDate) {
                                _.setCalenderDate(selectedDate);
                              },
                            ),
                            Divider(
                              thickness: 4,
                              color: dividerColor,
                            ),
                            const SizedBox(height: 16),
                            if (_.isDateChange)
                              Container(
                                  height: 500,
                                  child: Center(
                                      child: CircularProgressIndicator()))
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: CustomText(
                                      text: "Body Weight",
                                      color: FF050707,
                                      fontWeight: FontWeight.w600,
                                      size: 16,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: TextField(
                                      controller: _.weightController,
                                      style: TextStyle(),
                                      decoration: InputDecoration(
                                        hintText: "Weight in kg",
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: CustomText(
                                      text: "Water",
                                      color: FF050707,
                                      fontWeight: FontWeight.w600,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    height: 75,
                                    child: ListView.builder(
                                        itemCount: _.waterLevelList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          WaterModel water =
                                              _.waterLevelList[index];
                                          return InkWell(
                                            onTap: () {
                                              _.selectWaterLevel(
                                                  water.id, true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: index == 0 ? 16 : 0,
                                                  right: 22),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    water.isEmptyWater
                                                        ? Assets.empty_water
                                                        : Assets.fill_water,
                                                    height: 40,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  CustomText(
                                                    text: "${water.title}",
                                                    color: FF050707,
                                                    size: 12,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 60)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RoundedCornerButton(
                            height: 50,
                            width: Get.width - 32,
                            buttonText: "Save",
                            buttonColor: FF025074,
                            borderColor: FF025074,
                            fontSize: 14,
                            radius: 12,
                            isIconWidget: false,
                            iconAndTextColor: Colors.white,
                            iconData: null,
                            onPressed: () {
                              _.updateScheduleActivityForWater();
                            },
                          ),
                        ))
                  ],
                );
        });
  }
}
