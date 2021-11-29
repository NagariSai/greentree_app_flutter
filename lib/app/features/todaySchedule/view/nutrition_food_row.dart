import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/food_bottom_view.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionFoodRow extends StatelessWidget {
  final bool isSelf;

  NutritionData asNutritions;
  var userScheduleId;
  var userScheduleActivityId;
  var isDone;

  var _ = Get.find<NutritionController>();

  var index;

  NutritionFoodRow(
      {Key key,
      this.isSelf = true,
      this.asNutritions,
      this.userScheduleId,
      this.isDone,
      this.index,
      this.userScheduleActivityId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _.isEaten = isDone == 0 ? false : true;

    return InkWell(
      onTap: () {
        Get.bottomSheet(FoodBottomView(
            nutrition: asNutritions, isFromTodaySchdule: true, index: index));
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 86,
                    width: 80,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${asNutritions.nutritionMedia[0].mediaUrl ?? ""}",
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        Assets.backgroundBanner,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),*/
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "${asNutritions.title ?? ""}",
                          size: 16,
                          color: FF050707,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text:
                                  "${asNutritions.quantity ?? " "}${Utils().getQuatityType(asNutritions.quantityType)}  |  ",
                              size: 13,
                              color: FF6D7274,
                            ),
                            CustomText(
                              text: "${asNutritions.kcal ?? ""}kcal",
                              size: 13,
                              color: FF55B5FE,
                            ),
                            CustomText(
                              text: "  |  ",
                              size: 13,
                              color: FF6D7274,
                            ),
                            CustomText(
                              text: isSelf ? "By me" : "",
                              size: 13,
                              color: isSelf ? FFD890D5 : FF6BD295,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Theme(
                                data:
                                    ThemeData(unselectedWidgetColor: FF6BD295),
                                child: Checkbox(
                                  value: _.isEaten,
                                  onChanged: (value) {
                                    _.onChangeOnEaten(
                                        value, userScheduleActivityId);
                                  },
                                  activeColor: FF6BD295,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            CustomText(
                              text: "Eaten",
                              size: 12,
                              color: FF050707,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (isSelf) ...[
                  InkWell(
                    onTap: () async {
                      var result = await DialogUtils.customDialog(
                          title: "Delete",
                          description:
                              "Are you sure you want to Delete this food nutrition? ",
                          firstButtonTitle: "Yes, Delete",
                          secondButtonTitle: "Cancel");

                      if (result) {
                        _.deleteNutritionInScheduleActivity(
                            userScheduleId, userScheduleActivityId);
                      }
                    },
                    child: Icon(
                      Icons.remove_circle,
                      color: FFD890D5,
                      size: 24,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
