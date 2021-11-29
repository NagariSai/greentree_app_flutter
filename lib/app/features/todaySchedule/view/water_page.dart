import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/rounded_corner_button.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/model/water_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/water_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calender_view.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:time_range_picker/time_range_picker.dart';

class WaterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaterController>(
        init:
            WaterController(repository: ApiRepository(apiClient: ApiClient())),
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
                                  Divider(
                                    color: FFB0B8BB,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: CustomText(
                                      text: "Water Reminder",
                                      color: FF050707,
                                      fontWeight: FontWeight.w600,
                                      size: 16,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: CustomText(
                                      text: "Timings",
                                      color: FF6D7274,
                                      size: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      /*TimeRangePicker.show(
                                    context: context,
                                    onSubmitted: (TimeRangeValue value) {
                                      _.onTimePickerChange(value);
                                    },
                                  );*/
                                      TimeRange result =
                                          await showTimeRangePicker(
                                        context: context,
                                        start: _.reminderStartTime ??
                                            TimeOfDay(hour: 9, minute: 30),
                                        end: _.reminderEndTime ??
                                            TimeOfDay(hour: 17, minute: 30),
                                        onStartChange: (start) {
                                          print(
                                              "start time " + start.toString());
                                        },
                                        onEndChange: (end) {
                                          print("end time " + end.toString());
                                        },
                                        interval: Duration(minutes: 30),
                                        use24HourFormat: false,
                                        padding: 30,
                                        strokeWidth: 20,
                                        handlerRadius: 14,
                                        strokeColor:
                                            primaryColor.withOpacity(0.5),
                                        handlerColor: primaryColor,
                                        selectedColor:
                                            primaryColor.withOpacity(0.5),
                                        backgroundColor:
                                            Colors.black.withOpacity(0.3),
                                        ticks: 8,
                                        ticksColor: Colors.white,
                                        snap: true,
                                        labels: [
                                          "12 am",
                                          "3 am",
                                          "6 am",
                                          "9 am",
                                          "12 pm",
                                          "3 pm",
                                          "6 pm",
                                          "9 pm"
                                        ].asMap().entries.map((e) {
                                          return ClockLabel.fromIndex(
                                              idx: e.key,
                                              length: 8,
                                              text: e.value);
                                        }).toList(),
                                        labelOffset: -30,
                                        labelStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                        timeTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                        activeTimeTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      );
                                      _.onTimePickerChange(result);
                                      print("result " + result.toString());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: CustomText(
                                        text:
                                            "${_.displayReminderStartTime} - ${_.displayReminderEndTime}",
                                        color: FF050707,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(
                                    color: FFB0B8BB,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 4),
                                    child: CustomText(
                                      text: "Reminder",
                                      color: FF6D7274,
                                      size: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            value: 0,
                                            groupValue: _.waterReminderValue,
                                            activeColor: Colors.blue,
                                            onChanged: _.handleRadioValueChange,
                                          ),
                                          CustomText(
                                            text: "Never",
                                            color: FF050707,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 30,
                                            groupValue: _.waterReminderValue,
                                            activeColor: Colors.blue,
                                            onChanged: _.handleRadioValueChange,
                                          ),
                                          CustomText(
                                            text: "Every 30 min",
                                            color: FF050707,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 60,
                                            groupValue: _.waterReminderValue,
                                            activeColor: Colors.blue,
                                            onChanged: _.handleRadioValueChange,
                                          ),
                                          CustomText(
                                            text: "Every 60 min",
                                            color: FF050707,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 120,
                                            groupValue: _.waterReminderValue,
                                            activeColor: Colors.blue,
                                            onChanged: _.handleRadioValueChange,
                                          ),
                                          CustomText(
                                            text: "Every 2 hr",
                                            color: FF050707,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 180,
                                            groupValue: _.waterReminderValue,
                                            activeColor: Colors.blue,
                                            onChanged: _.handleRadioValueChange,
                                          ),
                                          CustomText(
                                            text: "Every 3 hr",
                                            color: FF050707,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 6,
                                            groupValue: _.waterReminderValue,
                                            activeColor: Colors.blue,
                                            onChanged: _.handleRadioValueChange,
                                          ),
                                          CustomText(
                                            text: "Every 4 hr",
                                            color: FF050707,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
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
