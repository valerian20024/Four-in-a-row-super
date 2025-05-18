import 'package:four_in_a_row_super/controllers/rules_controller.dart';
import 'package:four_in_a_row_super/models/scenarios/scenario.dart';

/* 
This file intends to create various basic scenario that will
be available in the game. This is mostly text and a type that
will allow UI code to build correctly.
*/

abstract class PredefinedScenarios {
  static getClassicScenario() {
    return Scenario(
      name: 'Classic',
      longDescription: 'long descption for this sceario',
      shortDescription: 'short description',
      rules: [
        RulesController.getNormalGravity(),
        RulesController.getSuddenDeath(),
        RulesController.getDefaultGridSize(),
      ],
      type: 'classic',
    );
  }

  static getPopoutScenario() {
    return Scenario(
      name: 'PopOut',
      longDescription: 'long description for that sceario',
      shortDescription: 'short description popout',
      rules: [
        RulesController.getPopoutGravity(),
        RulesController.getSuddenDeath(),
        RulesController.getDefaultGridSize(),
      ],
      type: 'popout',
    );
  }

  // basic custom scenario : template for the user to add the rules he wants
  static getEmptyCustomScenario() {
    return Scenario(
      name: 'Custom Scenario',
      type: 'custom',
      rules: [],
    );
  }

  // ! test scenario
  static getScoringScenario() {
    return Scenario(
      name: 'Custom Scenario',
      type: 'custom',
      rules: [
        RulesController.getAllSidesGravity(),
        RulesController.getPointsScoring(5),
        RulesController.getGridSize(6, 7),
      ],
    );
  }
}
