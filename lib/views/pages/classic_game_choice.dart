import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/option_cards.dart';
import 'package:provider/provider.dart';
import '../styles/app_colors.dart';
import '../widgets/bottombars.dart';

// This page allows the user to choose what classic game
// it wants to play. E.g. 'classic', 'popout', ...
// This page will notify gamecontroller with the fact that we want
// to play 'classic' or 'popout' mode

class ClassicalGameChoiceView extends StatelessWidget {
  const ClassicalGameChoiceView({super.key});

  void _playClassicVersion(context, ScenarioController sc, GameController gc) {
    sc.loadClassicScenario();
    gc.setPointToScoreToOne();
    gc.resetGame();
    Navigator.pushNamed(context, '/number_players');
  }

  void _playPopoutVersion(context, ScenarioController sc, GameController gc) {
    sc.loadPopoutScenario();
    gc.setPointToScoreToOne();
    gc.resetGame();
    Navigator.pushNamed(context, '/number_players');
  }

  @override
  Widget build(BuildContext context) {
    final ScenarioController sc = Provider.of<ScenarioController>(context);
    final GameController gc = Provider.of<GameController>(context);

    return Scaffold(
      appBar: const DoubleAppBar(
        title: 'Play classic game',
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
                description: 'Play basic four-in-a-row.',
                title: 'Classic',
                color: AppColors.lightYellow,
                f: () => _playClassicVersion(context, sc, gc),
              ),
              const SizedBox(
                width: 20,
              ),
              OptionCard(
                width: 160,
                height: 400,
                description: 'Play the popout version.',
                title: 'PopOut',
                color: AppColors.lightRed,
                f: () => _playPopoutVersion(context, sc, gc),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
