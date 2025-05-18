import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import '../styles/text_style.dart';
import '../styles/app_colors.dart';

/*
  These widgets are arranged hierarchically. They permit to choose from
  a variety of options by scrolling horizontally a set of small containers.
  One of these can be (and will always be) chosen to reprensent the choice
  of the user. Talks to scenarioController. These widgets can be found in the
  scenarioView page.
*/

abstract class ScrollChoiceManager extends StatefulWidget {
  final int gridOptionsCount;
  final ScenarioController scenarioController;
  final GameController gameController;

  const ScrollChoiceManager({
    super.key,
    required this.gridOptionsCount,
    required this.scenarioController,
    required this.gameController,
  });
}

/*
  The scroll choice manager for the grid size logic.
*/

class GridSizeScrollChoiceManager extends ScrollChoiceManager {
  const GridSizeScrollChoiceManager({
    super.key,
    super.gridOptionsCount = 7,
    required super.scenarioController,
    required super.gameController,
  });

  @override
  State<GridSizeScrollChoiceManager> createState() =>
      _GridSizeScrollChoiceManagerState();
}

class _GridSizeScrollChoiceManagerState
    extends State<GridSizeScrollChoiceManager> {
  int? _selectedIndex;

  void handleTapboxChanged(int index) {
    widget.scenarioController.changeGridSize(index);
    widget.gameController.resetGame();
  }

  // * Returns the most common FIAR grid sizes based on an index.
  // * To be used when using a List.generate.
  String getScrollChoiceCardsText(int index) {
    switch (index) {
      case 0:
        return '4 x 5';
      case 1:
        return '5 x 6';
      case 2:
        return '6 x 7';
      case 3:
        return '7 x 8';
      case 4:
        return '7 x 9';
      case 5:
        return '7 x 10';
      case 6:
        return '8 x 8';
      default:
        throw Exception('index value is unexpected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.scenarioController
        .getCurrentGridSizeIndex(); // defaults to 6 x 7 gridsize
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.gridOptionsCount, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ScrollChoiceCard(
              isSelected: _selectedIndex == index,
              onTap: () => handleTapboxChanged(index),
              text: getScrollChoiceCardsText(index),
            ),
          );
        }),
      ),
    );
  }
}

/*
  The scroll choice manager for the points scoring logic.
*/

class PointsScoringScrollChoiceManager extends ScrollChoiceManager {
  const PointsScoringScrollChoiceManager({
    super.key,
    super.gridOptionsCount = 9, // scores : 2 3 4 5 6 7 8 9 10
    required super.scenarioController,
    required super.gameController,
  });

  @override
  State<PointsScoringScrollChoiceManager> createState() =>
      _PointsScoringScrollChoiceManagerState();
}

class _PointsScoringScrollChoiceManagerState
    extends State<PointsScoringScrollChoiceManager> {
  int? _selectedIndex;

  void handleTapboxChanged(int index) {
    widget.scenarioController.changePointScoring(index);
    widget.gameController.updatePointScoring();
  }

  String getScrollChoiceCardsText(int index) {
    switch (index) {
      case 0:
        return '2';
      case 1:
        return '3';
      case 2:
        return '4';
      case 3:
        return '5';
      case 4:
        return '6';
      case 5:
        return '7';
      case 6:
        return '8';
      case 7:
        return '9';
      case 8:
        return '10';
      default:
        throw Exception('index value is unexpected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.scenarioController
        .getCurrentPointsToScoreIndex(); // defaults to 6 x 7 gridsize
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.gridOptionsCount, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ScrollChoiceCard(
              isSelected: _selectedIndex == index,
              onTap: () => handleTapboxChanged(index),
              text: getScrollChoiceCardsText(index),
            ),
          );
        }),
      ),
    );
  }
}

/*
  This widget is the box that can be clicked when scrolling options.
*/

class ScrollChoiceCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String text;

  const ScrollChoiceCard(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        padding: const EdgeInsets.all(20.0), // between text and the boundary
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightRed : AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: isSelected
                ? WhiteTextStyle.mediumText
                : BlackTextStyle.mediumText,
          ),
        ),
      ),
    );
  }
}
