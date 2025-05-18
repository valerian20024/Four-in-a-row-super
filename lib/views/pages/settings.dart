import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/button_style.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/bottombars.dart';
import 'package:four_in_a_row_super/views/widgets/buttons.dart';
import 'package:four_in_a_row_super/views/widgets/player_settings.dart';
import 'package:provider/provider.dart';

/*
  This page allows the user to changes some settings :
   - player 1 and player 2's name and colors
   - Which player will start the game
*/

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController gc = Provider.of<GameController>(context);

    return Scaffold(
      appBar: const SimpleAppBar(title: 'Settings'),
      backgroundColor: AppColors.lightBlue, // Background color
      bottomNavigationBar: const BackBottomBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Column(
                    children: [
                      PlayerSettings(playerID: 0),
                      PlayerSettings(playerID: 1),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Which player should start?',
                          style: HeadingTextStyle.smallHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Button(
                              f: () => gc.setCurrentPlayer(0),
                              text: 'P1',
                              style: GlobalButtonStyles.redSquareButton,
                              textStyle: HeadingTextStyle.mediumHeading,
                            ),
                            Button(
                              f: () => gc.setCurrentPlayer(1),
                              text: 'P2',
                              style: GlobalButtonStyles.redSquareButton,
                              textStyle: HeadingTextStyle.mediumHeading,
                            ),
                            Button(
                              f: () => gc.setRandomCurrentPlayer(),
                              text: 'RNG',
                              style: GlobalButtonStyles.yellowSquareButton,
                              textStyle: HeadingTextStyle.mediumHeading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
