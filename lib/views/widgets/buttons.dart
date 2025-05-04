import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/button_style.dart';
import '../styles/text_style.dart';

/*
  This file implements various buttons used throughout the app.
  They are hierarchically build, with Button being the root class.
*/

/*
  A basic button with a function to be triggered when we push it.
*/
class Button extends StatelessWidget {
  final Function f;
  final ButtonStyle style;
  final String text;
  final TextStyle textStyle;

  const Button(
      {super.key,
      required this.f,
      required this.style,
      required this.text,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: const EdgeInsets.all(1.0),
        child: ElevatedButton(
          onPressed: () {
            f();
          },
          style: style,
          child: Text(textAlign: TextAlign.center, text, style: textStyle),
        )));
  }
}

// Yellow 'Back' Button.
// Can't call it "BackButton" because Flutter already has implemented this class
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return (Button(
      f: () => Navigator.pop(context),
      style: GlobalButtonStyles.backButton,
      text: 'Back',
      textStyle: ButtonsTextStyle.backButton,
    ));
  }
}

// Button when exiting the app
class ExitMenuButton extends StatelessWidget {
  final Function f;
  final ButtonStyle style;
  final String text;
  final TextStyle textStyle;

  const ExitMenuButton(
      {super.key,
      required this.f,
      required this.style,
      required this.text,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 60,
      child: (Button(f: f, style: style, text: text, textStyle: textStyle)),
    );
  }
}

// Button to accept the scenario
class AcceptButton extends StatelessWidget {
  final Function f;

  const AcceptButton({super.key, required this.f});

  @override
  Widget build(BuildContext context) {
    return (Button(
      f: f,
      style: GlobalButtonStyles.acceptButton,
      text: 'Accept',
      textStyle: ButtonsTextStyle.backButton,
    ));
  }
}

// Button to access the Rules
class RulesButton extends StatelessWidget {
  const RulesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return (Button(
      f: () => Navigator.pushNamed(context, '/rules'),
      style: GlobalButtonStyles.rulesButton,
      text: 'Rules',
      textStyle: ButtonsTextStyle.backButton,
    ));
  }
}
