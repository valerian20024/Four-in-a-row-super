import 'dart:math';
import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';

/*
  This widget represents the animation of checkers falling
  in the hompage screen.
*/

class FallingCheckerAnimation extends StatefulWidget {
  late final double horizontalValue;
  late final double startOffset;
  late final Duration animationDuration;
  late final List<Color> checkerColors;

  FallingCheckerAnimation({
    super.key,
  }) {
    horizontalValue = Random().nextDouble() * 7 - 1;
    startOffset = Random().nextDouble() * (-60);
    animationDuration = Duration(seconds: Random().nextInt(30) + 20);
    checkerColors = Random().nextBool()
        ? [AppColors.lightYellow, AppColors.darkYellow]
        : [AppColors.lightRed, AppColors.darkRed];
  }

  @override
  State<FallingCheckerAnimation> createState() =>
      _SlideTransitionExampleState();
}

class _SlideTransitionExampleState extends State<FallingCheckerAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.animationDuration,
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(widget.horizontalValue, widget.startOffset),
    end: Offset(widget.horizontalValue, 20.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  late final checkerDiameter = 60.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: checkerDiameter,
          height: checkerDiameter,
          decoration: BoxDecoration(
            color: widget.checkerColors[0],
            border: Border.all(
              color: widget.checkerColors[1],
              width: 5.0,
            ),
            borderRadius: BorderRadius.circular(checkerDiameter / 2),
          ),
          child: const Center(
              child: Text('super', style: MainAppTextStyle.fallingCheckers)),
        ),
      ),
    );
  }
}
