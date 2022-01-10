import 'dart:math' as math;

import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/constant/assets.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleExpandableFab(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

@immutable
class ExampleExpandableFab extends StatelessWidget {
  static const _actionTitles = ['BREAKFAST', 'LUNCH', "SNACKS", 'DINNER'];
  const ExampleExpandableFab({Key key}) : super(key: key);

  void _showAction(BuildContext context, int index) {
      Get.back();
      print("showAction::" + index.toString());
     // ntController.selectUnselectCategoryType(index);
      Get.toNamed(Routes.selectFoodPage);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: bodybgColor,
      ),
      /*ListView.builder(

        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: 25,
        itemBuilder: (context, index) {
          return FakeItem(isBig: index.isOdd);
        },
      ),*/
      floatingActionButton: ExpandableFab(
        distance: 12.0,
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
    );
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
  bool _open = true;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {

        Get.back();
        _controller.forward();
      } else {
        Get.back();
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: appbgColor,
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
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
          index:i,

        ),
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
            child: const Icon(Icons.close),
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

    print("index:"+index.toString());
    print("top:"+top.toString());
    print("left:"+left.toString());
    print("right:"+right.toString());
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
           // right: 4.0 + offset.dx,
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
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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

