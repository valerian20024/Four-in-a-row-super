import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import 'package:four_in_a_row_super/models/rules/rule.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';

/*
  This widget displays a rule that can be added into the current scenario.
  It's present in the scenario page. The rule can be checked and this information returns to 
  scenarioController. The widgets's state is managed by scenarioController.
*/

class RuleCheckboxListTile extends StatelessWidget {
  final ScenarioController scenarioController;
  final Rule rule;
  final bool exclusive; // whether there can only be one of its kind active

  const RuleCheckboxListTile({
    super.key,
    required this.scenarioController,
    required this.rule,
    required this.exclusive,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        rule.getName(),
        style: HeadingTextStyle.smallHeading,
      ),
      activeColor: AppColors.white,
      checkColor: AppColors.darkRed,
      subtitle: Text(
        rule.getShortDescription(),
        style: BlackTextStyle.smallText,
      ),
      value: scenarioController.isRuleActive(rule),
      onChanged: (bool? value) {
        bool isRuleActive = scenarioController.isRuleActive(rule);
        if (exclusive) {
          if (!(isRuleActive)) {
            scenarioController.wantToAddRule(rule);
          }
        } else {
          isRuleActive
              ? scenarioController.wantToRemoveRule(rule)
              : scenarioController.wantToAddRule(rule);
        }
      },
    );
  }
}
