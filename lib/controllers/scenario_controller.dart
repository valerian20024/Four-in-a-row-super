import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/rules_controller.dart';
import 'package:four_in_a_row_super/models/rules/bombs_power_up.dart';
import 'package:four_in_a_row_super/models/rules/gravity_direction_rule.dart';
import 'package:four_in_a_row_super/models/rules/grid_size_rule.dart';
import 'package:four_in_a_row_super/models/rules/play_twice_power_up.dart';
import 'package:four_in_a_row_super/models/rules/points_scoring.dart';
import 'package:four_in_a_row_super/models/rules/win_condition_rule.dart';
import 'package:four_in_a_row_super/models/rules/power_ups.dart';
import 'package:four_in_a_row_super/models/rules/rule.dart';
import 'package:four_in_a_row_super/models/scenarios/predefined_scenarios.dart';
import 'package:four_in_a_row_super/models/scenarios/scenario.dart';

/*
  This controller handles the scenario to be played.
  By default, will play with a classic scenario.
  However, the user can change the Rules of the game to best
  suit its needs. This is handled by this controller.
*/

class ScenarioController extends ChangeNotifier {
  Scenario scenario = PredefinedScenarios.getClassicScenario();

  /*
    checks the current scenario's rules are compatible
    1) there must be one and only one win condition
    2) there must be one and only one gravity condition
    3) there can be various power ups

    returns true if rules are compatible, false otherwise
  */
  bool checkCurrentRulesCompatibility() {
    int numberWinConditions = 0;
    int numberGridSize = 0;
    if (scenario.rules == []) {
      return true;
    } else {
      for (var r in scenario.rules) {
        if (r is WinConditionRule) {
          if (numberWinConditions >= 1) {
            return false; // there is already a win condition
          } else {
            numberWinConditions++;
          }
        } else if (r is GridSizeRule) {
          if (numberGridSize >= 1) {
            return false;
          } else {
            numberGridSize++;
          }
        } else if (r is PowerUps) {
          continue;
        } else {
          throw Exception('r.type shouldnt be of this type');
        }
      }
      return true;
    }
  }

  /* 
    This method adds a rule if it is compatible with
    the current scenario.
  */
  bool checkRuleCompatibilityWithScenario(Rule rule) {
    addRule(rule);

    if (checkCurrentRulesCompatibility()) {
      return true;
    } else {
      removeRule(rule);
      return false;
    }
  }

  void _setCurrentScenario(Scenario scenario) {
    this.scenario = scenario;
    notifyListeners();
  }

  void loadPopoutScenario() {
    _setCurrentScenario(PredefinedScenarios.getPopoutScenario());
    notifyListeners();
  }

  void loadClassicScenario() {
    _setCurrentScenario(PredefinedScenarios.getClassicScenario());
    wantToAddRule(RulesController.getSuddenDeath());
    notifyListeners();
  }

  void addRule(Rule rule) {
    scenario.add(rule);
  }

  void removeRule(Rule rule) {
    if (isRuleActive(rule)) {
      scenario.remove(rule);
    }
  }

  bool isPlayTwiceRuleActive() {
    for (var r in scenario.rules) {
      if (r is PlayTwicePowerUp) {
        return true;
      }
    }
    return false;
  }

  bool isBombRuleActive() {
    for (var r in scenario.rules) {
      if (r is BombsPowerUp) {
        return true;
      }
    }
    return false;
  }

  List<Rule> getCurrentRules() {
    return scenario.rules;
  }

  /*
    This method returns a number depending on the gravity rule in the current scenario
      0 if normal gravity
      1 if one side is blocked
      2 if opposite side gravity
      3 if popout kind of gravity
      4 all sides gravity
  */
  int whichGameboardScaffold() {
    for (var r in scenario.rules) {
      if (r is GravityDirectionRule) {
        if (r.isNormal()) {
          return 0;
        }
        if (r.isOneSideBlocked()) {
          return 1;
        }
        if (r.isOppositeDirection()) {
          return 2;
        }
        if (r.isPopout()) {
          return 3;
        }
        if (r.isAllDirections()) {
          return 4;
        }
        throw Exception('r is a gravity rule, but none of the specified');
      }
    }
    throw Exception('there is no gravity rule');
  }

  /*
    This method allows to tell which upperBar the UI should
    build by returning a number depending on the current rules.
    0 if sudden death
    1 if there's a score to get for wining
  */
  int whichUpperBar() {
    for (var r in scenario.rules) {
      if (r is WinConditionRule) {
        if (r.score == 1) {
          return 0;
        } else {
          return 1;
        }
      }
    }
    throw Exception('there are no PointsScoringRule in the scenario');
  }

  /*
    This method allows to tell which bottomBar the UI should
    build by returning a number depending on the current rules.
    0 if there is none
    1 if there's at least one power up
  */
  int whichBottomBar() {
    for (var r in scenario.rules) {
      if (r is PowerUps) {
        return 1;
      }
    }
    return 0;
  }

  bool isRuleActive(Rule rule) {
    return scenario.contains(rule);
  }

