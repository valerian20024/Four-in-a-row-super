import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/bottombars.dart';
import 'package:four_in_a_row_super/views/widgets/option_cards.dart';
import 'package:four_in_a_row_super/models/game/game_mode.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:provider/provider.dart';

/*
  This page allows the user to choose how many players are 
  going to play the game.
  Can be 1 (hence play vs AI), 2 (two physical players on the same device),
  2 (online play - will certainly not be able to be implemented)
*/

class NumberOfPlayersView extends StatelessWidget {
  const NumberOfPlayersView({
    super.key,
  });

  void _triggerOnePlayer(context) {
    // Set the game mode to AI when one player is chosen
    final gameController = Provider.of<GameController>(context, listen: false);
    gameController.setGameMode(GameMode.ai);

    Navigator.pushNamed(context, '/difficulty');
  }

  void _triggerTwoPlayersLocal(context) {
    final gameController = Provider.of<GameController>(context, listen: false);
    gameController.setGameMode(GameMode.local);

    Navigator.pushNamed(
      context,
      '/game',
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DoubleAppBar(
        title: 'Play',
        subTitle: 'How many players?',
      ),
      backgroundColor: AppColors.lightBlue,
      bottomNavigationBar: const RulesBottomBar(),
      body: SafeArea(
          child: GridView.count(
        mainAxisSpacing: 100,
        padding: const EdgeInsets.only(top: 80),
        crossAxisCount: 2,
        children: [
          // todo find a way to get rid of the box overflow. See optionsCard
          OptionCard(
              width: 160,
              height: 800,
              description: 'You will play against an AI.',
              title: 'One',
              color: AppColors.lightYellow,
              f: () => _triggerOnePlayer(
                    context,
                  )),
          OptionCard(
            width: 160,
            height: 800,
            description: 'You will play on the same device.',
            title: 'Two (Local)',
            color: AppColors.lightRed,
            f: () => _triggerTwoPlayersLocal(context),
          ),
        ],
      )),
    );
  }
}
