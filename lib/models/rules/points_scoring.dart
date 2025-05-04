import 'package:four_in_a_row_super/models/rules/win_condition_rule.dart';

/*
  This Rule is used for when the player has to score multiple times before
  winning the game.

  score can be : 2 3 4 5 6 7 8 9 10
*/

class PointsScoringRule extends WinConditionRule {
  PointsScoringRule(
      {required super.name,
      required super.longDescription,
      required super.shortDescription,
      required super.score});

  void setScore(int score) {
    this.score = score;
  }
}
