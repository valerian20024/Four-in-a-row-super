import 'rule.dart';

class PowerUps extends Rule {
  PowerUps({
    required super.name,
    required super.longDescription,
    required super.shortDescription,
  });

  @override
  String getType() {
    return 'Power Up';
  }
}
