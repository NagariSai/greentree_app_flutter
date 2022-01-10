import 'dart:math';

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/constant/font_family.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/nutrition_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calender_view.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/dialog_utils.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:math' as math;

import 'expandablefab.dart';

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  NutritionController ntController;
  @override
  void initState() {
    ntController = new NutritionController(
        repository: ApiRepository(apiClient: ApiClient()));
    super.initState();
  }

  String finalDate = Utils.getCurrentDate();

  bool viewVisible = false;
  static const _actionTitles = ['BREAKFAST', 'LUNCH', "SNACKS", 'DINNER'];


  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  void _showAction(BuildContext context, int index) {
    print("showAction::" + Utils.fabopen.toString());

    if(Utils.fabopen) {
      print("showAction::" + index.toString());
      ntController.selectUnselectCategoryType(index);
      Get.toNamed(Routes.selectFoodPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionController>(
        //init: NutritionController(repository: ApiRepository(apiClient: ApiClient())),
        init: ntController,
        builder: (_) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: bodybgColor,
                child: Column(children: [
                  Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: viewVisible,
                    child: CustomCalenderView(
                      isNutritionPage: true,
                      selectedDate: (selectedDate) {
                        _.setCalenderDate(selectedDate);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              if (viewVisible)
                                hideWidget();
                              else
                                showWidget();
                            },
                            child: Text(finalDate, //title
                                textAlign: TextAlign.center,
                                style: TextStyle(color: customTextColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _.isLoading
                      ? Container(
                          height: Get.height * 0.2,
                          child: Center(child: CircularProgressIndicator()))
                      : Column(
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: double.infinity,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: Color.fromRGBO(242, 244, 255, 1),
                                      color: Colors.white,
                                    ),
                                  ),
                                  CircularPercentIndicator(
                                    backgroundColor:
                                        Color.fromRGBO(242, 244, 255, 1),
                                    radius: 140.0,
                                    lineWidth: 4.0,
                                    percent: _.getNutritionPercentage(),
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: "${_.kCalIntake}",
                                          color: FF050707,
                                          size: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        CustomText(
                                          text: "of",
                                          color: FF6D7274,
                                          size: 11,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        CustomText(
                                          text: "${_.kCal} Kcal",
                                          color: FF050707,
                                          size: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                    progressColor:
                                        _.isCalExceed ? FFFF9B91 : FF6BD295,
                                  ),
                                  Positioned.fill(
                                    top: -15,
                                    right: -5,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                        onPressed: () async {
                                          String result =
                                              await DialogUtils.setKCalDialog();
                                          if (result != null && result != "") {
                                            setState(() {
                                              _.kCal = int.parse(result);
                                              _.updateKcal();
                                            });
                                          }
                                        },
                                        child: CustomText(
                                          text: "Set Kcal Limit",
                                          size: 13,
                                          color: customTextColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    CustomText(
                                      text: "PROTEIN",
                                      size: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: new LinearPercentIndicator(
                                        // width: MediaQuery.of(context).size.width - 50,
                                        width: 70,
                                        animation: true,
                                        lineHeight: 3.0,
                                        animationDuration: 1500,
                                        percent: _.totalProteins,
                                        center: Text(""),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            _.totalProteins.toStringAsFixed(1),
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.poppins),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: " g",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomText(
                                      text: "CARBS",
                                      size: 14,
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: new LinearPercentIndicator(
                                        // width: MediaQuery.of(context).size.width - 50,
                                        width: 60,
                                        animation: true,
                                        lineHeight: 3.0,
                                        animationDuration: 1500,
                                        percent: _.totalCarbs,
                                        center: Text(""),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.orangeAccent,
                                      ),
                                    ),
                                    /*   Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orangeAccent.withOpacity(0.8)),
                                  ),*/
                                    SizedBox(
                                      height: 3,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: _.totalCarbs.toStringAsFixed(1),
                                        style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.poppins),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: " g",
                                            style: TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomText(
                                      text: "FAT",
                                      size: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: new LinearPercentIndicator(
                                        // width: MediaQuery.of(context).size.width - 50,
                                        width: 50,
                                        animation: true,
                                        lineHeight: 3.0,
                                        animationDuration: 1500,
                                        percent: _.totalFats,
                                        center: Text(""),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: _.totalFats.toStringAsFixed(1),
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.poppins),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: " g",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            for (var i = 0; i < _.asNutritions.length; i++)
                              buildRow(
                                  _.asNutritions,
                                  _.asNutritions[i].masterCategoryTypeId,
                                  _.asNutritions[i].title,
                                  _.nutritions,
                                  _.kCal,
                                  i),
                            Container(
                              height: Get.height * 0.08,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: CustomText(
                                    text:
                                        "You have to enroll with the coach to manage nutrition schedule by coach.",
                                    color: FF6D7274,
                                    size: 14,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                ]),
              ),
            ),

            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: appbgColor,
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExampleExpandableFab()),
                  );
                });
              },
            ),
/*
            floatingActionButton: ExpandableFab(
              distance: 100.0,
              children: [
                ActionButton(
                    onPressed: () => _showAction(context, 0),
                    icon: Image.asset(
                      Assets.breakfastIcon,
                      height: 50,
                      width: 50,
                    ),
                    text: _actionTitles[0]),
                ActionButton(
                    onPressed: () => _showAction(context, 2),
                    icon: Image.asset(
                      Assets.lunchIcon,
                      height: 50,
                      width: 50,
                    ),
                    text: _actionTitles[1]),
                ActionButton(
                    onPressed: () => _showAction(context, 1),
                    icon: Image.asset(
                      Assets.snacksIcon,
                      height: 50,
                      width: 50,
                    ),
                    text: _actionTitles[2]),
                ActionButton(
                    onPressed: () => _showAction(context, 4),
                    icon: Image.asset(
                      Assets.dinnerIcon,
                      height: 50,
                      width: 50,
                    ),
                    text: _actionTitles[3]),
              ],
            ),
*/

          );
        });
  }




  buildRow(List<AsNutrition> asNutritions, letter, name,
      List<Nutrition> nutritions, kCal, index) {
    return new Card(
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (name.endsWith("Breakfast"))
                  InkWell(
                    child: Image.asset(
                      Assets.breakfastIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                if (name.endsWith("Lunch"))
                  InkWell(
                    child: Image.asset(
                      Assets.lunchIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                if (name.endsWith("Snack 1") ||
                    name.endsWith("Snack 2") ||
                    name.endsWith("Snack 3"))
                  InkWell(
                    child: Image.asset(
                      Assets.snacksIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                if (name.endsWith("Dinner"))
                  InkWell(
                    child: Image.asset(
                      Assets.dinnerIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                Container(height: 50, child: VerticalDivider(color: FF6D7274)),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            child: getRowItems(
                                asNutritions, name, nutritions, letter),
                            onTap: () {
                              setState(() {});
                              ntController.selectUnselectCategoryType(index);
                              List<Nutrition> ntlist =
                                  asNutritions[index].nutritions;

                              int count = 0;
                              for (var i = 0; i < ntlist.length; i++) {
                                if (ntlist[i]
                                        .nutritionData
                                        .masterCategoryTypeId ==
                                    letter) {
                                  count++;
                                }
                              }

                              print("count::"+count.toString());
                              if (kCal > 0) {
                                if (count == 0)
                                  Get.toNamed(Routes.selectFoodPage);
                                else {
                                  Get.toNamed(Routes.selectFoodSchedulePage);

                                }
                              } else {
                                Utils.showErrorSnackBar(
                                    "Please set Kcal limit first.");
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                    onTap: () async {
                      ntController.selectUnselectCategoryType(index);
                      // selectUnselectCategoryType(index);
                     // Get.toNamed(Routes.addFoodNutritionPage);
                      if (kCal > 0) {
                        Get.toNamed(Routes.addFoodNutritionPage);
                      } else {
                        Utils.showErrorSnackBar("Please set Kcal limit first.");
                      }
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      color: FF6BD295,
                    )),
              ],
            ),
          ),
        ]));
  }

  Widget getRowItems(List<AsNutrition> asNutritions, String name,
      List<Nutrition> strings, int title) {
    List<Widget> list = [];
    print("getRowItems::"+asNutritions.length.toString());

    String items = "";
    try {
      for (var n = 0; n < asNutritions.length; n++) {
        List<Nutrition> ntlist = asNutritions[n].nutritions;
        for (var i = 0; i < ntlist.length; i++) {
          if (ntlist[i].nutritionData.masterCategoryTypeId == title) {
            items = items + ntlist[i].nutritionData.title + ",";
            if (items.length > 20) items = items.substring(0, 20);
            list.add(new Text(items));
          }
        }
      }

      if (items.endsWith(",")) {
        items = items.substring(0, items.lastIndexOf(","));
      }

      items = items;
    } catch (e) {}
    if (items.length > 0) {
      return new Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 4),
          child: CustomText(
            text: "$name",
            size: 16,
            color: FF050707,
            maxLines: 2,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 4, right: 0, bottom: 0, top: 0),
          child: Text(
            items,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ]);
    } else
      return new Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 4),
          child: CustomText(
            text: "$name",
            size: 16,
            color: FF050707,
            maxLines: 2,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]);
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key key,
    this.initialOpen,
    this.distance,
    this.children,
  }) : super(key: key);

  final bool initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;

    print("open:" + _open.toString());

    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds:250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    print("toggle" + _open.toString());
    setState(() {
      _open = !_open;
      if (_open) {
        Utils.fabopen=true;
        _controller.forward();
      } else {
        Utils.fabopen=false;
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_open)
      return Container(
        //  color: (_open?bodybgColor:transparent),
        color: bodybgColor,
        child: SizedBox.expand(
          child: Stack(
            alignment: Alignment.bottomRight,
            clipBehavior: Clip.none,
            children: [
              _buildTapToCloseFab(),
              ..._buildExpandingActionButtons(),
              _buildTapToOpenFab(),
            ],
          ),
        ),
      );
    else
      return SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            _buildTapToCloseFab(),
            ..._buildExpandingActionButtons(),
            _buildTapToOpenFab(),
          ],
        ),
      );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 65.0,
      height: 65.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          color: appbgColor,
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: bodybgColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        Container(
            child: _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
              index:i,
        )),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.add),
            backgroundColor: appbgColor,
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key key,
    this.directionInDegrees,
    this.maxDistance,
    this.progress,
    this.child,
    this.index,

  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {

    double top=10.0;
    double left=10.0;
    double right=10.0;
    double bottom=10.0;

    if(index==0) {
      top = 220.0;
      left = 20.0;
      right = 0.0;
    }
    else  if(index==1) {
      top = 300.0;
      left = -130.0;
      right = 0.0;
    }
   else if(index==2) {
      top = 300.0;
      left = 170.0;
      right = 0.0;
    }
   else if(index==3) {
      top = 360.0;
      left = 20.0;
      right = 0.0;
    }
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );

        return Positioned(
         top: top,
         left:left,
         right:right,
        //  right: 4.0 + offset.dx,
        //  bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({Key key, this.onPressed, this.icon, this.text})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap:  onPressed,
      child: Container(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              elevation: 4.0,

              shadowColor: appbgColor,
              child: IconTheme.merge(
                data: theme.accentIconTheme,
                child: IconButton(alignment: Alignment.center,
                  onPressed: onPressed,
                  icon: icon,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: "${text}",
              size: 15,
              color: appbgColor,
              maxLines: 1,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w800,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    Key key,
    this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
