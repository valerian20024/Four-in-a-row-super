import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/player_controller.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import 'package:four_in_a_row_super/models/rules/gravity_direction_rule.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/bottombars.dart';
import 'package:four_in_a_row_super/views/widgets/input_selection_row.dart';
import 'package:four_in_a_row_super/views/widgets/options_wheel.dart';
import 'package:four_in_a_row_super/views/widgets/popup.dart';
import 'package:four_in_a_row_super/views/widgets/round_display.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';

/*
  This page is the actual gameboard being drawned to the screen, 
  when playing a game.
*/

class GameBoardView extends StatelessWidget {
  const GameBoardView({super.key});

  bool _renderUpInput(GravityDirectionRule gravity) {
    if (gravity.isNormal() ||
        gravity.isPopout() ||
        gravity.isOppositeDirection() ||
        gravity.isOneSideBlocked() ||
        gravity.isAllDirections()) {
      return true;
    }
    return false;
  }

  bool _renderDownInput(GravityDirectionRule gravity) {
    if (gravity.isOppositeDirection() || gravity.isAllDirections()) {
      return true;
    }
    return false;
  }

  bool _renderDownPopout(GravityDirectionRule gravity) {
    if (gravity.isPopout()) {
      return true;
    }
    return false;
  }

  bool _renderLeftInput(GravityDirectionRule gravity) {
    if (gravity.isAllDirections() || gravity.isOneSideBlocked()) {
      return true;
    }
    return false;
  }

  bool _renderRightInput(GravityDirectionRule gravity) {
    return _renderLeftInput(gravity);
  }

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    final playerController = Provider.of<PlayerController>(context);
    final scenarioController = Provider.of<ScenarioController>(context);
    final GravityDirectionRule gravity = scenarioController.getGravityType();

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      bottomNavigationBar: scenarioController.whichBottomBar() == 0
          ? SimpleGameBottomBar(resetFunction: gameController.resetGame)
          : PowerUpGameBottomBar(resetFunction: gameController.resetGame),
      body: Stack(children: [
        SafeArea(
          child: Column(
            children: [
              scenarioController.whichUpperBar() == 0
                  ? const SimpleGameBoardUpperBar()
                  : const PointsGameBoardUpperBar(),
              const SizedBox(height: 10.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: RoundDisplay(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: OptionsWheel(),
                  ),
                ],
              ),
              //const SizedBox(height: 20.0),
              // Game Grid Area with Column Drop Indicators (Arrows)
              Expanded(
                child: IgnorePointer(
                  ignoring: gameController.isAImove,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ! InputSelectionRow
                      _renderUpInput(gravity)
                          ? const HorizontalInputSelectionRow(
                              popout: false, up: true)
                          : const SizedBox(height: 20.0),

                      // ! The game grid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _renderLeftInput(gravity)
                              ? const VerticalInputSelectionRow(left: true)
                              : const SizedBox(),
                          Container(
                            width: 300, // Fixed width for the grid
                            height: 300, // Fixed height for the grid
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue, // Grid background color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      scenarioController.getCurrentGridSize()[1],
                                ),
                                itemCount:
                                    scenarioController.getCurrentGridSize()[1] *
                                        scenarioController.getCurrentGridSize()[
                                            0], // 6 rows x 7 columns
                                itemBuilder: (context, index) {
                                  // Calculate the row and column
                                  int row = index ~/
                                      scenarioController.getCurrentGridSize()[1];
                                  int col = index %
                                      scenarioController.getCurrentGridSize()[1];
                                  int value = gameController.gameState.grid[row]
                                      [col]; // Get current grid state

                                  // Display different colors for players
                                  return Container(
                                    margin: const EdgeInsets.all(4.0),
                                    color: value == 0
                                        ? Colors.white // Empty
                                        : value == 1
                                            ? playerController
                                                .getPlayerColor(0) // Player 1
                                            : playerController
                                                .getPlayerColor(1), // Player 2
                                  );
                                },
                              ),
                            ),
                          ),
                          _renderRightInput(gravity)
                              ? const VerticalInputSelectionRow(left: false)
                              : const SizedBox(),
                        ],
                      ),

                      _renderDownInput(gravity)
                          ? const HorizontalInputSelectionRow(
                              popout: false,
                              up: false,
                            )
                          : _renderDownPopout(gravity)
                              ? const HorizontalInputSelectionRow(
                                  popout: true,
                                  up: false,
                                )
                              : const SizedBox(
                                  height: 20,
                                ),
                    ],
                  ),
                )
              ), // Increase space before the Reset button
            ],
          ),
        ),
        const AnimatedWinningPopup(),
      ]),
    );
  }
}
