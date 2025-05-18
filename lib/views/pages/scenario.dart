import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/controllers/rules_controller.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import 'package:four_in_a_row_super/views/widgets/bottombars.dart';
import 'package:four_in_a_row_super/views/widgets/buttons.dart';
import 'package:four_in_a_row_super/views/widgets/rule_checkbox_list_tile.dart';
import 'package:provider/provider.dart';
import '../styles/text_style.dart';
import '../styles/app_colors.dart';
import '../widgets/appbars.dart';
import '../widgets/scrollchoice.dart';

/* 
  This page allows the user to choose different rules to be applied during
  the next game. Talks to ScenarioController.
*/

class ScenarioView extends StatelessWidget {
  const ScenarioView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScenarioController sc = Provider.of<ScenarioController>(context);
    final GameController gc = Provider.of<GameController>(context);
    return Scaffold(
      backgroundColor: AppColors.lightBlue, // Background color
      appBar: const SimpleAppBar(
        title: 'Custom Game',
      ),
      bottomNavigationBar: const RulesBottomBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Choose your rules',
                        style: HeadingTextStyle.mediumHeading),
                    const SizedBox(height: 20),

                    const Divider(),
                    const Text('Winning',
                        style: HeadingTextStyle.mediumHeading),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getSuddenDeath(),
                      exclusive: true,
                    ),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getDefaultPointsScoring(),
                      exclusive: true,
                    ),

                    sc.isRuleActive(RulesController.getDefaultPointsScoring())
                        ? PointsScoringScrollChoiceManager(
                            scenarioController: sc,
                            gameController: gc,
                          )
                        : const Divider(),
                    const Text('Power-Ups',
                        style: HeadingTextStyle.mediumHeading),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getBombs(),
                      exclusive: false,
                    ),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getPlayTwice(),
                      exclusive: false,
                    ),

                    const Divider(), // horizontal line
                    const Text('Gravity',
                        style: HeadingTextStyle.mediumHeading),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getNormalGravity(),
                      exclusive: true,
                    ),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getPopoutGravity(),
                      exclusive: true,
                    ),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getOppositeGravity(),
                      exclusive: true,
                    ),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getOneSideBlockedGravity(),
                      exclusive: true,
                    ),

                    RuleCheckboxListTile(
                      scenarioController: sc,
                      rule: RulesController.getAllSidesGravity(),
                      exclusive: true,
                    ),

                    const Divider(),
                    const Text('Grid Size',
                        style: HeadingTextStyle.smallHeading),
                    const SizedBox(
                        height:
                            10), // space between Grid Size and selection squares
                    GridSizeScrollChoiceManager(
                      scenarioController: sc,
                      gameController: gc,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Divider(),
                    Center(
                        child: AcceptButton(
                      f: () => Navigator.pushNamed(context, '/game'),
                    ))
                  ],
                ),
              ),
            ),
          ),
          // Back Button
        ],
      ),
    );
  }
}
