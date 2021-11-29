import 'package:fit_beat/app/common_widgets/custom_submit_buttom.dart';
import 'package:fit_beat/app/common_widgets/dots_indicator.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/features/intro/views/intro_widget1.dart';
import 'package:fit_beat/app/features/intro/views/intro_widget2.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _controller = new PageController(viewportFraction: 1);

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    IntroWidget1(),
    IntroWidget2(
        imagePath: Assets.intro1,
        title: "Activity",
        subTitle:
            "In publishing and graphic design, Lorem ipsum is a placeholder text"),
    IntroWidget2(
        imagePath: Assets.intro2,
        title: "Meal",
        subTitle:
            "In publishing and graphic design, Lorem ipsum is a placeholder text"),
    IntroWidget2(
        imagePath: Assets.intro3,
        title: "Nutrition Intake",
        subTitle:
            "In publishing and graphic design, Lorem ipsum is a placeholder text"),
    IntroWidget2(
        imagePath: Assets.intro4,
        title: "Workout",
        subTitle:
            "In publishing and graphic design, Lorem ipsum is a placeholder text"),
    IntroWidget2(
        imagePath: Assets.intro5,
        title: "Online Coach",
        subTitle:
            "In publishing and graphic design, Lorem ipsum is a placeholder text"),
    IntroWidget2(
        imagePath: Assets.intro6,
        title: "Training at your own Place",
        subTitle:
            "In publishing and graphic design, Lorem ipsum is a placeholder text"),
  ];

  Widget _buildPageItem(BuildContext context, int index) {
    return Page(page: _pages[index], idx: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPageItem(context, index % _pages.length);
              },
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(20.0),
            child: new Center(
              child: DotsIndicator(
                controller: _controller,
                itemCount: _pages.length,
                onPageSelected: (int page) {
                  _controller.animateToPage(
                    page,
                    duration: _kDuration,
                    curve: _kCurve,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomSubmitButton(
            text: "Let's Start!",
            color: Colors.white,
            textColor: titleBlackColor,
            onTap: () => Get.toNamed(Routes.login),
          ),
          SizedBox(
            height: 42,
          ),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final page;
  final idx;

  Page({
    @required this.page,
    @required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 400.0, child: this.page),
        ],
      ),
    );
  }
}
