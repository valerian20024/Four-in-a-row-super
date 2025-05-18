import 'package:four_in_a_row_super/models/rules/rule.dart';

class GravityDirectionRule extends Rule {
  int up, down, left, right; // 0 for empty, 1 for gravity, 2 for popout.

  GravityDirectionRule({
    required super.name,
    required super.longDescription,
    required super.shortDescription,
    required this.up,
    required this.down,
    required this.left,
    required this.right,
  });

  @override
  String getType() {
    return 'Gravity';
  }

  bool isOppositeDirection() {
    if (up == 1 && down == 1 && left == 0 && right == 0) {
      return true;
    }
    return false;
  }

  bool isNormal() {
    if (up == 1 && down == 0 && left == 0 && right == 0) {
      return true;
    }
    return false;
  }

  bool isOneSideBlocked() {
    if (up == 1 && left == 1 && right == 1 && down == 0) {
      return true;
    }
    return false;
  }

  bool isPopout() {
    if (up == 1 && down == 2 && left == 0 && right == 0) {
      return true;
    }
    return false;
  }

  bool isAllDirections() {
    if (up == 1 && down == 1 && left == 1 && right == 1) {
      return true;
    }
    return false;
  }
}
