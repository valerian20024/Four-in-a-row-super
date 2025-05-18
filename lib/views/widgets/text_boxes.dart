import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/box_decorations.dart';
import 'package:four_in_a_row_super/views/widgets/rule_type_container.dart';
import '../styles/text_style.dart';
import '../styles/app_colors.dart';

/*
  This file implements various kinds of text boxes that can be found throughout the app
  (e.g. AboutView, RulesView, ...)
*/

class DescriptionBox extends StatelessWidget {
  final double width;
  //final double height;
  final String text;

  const DescriptionBox(
      {super.key,
      required this.width,
      //required this.height,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return (Container(
      padding: const EdgeInsets.all(12.0), // between text and the boundary
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: WhiteTextStyle.smallText,
      ),
    ));
  }
}

// This widget is text to be displayed in the RulesView.
// It tells the player the basic way of using the game.
class HowToPlayRulesDescription extends StatelessWidget {
  const HowToPlayRulesDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Column(
        children: [
          Text(
            'How To Play?',
            style: HeadingTextStyle.mediumHeading,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            "You can choose to play classic style four-in-a-row. "
            "For example the classic four-in-a-row, or its PopOut version. "
            "Or else you can choose from a set of rules and combine them together "
            "to have another four-in-a-row experience! ",
            style: WhiteTextStyle.mediumText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// This widget is text to be displayed in the RulesView.
// It tells the player the basic way of creating custom games.
class CustomPlayRulesDescription extends StatelessWidget {
  const CustomPlayRulesDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Column(
        children: [
          const Text(
            'Play the way you want',
            style: HeadingTextStyle.mediumHeading,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: RulePresentation.smallYellowContainerDecoration,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Classic',
                    style: HeadingTextStyle.smallHeading,
                  ),
                )),
          ),
          const Text(
            'Place Checkers on top and try to get four of them aligned '
            'horizontaly, verticaly, or in diagonal. The first player '
            'to align them wins! ',
            style: WhiteTextStyle.smallText,
            textAlign: TextAlign.justify,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: RulePresentation.smallRedContainerDecoration,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'PopOut',
                    style: HeadingTextStyle.smallHeading,
                  ),
                )),
          ),
          const Text(
            'Instead of only putting checkers on top, you can also pop one '
            'from the bottom! This will make fall all the other checkers on top. '
            'It can clearly change all the game.',
            style: WhiteTextStyle.smallText,
            textAlign: TextAlign.justify,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: RulePresentation.smallRedContainerDecoration,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Custom',
                    style: HeadingTextStyle.smallHeading,
                  ),
                )),
          ),
          const Text(
            'If you want to spice up things, you can try to play a custom game. '
            'Custom games behave completely differently. You can choose from a set '
            'of predefined rules and mix them together. Those rules are of different types :',
            style: WhiteTextStyle.smallText,
            textAlign: TextAlign.justify,
          ),
          const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        RuleTypeContainer(text: 'Win Condition', color: 'red'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RuleTypeContainer(text: 'Grid Size', color: 'red'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RuleTypeContainer(text: 'Power Up', color: 'yellow'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RuleTypeContainer(text: 'Gravity', color: 'red'),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'You can only one rule of Win Condition, one Grid Size, one Gravity, and as many power ups as you want!',
              style: WhiteTextStyle.smallText,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

// This widget is text to be displayed in the RulesView.
// It's the heading for presenting all the rules in the
// RulesView page.
class RuleHeadingRulesDescription extends StatelessWidget {
  const RuleHeadingRulesDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Rules', style: HeadingTextStyle.mediumHeading),
        ),
        Text(
          'Find all the rules available below:',
          style: HeadingTextStyle.smallHeading,
        ),
      ],
    );
  }
}

class RuleDescriptionBox extends StatelessWidget {
  final String text;
  const RuleDescriptionBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: RulePresentation.ruleDescriptionBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: BlackTextStyle.smallText,
        ),
      ),
    ));
  }
}
