import 'dart:math';
import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/controllers/player_controller.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:provider/provider.dart';

/*
  This widget is the popup animation triggered when a 
  player wings.
*/

class AnimatedWinningPopup extends StatefulWidget {
  const AnimatedWinningPopup({super.key});

  @override
  State<AnimatedWinningPopup> createState() => _AnimatedWinningPopupState();
}

class _AnimatedWinningPopupState extends State<AnimatedWinningPopup> {
  late double position;

  @override
  void initState() {
    super.initState();
    position = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
            curve: Curves.elasticOut,
            duration: const Duration(seconds: 2),
            top: gc.winningAnimationPosition,
            //width: 350,
            child: const WinningPopup()),
      ],
    );
  }
}

class WinningPopup extends StatelessWidget {
  static const List<String> victorySentenceList = [
    'Absolute Annihilation!',
    'Total Domination!',
    'Legendary Victory!',
    'Epic Triumph!',
    'Impressive Takedown!',
    'Monster Kill!',
    'Godlike Performance!',
    'Supreme Conqueror!',
    'Crushed the Competition!',
    'Decimated!',
    'You\'ve been terminated!',
    'A Clean Sweep!',
    '... all cleaned up!',
    'Victory in Style!',
    'You’ve Made History!',
    'Hero of the Day!',
    'Obliterated!',
    'Finish Him!',
  ];

  const WinningPopup({super.key});

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    PlayerController pc = Provider.of<PlayerController>(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        border: Border.all(
          color: AppColors.transparentBlack,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Game Over!',
              style: MainAppTextStyle.appSubTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: pc.getPlayerColor(gc.getWinner()),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      pc.getPlayerName(gc.getWinner()),
                      style: HeadingTextStyle.mediumHeading,
                    ),
                    const Text(
                      'wins!',
                      style: HeadingTextStyle.smallHeading,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        victorySentenceList[
                            Random().nextInt(victorySentenceList.length)],
                        style: HeadingTextStyle.smallHeading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
