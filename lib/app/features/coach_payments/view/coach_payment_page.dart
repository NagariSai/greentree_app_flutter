import 'package:fit_beat/app/common_widgets/circular_image.dart';
import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_calendar/table_calendar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:fit_beat/app/common_widgets/fl_chart/src/chart/base/base_chart/base_chart_data.dart';
import 'package:fit_beat/app/common_widgets/fl_chart/src/chart/line_chart/line_chart.dart';
import 'package:fit_beat/app/common_widgets/fl_chart/src/chart/line_chart/line_chart_data.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calender_view.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../coach_payment_controller.dart';

class CoachPaymentPage extends StatelessWidget {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Payments",
      ),
      body: GetBuilder<CoachPaymentController>(
          init: CoachPaymentController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _.isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: NormalTextField(
                            controller: _.searchController,
                            bgColor: settingBgColor,
                            showPrefixIcon: true,
                            hintColor: descriptionColor,
                            hintText: "Search My People..",
                            isEndIconImage: true,
                            endIconImage: Assets.ic_filter,
                            showIcon: true,
                            onIconTap: () {
                              Utils.dismissKeyboard();
                              // Get.toNamed(Routes.coachFilterUserPage);
                            },
                            onChanged: (String text) {},
                          ),
                        ),
                        CustomCalenderView(
                          calendarFormat: CalendarFormat.month,
                          hideContent: true,
                          selectedDate: (selectedDate) {
                            _.setCalenderDate(selectedDate);
                          },
                        ),
                        if (_.isDateChange)
                          Container(
                              height: 500,
                              child: Center(child: CircularProgressIndicator()))
                        else
                          Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                    backgroundColor: FFF2C86B,
                                    radius: 20,
                                    child: Center(
                                      child: Image.asset(
                                        Assets.fitCoinIcon,
                                        color: Colors.white,
                                        width: 20,
                                        height: 20,
                                      ),
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                                CustomText(
                                  text: "${_.totalAmount} Kr",
                                  size: 26,
                                  color: FF6BD295,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: CustomText(
                                    text: "Total Payment",
                                    color: titleBlackColor,
                                    size: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                AspectRatio(
                                  aspectRatio: 1.70,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                        color: Color(0xff232d37)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 18.0,
                                          left: 12.0,
                                          top: 24,
                                          bottom: 12),
                                      child: LineChart(
                                        mainData(_),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.all(16),
                                    itemCount: _.userList.length,
                                    itemBuilder: (context, position) {
                                      var data = _.userList[position];
                                      return Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: catBlueColor
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 6,
                                                    offset: Offset(0,
                                                        0), // changes position of shadow
                                                  ),
                                                ]),
                                            child: CircularImage(
                                              width: 46,
                                              height: 46,
                                              imageUrl: data.profileUrl ?? "",
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text: data.fullName ??
                                                            "NA",
                                                        size: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: titleBlackColor,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            "${Utils.convertDateIntoFormattedString(data.validUptoDatetime)}",
                                                        size: 13,
                                                        color: descriptionColor,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                          text:
                                                              data.packageTitle,
                                                          size: 11,
                                                          color:
                                                              descriptionColor,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                      Spacer(),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            "${data.packagePrice.toString()} Kr",
                                                        size: 14,
                                                        color: FF6BD295,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        maxLines: 1,
                                                      )
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, position) {
                                      return Divider(
                                        color: otherDividerColor,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  );
          }),
    );
  }

  LineChartData mainData(CoachPaymentController coachPaymentController) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                /*if (flSpot.x == 0 || flSpot.x == 6) {
                  return null;
                }*/

                return LineTooltipItem(
                  '${(flSpot.y * 30).toPrecision(1)} K',
                  const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            print(value);

            switch (value.toInt()) {
              case 0:
                return '1w';
              case 1:
                return '2w';
              case 2:
                return '3w';

              case 3:
                return '4w';
              case 4:
                return '5w';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '30k';
              case 2:
                return '60k';
              case 3:
                return '90k';

              case 4:
                return '120k';
              case 5:
                return '150k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: coachPaymentController.paymentGraph.length.toDouble(),
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: coachPaymentController.paymentSpot,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
