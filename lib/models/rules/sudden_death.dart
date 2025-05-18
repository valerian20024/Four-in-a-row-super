import 'package:four_in_a_row_super/models/rules/win_condition_rule.dart';

class SuddenDeathRule extends WinConditionRule {
  SuddenDeathRule(
      {required super.name,
      required super.longDescription,
      required super.shortDescription,
      super.score = 1});
}
