import '../rules/rule.dart';

class Scenario {
  String name;
  String type; // classic, popout, custom

  String? longDescription;
  String? shortDescription;

  List<Rule> rules;

  Scenario({
    required this.name,
    required this.type,
    this.longDescription,
    this.shortDescription,
    required this.rules,
  });

  setName(String name) {
    this.name = name;
  }

  setShortDescription(String desc) {
    shortDescription = desc;
  }

  setLongDescription(String desc) {
    longDescription = desc;
  }

  bool contains(Rule rule) {
    for (var r in rules) {
      if (r.getName() == rule.getName()) {
        return true;
      }
    }
    return false; // no rule is found having the same name
  }

  void add(Rule rule) {
    rules.add(rule);
  }

  void remove(Rule rule) {
    // remove the specific rule
    for (int i = 0; i < rules.length; i++) {
      if (rules[i].getName() == rule.getName()) {
        rules.removeAt(i);
      }
    }
  }
}
