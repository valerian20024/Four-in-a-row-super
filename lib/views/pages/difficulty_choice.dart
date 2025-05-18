import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/models/game/game_mode.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/button_style.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/bottombars.dart';
import 'package:four_in_a_row_super/views/widgets/buttons.dart';

class DifficultyChoiceView extends StatelessWidget {
  const DifficultyChoiceView({super.key});

  // Function to handle difficulty selection
  void _selectDifficulty(BuildContext context, GameModeDifficulty difficulty) {
    final gameController = Provider.of<GameController>(context, listen: false);
    gameController.setDifficulty(difficulty);

    // Now that both mode (already set to AI previously) and difficulty are known,
    // we can go straight to the game.
    Navigator.pushNamed(
      context,
      '/game',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DoubleAppBar(title: 'VS AI', subTitle: 'Choose difficulty'),
      backgroundColor: AppColors.lightBlue,
      bottomNavigationBar: const RulesBottomBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Easy Button
              Button(
                f: () => _selectDifficulty(context, GameModeDifficulty.easy),
                style: GlobalButtonStyles.easyButton,
                text: 'Easy',
                textStyle: ButtonsTextStyle.homepageButton,
              ),
              const SizedBox(height: 20),
              // Intermediate Button
              Button(
                f: () =>
                    _selectDifficulty(context, GameModeDifficulty.intermediate),
                style: GlobalButtonStyles.intermediateButton,
                text: 'Intermediate',
                textStyle: ButtonsTextStyle.homepageButton,
              ),
              const SizedBox(height: 20),
              // Hard Button
              Button(
                f: () => _selectDifficulty(context, GameModeDifficulty.hard),
                style: GlobalButtonStyles.hardButton,
                text: 'Hard',
                textStyle: ButtonsTextStyle.homepageButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
