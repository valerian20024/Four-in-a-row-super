import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/models/rules/rule.dart';
import 'package:four_in_a_row_super/views/styles/box_decorations.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:four_in_a_row_super/views/widgets/rule_type_container.dart';
import 'package:four_in_a_row_super/views/widgets/text_boxes.dart';

/*
  This widget is the box containg all the necessary
  information for a given rule to explain the user
  how to use it and how to combine it with other
  rules.
*/

class RuleExplanationBox extends StatelessWidget {
  final Rule rule;

  const RuleExplanationBox({
    super.key,
    required this.rule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RulePresentation.ruleExplanationBox,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child:
                    Text(rule.getName(), style: HeadingTextStyle.mediumHeading),
              ),
              RuleTypeContainer(
                text: rule.getType(),
                color: rule.getType() == 'Power Up' ? 'yellow' : 'red',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RuleDescriptionBox(
              text: rule.getLongDescription(),
            ),
          ),
        ],
      ),
    );
  }
}
