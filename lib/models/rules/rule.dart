class Rule {
  String name;
  String longDescription;
  String shortDescription;

  Rule({
    required this.name,
    required this.longDescription,
    required this.shortDescription,
  });

  // ! This method should not be overriden, as names
  // ! are used for finding a rule in a scenario.
  // ! Grid Size does override it but in the context of
  // ! the application, it doesn't create problems.
  // todo : add an ID to rule for comparison, to avoid
  // todo   this problem
  String getName() {
    return name;
  }

  String getShortDescription() {
    return shortDescription;
  }

  String getLongDescription() {
    return longDescription;
  }

  String getType() {
    return 'Rule';
  }
}
