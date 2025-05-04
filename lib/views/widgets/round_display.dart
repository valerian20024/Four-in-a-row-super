import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:provider/provider.dart';

/*
  This widget is the box that contains the current round number
  when playing the game.
*/

class RoundDisplay extends StatelessWidget {
  const RoundDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparentWhite,
        border: Border.all(
          color: AppColors.darkBlue,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 55,
      width: 55,
      child: Center(
        child: Text(
          '${gc.getRoundNumber()}',
          style: HeadingTextStyle.mediumHeading,
        ),
      ),
    );
  }
}
