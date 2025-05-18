import 'package:four_in_a_row_super/models/rules/bombs_power_up.dart';
import 'package:four_in_a_row_super/models/rules/gravity_direction_rule.dart';
import 'package:four_in_a_row_super/models/rules/grid_size_rule.dart';
import 'package:four_in_a_row_super/models/rules/play_twice_power_up.dart';
import 'package:four_in_a_row_super/models/rules/points_scoring.dart';
import 'package:four_in_a_row_super/models/rules/sudden_death.dart';
import 'package:four_in_a_row_super/models/rules/win_condition_rule.dart';
import 'package:four_in_a_row_super/models/rules/rule.dart';

/*
  This controllers aims to create all the rules that will be used in 
  the game. It allows to access any of them by calling dedicated static methods.
*/

abstract class RulesController {
  // ! win conditions

  /*
    This method creates a PointScoring Rule with specific values.
    Sudden Death Rule is a Point Scoring Rule with score of 1.
  */
  static SuddenDeathRule getSuddenDeath() {
    return SuddenDeathRule(
      name: "Sudden Death",
      longDescription: 'The first player to get 4 Checkers in a row wins. '
          'If you want to give more lifetime to your games, see \'Points Scoring\' rule. ',
      shortDescription: 'Align 4 Checkers to win.',
    );
  }

  /*
    This method creates a Point Scoring Rule with specific values.
  */
  static PointsScoringRule getPointsScoring(int score) {
    return PointsScoringRule(
      name: "Points Scoring",
      longDescription:
          'The first player to gain as many points as specified wins. '
          'To get a point, simply align 4 Checkers in a row. '
          'The number of points to score can be freely chosen from 2 to 10. '
          'For scoring one point, use the \'Sudden Death\' rule. ',
      shortDescription:
          'The first player to gain as many points as specified wins.',
      score: score,
    );
  }

  // ! gravity rules

  /*
    This method creates a Gravity Direction Rule with specific values.
  */
  static GravityDirectionRule getNormalGravity() {
    return GravityDirectionRule(
      name: 'Normal',
      shortDescription: 'Put Checkers on top.',
      longDescription: 'You can put Checkers on top. '
          'If you have activated \'Power-Ups\' rules, you can place them on top as well. ',
      up: 1,
      down: 0,
      left: 0,
      right: 0,
    );
  }

  /*
    This method creates a Gravity Direction Rule with specific values.
  */
  static GravityDirectionRule getPopoutGravity() {
    return GravityDirectionRule(
      name: 'PopOut',
      longDescription:
          'You can place Checkers (or Power-Ups) on top, and remove one Checker from the bottom. '
          'Removing this Checker will make all the Checkers on top fall. ',
      shortDescription: 'Put Checkers on top, remove one from bottom.',
      up: 1,
      down: 2,
      left: 0,
      right: 0,
    );
  }

  /*
    This method creates a Gravity Direction Rule with specific values.
  */
  static GravityDirectionRule getOneSideBlockedGravity() {
    return GravityDirectionRule(
        name: 'One Side Blocked',
        longDescription:
            'You can place Checkers everywhere (left, right, up) but on the bottom. '
            'Checkers placed for example on the left will thus "fall" from left to right. '
            'The Checker will stop falling if if encouters another Checker or if it gets to '
            'the end of the gameboard (in the example, the right edge). '
            'If a gameboard entry is occupied by a Checker, it\'s no longer usable. ',
        shortDescription: 'Place Checkers on any but one side.',
        up: 1,
        down: 0,
        left: 1,
        right: 1);
  }

  /*
    This method creates a Gravity Direction Rule with specific values.
  */
  static GravityDirectionRule getOppositeGravity() {
    return GravityDirectionRule(
        name: 'Opposite Sides',
        longDescription: 'You can place Checkers on top and on the bottom. '
            'Placing a Checker on bottom will make it "fall" to the top until it encounters '
            'another Checker or it gets to the upper limit of the gameboard. '
            'If a gameboard entry is occupied by a Checker, it\'s no longer usable. ',
        shortDescription: 'Place Checkers on two opposite sides.',
        up: 1,
        down: 1,
        left: 0,
        right: 0);
  }

  /*
    This method creates a Gravity Direction Rule with specific values.
  */
  static GravityDirectionRule getAllSidesGravity() {
    return GravityDirectionRule(
        name: 'All Sides',
        longDescription:
            'You can place Checkers (or Power Ups) anywhere around the gameboard. '
            'Their gravity will thus be affected. A Checker placed on the right side will '
            '"fall" until it reaches the left side or encounters another Checker. ',
        shortDescription: '''Place Checkers on any side.''',
        up: 1,
        down: 1,
        left: 1,
        right: 1);
  }

  // ! power ups

  /*
    This method creates a Bomb Rule.
  */
  static BombsPowerUp getBombs() {
    return BombsPowerUp(
        name: 'Bombs',
        longDescription:
            'You can place a Bomb instead of a Checker any place the Gravity '
            'Direction Rule allows it. To use a Power-Up, you first have to select '
            'it in your inventory. ',
        shortDescription: 'Place bombs instead of Checkers.');
  }

  /*
    This method creates a Play Twice Rule.
  */
  static PlayTwicePowerUp getPlayTwice() {
    return PlayTwicePowerUp(
      name: 'Play Twice',
      longDescription:
          'You can play twice in a row. Use this Power-Up by tapping on it '
          'in your inventory whenever it\'s your turn. ',
      shortDescription: 'Play twice in a row.',
    );
  }

  // ! Grid Sizes

  /*
    This method creates a GridSize Rule.
    Traditional grid sizes include : (lines x cols) 4x5  5x6  7x8  7x9  7x10  8x8
  */
  static GridSizeRule getGridSize(int lines, int columns) {
    return GridSizeRule(
        name: 'Grid Size',
        longDescription:
            'You can change the size of the grid. Choose between several predetermined options. '
            'The classical sizes for Four-in-a-Row are (lines x columns): '
            '4x5  5x6  6x7  7x8  7x9  7x10  8x8 ',
        shortDescription: 'Changes Grid Size',
        lines: lines,
        columns: columns);
  }

  /*
    Returns a default Grid Size Rule whose size is 6 by 7.
  */
  static GridSizeRule getDefaultGridSize() {
    return getGridSize(6, 7);
  }

  /*
    Returns a default PointScoring Rule whose score is 2.
  */
  static WinConditionRule getDefaultPointsScoring() {
    return getPointsScoring(2);
  }

  /*
    This method returns all the possible rules existing.
  */
  static List<Rule> getAllRules() {
    return [
      getSuddenDeath(),
      getDefaultPointsScoring(),
      getNormalGravity(),
      getPopoutGravity(),
      getOneSideBlockedGravity(),
      getOppositeGravity(),
      getAllSidesGravity(),
      getBombs(),
      getPlayTwice(),
      getDefaultGridSize(),
    ];
  }
}
