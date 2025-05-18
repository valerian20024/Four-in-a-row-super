import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';

/*
  This widget is the reset slider. It is animated
  to get back to its position after sliding. 
*/

class ResetSliderAuto extends StatefulWidget {
  final Function onReset;

  const ResetSliderAuto({super.key, required this.onReset});

  @override
  ResetSliderAutoState createState() => ResetSliderAutoState();
}

class ResetSliderAutoState extends State<ResetSliderAuto>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.5; // Start in the center
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 300), // Needed for the animation to perform
    );

    _animationController.addListener(() {
      setState(() {
        _dragPosition = _animationController.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    const double minimumClamp = 0.25;
    const double maximumClamp = 0.75;
    setState(() {
      _dragPosition += details.primaryDelta! /
          MediaQuery.of(context).size.width; //todo stinky stuff
      _dragPosition = _dragPosition.clamp(
          minimumClamp, maximumClamp); // be sure it stays between 0.0 and 1.0

      // slider is at one of the edges
      if (_dragPosition <= minimumClamp || _dragPosition >= maximumClamp) {
        widget.onReset();
      }
    });
  }

  void _onDragEnd(DragEndDetails details) {
    // Animate back to center when drag ends
    _animationController.value =
        _dragPosition; // Start animation from the current position
    _animationController.animateTo(0.5); // Animate back to the center
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.transparent,
        height: 40,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: AppColors.transparent,
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 250, // width of the whole slider
                      height: 40.0, // height of the slider
                      child: Center(
                        child: Container(
                          // Background line
                          height: 4,
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.transparent,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Draggable Reset Button
              Positioned(
                left: MediaQuery.of(context).size.width * _dragPosition -
                    40, // Center button on drag position
                //left: 150,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(90),
                        border:
                            Border.all(color: AppColors.lightGrey, width: 2)),
                    child: const Center(
                      child: Text(
                        'Reset',
                        style: WhiteTextStyle.smallText,
                      ),
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
