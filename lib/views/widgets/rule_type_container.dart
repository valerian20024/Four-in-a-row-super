import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/box_decorations.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';

/*
  This widgets aims at displaying in a stylised container
  the type of rule (Win condition, Grid Size, Power Up, etc.)
  in the RulesView page.
*/

class RuleTypeContainer extends StatelessWidget {
  final String text;
  final String color;

  const RuleTypeContainer({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: color == 'yellow'
          ? RulePresentation.smallYellowContainerDecoration
          : RulePresentation.smallRedContainerDecoration,
      child: Center(
          child: Text(
        text,
        style: HeadingTextStyle.smallHeading,
      )),
    );
  }
}