  /*
    This method allows to safely add a rule by
    removing every rules that are competing with it.
  */
  bool wantToAddRule(Rule rule) {
    // removing every rule related to win condition
    if (rule is WinConditionRule) {
      removeRule(RulesController.getSuddenDeath());
      removeRule(RulesController.getDefaultPointsScoring());
    }

    // removing every rule related to gravity
    if (rule is GravityDirectionRule) {
      removeRule(RulesController.getNormalGravity());
      removeRule(RulesController.getPopoutGravity());
      removeRule(RulesController.getOppositeGravity());
      removeRule(RulesController.getOneSideBlockedGravity());
      removeRule(RulesController.getAllSidesGravity());
    }

    addRule(rule);
    notifyListeners();
    return true;
  }

  bool wantToRemoveRule(Rule rule) {
    removeRule(rule);
    notifyListeners();
    return true;
  }

  /*
    This method prints all the rules in the current scenario
    to the terminal. For debugging purpose.
  */
  void printAllRulesName() {
    debugPrint("all rules :");
    for (var rule in scenario.rules) {
      debugPrint(rule.getName());
    }
  }

  /*
    This method extract the grid size out of the current
    grid size rule and returns in the shape of a list of int.
  */
  List<int> getCurrentGridSize() {
    for (var rule in scenario.rules) {
      if (rule is GridSizeRule) {
        return [rule.lines, rule.columns];
      }
    }
    throw Exception("There is no GridSize Rule in the scenario");
  }

  /*
    This method allows to generate the UI by indexing its components
    depending on the grid size rule in the current scenario.
  */
  int getCurrentGridSizeIndex() {
    for (var rule in scenario.rules) {
      if (rule is GridSizeRule) {
        switch ([rule.lines, rule.columns]) {
          case [4, 5]:
            return 0;
          case [5, 6]:
            return 1;
          case [6, 7]:
            return 2;
          case [7, 8]:
            return 3;
          case [7, 9]:
            return 4;
          case [7, 10]:
            return 5;
          case [8, 8]:
            return 6;
          default:
            throw Exception(
                'There is no such lines x cols possible (${rule.lines} x ${rule.columns})');
        }
      }
    }
    throw Exception('getCurrentGridSizeIndex: There is no Grid Size Rule');
  }

  /*
    Get the amount of points to be scored in the current scenario.
  */
  int getPointsToScore() {
    for (var rule in scenario.rules) {
      if (rule is WinConditionRule) {
        return rule.score;
      }
    }
    throw Exception('getPointsToScore : there is no win condition rule');
  }

  /*
    This method allows to generate the UI by indexing its components
    depending on the PointsScoring rule in the current scenario.
  */
  int getCurrentPointsToScoreIndex() {
    for (var rule in scenario.rules) {
      if (rule is PointsScoringRule) {
        switch (rule.score) {
          case 2:
            return 0;
          case 3:
            return 1;
          case 4:
            return 2;
          case 5:
            return 3;
          case 6:
            return 4;
          case 7:
            return 5;
          case 8:
            return 6;
          case 9:
            return 7;
          case 10:
            return 8;
          default:
            throw Exception('There is no such score (${rule.score}) possible');
        }
      }
    }
    throw Exception(
        'getCurrentPointsToScore : There is no Points To Score Rule ');
  }

  /*
    This method allows to set the current scenario's grid size values.
  */
  void changeGridSize(int index) {
    for (var rule in scenario.rules) {
      if (rule is GridSizeRule) {
        switch (index) {
          case 0:
            rule.setLinesAndColumns(4, 5);
            break;
          case 1:
            rule.setLinesAndColumns(5, 6);
            break;
          case 2:
            rule.setLinesAndColumns(6, 7);
            break;
          case 3:
            rule.setLinesAndColumns(7, 8);
            break;
          case 4:
            rule.setLinesAndColumns(7, 9);
            break;
          case 5:
            rule.setLinesAndColumns(7, 10);
            break;
          case 6:
            rule.setLinesAndColumns(8, 8);
            break;
          default:
            throw Exception('There cannot be another kind of grid size.');
        }
      }
    }
    notifyListeners();
  }

  /*
    This method allows to set the current scenario's points to score value.
  */
  void changePointScoring(int index) {
    for (var rule in scenario.rules) {
      if (rule is PointsScoringRule) {
        switch (index) {
          case 0:
            rule.setScore(2);
            break;
          case 1:
            rule.setScore(3);
            break;
          case 2:
            rule.setScore(4);
            break;
          case 3:
            rule.setScore(5);
            break;
          case 4:
            rule.setScore(6);
            break;
          case 5:
            rule.setScore(7);
            break;
          case 6:
            rule.setScore(8);
            break;
          case 7:
            rule.setScore(9);
            break;
          case 8:
            rule.setScore(10);
            break;
          default:
            throw Exception('There cannot be another kind of score.');
        }
      }
    }
    notifyListeners();
  }

  /*
    This method returns the current GravityDirection rule.
  */
  GravityDirectionRule getGravityType() {
    for (Rule r in scenario.rules) {
      if (r is GravityDirectionRule) {
        return r;
      }
    }
    throw Exception('There is no GravityDirectionRule in this scenario');
  }
}
