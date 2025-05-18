import 'rule.dart';

class WinConditionRule extends Rule {
  int score;

  WinConditionRule({
    required super.name,
    required super.longDescription,
    required super.shortDescription,
    required this.score,
  });

  int getScore() {
    return score;
  }

  @override
  String getType() {
    return 'Win Condition';
  }
}
