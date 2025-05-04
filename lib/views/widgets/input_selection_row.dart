import 'dart:math';
import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import 'package:four_in_a_row_super/views/styles/icons.dart';
import 'package:provider/provider.dart';

/*
  This widget is the row of arrows the user can use
  to place a checker. This specific class can be 
  a popout row or an checker input row.
*/

class HorizontalInputSelectionRow extends StatelessWidget {
  final bool popout;
  final bool up;
  const HorizontalInputSelectionRow({
    super.key,
    required this.popout,
    required this.up,
  });

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    ScenarioController sc = Provider.of<ScenarioController>(context);
    return SizedBox(
      width: 300, // Match grid width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(sc.getCurrentGridSize()[1], (index) {
          return GestureDetector(
            onTap: () {
              if (popout) {
                gc.popout(index);
              } else {
                String side = up ? 'up' : 'down';
                gc.placeSomething(side, index);
              }
            },
            child: popout
                ? AppIcons.popout
                : up
                    ? AppIcons.arrowDownward
                    : AppIcons.arrowUpward,
          );
        }),
      ),
    );
  }
}
 

/*
  This widget is the row of arrows the user can use
  to place a checker. This specific class can only be
  used for placing checkers. 
  
  left means : is the vertical row on the left of the screen?
  A left VerticalInputSelectionRow thus has an arrow pointing to the right
*/
class VerticalInputSelectionRow extends StatelessWidget {
  final bool left;
  const VerticalInputSelectionRow({
    super.key,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    ScenarioController sc = Provider.of<ScenarioController>(context);
    double height = 300.0;
    double spacing =
        height / max(sc.getCurrentGridSize()[0], sc.getCurrentGridSize()[1]) -
            AppIcons.arrowSize; // size of an arrow is 36
    return SizedBox(
      height: height, // Match grid height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(sc.getCurrentGridSize()[0], (index) {
          return GestureDetector(
            onTap: () {
              String side = left ? 'left' : 'right';
              gc.placeSomething(
                  side, index); // Use controller method to place piece
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: spacing),
              child: left ? AppIcons.arrowRightward : AppIcons.arrowLeftward,
            ),
          );
        }),
      ),
    );
  }
}
