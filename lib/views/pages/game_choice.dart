import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/models/game/game_mode.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/option_cards.dart';
import 'package:provider/provider.dart';
import '../styles/app_colors.dart';
import '../widgets/bottombars.dart';

/*
This page allows the user to chose from two categories of games :
 - classic
 - custom
 Then the user will refine its choice by specifying which particular game 
 he wants to play. This page is only an intermediary and shall not talk
 to controllers
*/

class PlayHomeView extends StatelessWidget {
  const PlayHomeView({super.key});

  void _playClassicGame(context) {
    Navigator.pushNamed(context, '/classic_game_choice');
  }

  void _playCustomGame(context) {
    final gameController = Provider.of<GameController>(context, listen: false);
    gameController.setGameMode(GameMode.local);
    Navigator.pushNamed(context, '/scenario');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DoubleAppBar(
        title: 'Play',
        subTitle: 'Choose a style',
      ),
      backgroundColor: AppColors.lightBlue, // Background color
      bottomNavigationBar: const RulesBottomBar(),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OptionCard(
                width: 160,
                height: 400,
                description:
                    'Play classic four-in-a-row. This mode includes standard variants of the game such as pop out.',
                title: 'Base',
                color: AppColors.lightYellow,
                f: () => _playClassicGame(context),
              ),
              const SizedBox(
                width: 20,
              ),
              OptionCard(
                width: 160,
                height: 400,
                description:
                    'Add new rules to the game, mix them together to create unheard-of games.',
                title: 'Custom',
                color: AppColors.lightRed,
                f: () => _playCustomGame(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
