import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/rules_controller.dart';
import 'package:four_in_a_row_super/models/rules/rule.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/bottombars.dart';
import 'package:four_in_a_row_super/views/widgets/rule_explanation.dart';
import 'package:four_in_a_row_super/views/widgets/text_boxes.dart';

/*
  This page intends to list all the rules present in the game to
  explain the user what they are for. Uses RuleExplanationBox widgets to
  build and asks RulesController the different rules of the game.
*/

class RulesView extends StatefulWidget {
  static List<Rule> rules = RulesController.getAllRules();

  const RulesView({
    super.key,
  });

  @override
  State<RulesView> createState() => _RulesViewState();
}

class _RulesViewState extends State<RulesView> {
  final headingWidgetsNumber = 3; // how to play, custom game, rules heading

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DoubleAppBar(
        title: 'Rules',
        subTitle: 'Learn how to play',
      ),
      backgroundColor: AppColors.lightBlue,
      bottomNavigationBar: const BackBottomBar(),
      body: ListView.builder(
          itemCount: RulesView.rules.length + headingWidgetsNumber,
          //prototypeItem: RuleExplanationBox(rule: RulesView.rules[0]),
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Column(
                children: [
                  HowToPlayRulesDescription(),
                  Divider(),
                ],
              );
            }
            if (index == 1) {
              return const Column(
                children: [
                  CustomPlayRulesDescription(),
                  Divider(),
                ],
              );
            }
            if (index == 2) {
              return const RuleHeadingRulesDescription();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RuleExplanationBox(
                    rule: RulesView.rules[index - headingWidgetsNumber]),
              );
            }
          }),
    );
  }
}
