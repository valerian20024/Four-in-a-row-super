import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/button_style.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:four_in_a_row_super/views/widgets/buttons.dart';

class AppExitManager {
  /*
    This method exits the app on Android devices.
  */
  static void exitAndroid() {
    SystemNavigator.pop();
  }

  /*
    Helper method for printing when the app is exited without actually
    exiting it. Useful for debugging purpose so that you don't
    have to flutter run again.
  */
  static void _fakeExit() {
    debugPrint('exit(0)'); // shows it quits, but doesn't actually quit the app
  }

  /*
    This method shows a confiormation dialog when exiting the game.
  */
  static Future<void> confirmExitApp(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titleTextStyle: HeadingTextStyle.mediumHeading,
        contentTextStyle: WhiteTextStyle.mediumText,
        backgroundColor: AppColors.darkBlue,
        title: const Text('Exit App'),
        content:
            const Text('Are you sure you want to exit Four-in-a-row super?'),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ExitMenuButton(
                    f: () => Navigator.of(context).pop(false),
                    style: ExitMenuButtonStyles.cancelButton,
                    text: 'Cancel',
                    textStyle: HeadingTextStyle.mediumHeading),
                ExitMenuButton(
                    f: () => Navigator.of(context).pop(true),
                    style: ExitMenuButtonStyles.exitButton,
                    text: 'Exit',
                    textStyle: HeadingTextStyle.mediumHeading),
              ],
            ),
          ),
        ],
      ),
    );
    if (shouldExit == true) {
      exitAndroid();
    }
  }
}
