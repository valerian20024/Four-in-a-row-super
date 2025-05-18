import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';

/*
  This file describes various styles to apply to buttons throughout 
  the app.
*/

// Style for Homepage's button (Play, Settings, About, ...)
abstract class MainMenuButtonStyles {
  static final ButtonStyle playButton =
      _getMainMenuGenericButtonStyle(AppColors.lightYellow);
  static final ButtonStyle settingsButton =
      _getMainMenuGenericButtonStyle(AppColors.lightRed);
  static final ButtonStyle aboutButton =
      _getMainMenuGenericButtonStyle(AppColors.darkBlue);
  static final ButtonStyle exitButton =
      _getMainMenuGenericButtonStyle(AppColors.darkBlue);

  static ButtonStyle _getMainMenuGenericButtonStyle(Color color) {
    return (ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(
            vertical: 20.0, horizontal: 100.0), // Add padding around button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )));
  }
}

// When exiting the app, the popup menu buttons are stylized.
abstract class ExitMenuButtonStyles {
  static final cancelButton = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      backgroundColor: AppColors.lightRed);

  static final exitButton = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      backgroundColor: AppColors.lightGreen);
}

// Style for buttons used everywhere in the app
abstract class GlobalButtonStyles {
  static final backButton = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    backgroundColor: AppColors.lightYellow,
  );

  static final acceptButton = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      backgroundColor: AppColors.lightGreen);

  static final rulesButton = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    backgroundColor: AppColors.darkPurple,
  );

  static final redSquareButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    backgroundColor: AppColors.lightRed,
  );

  static final yellowSquareButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    backgroundColor: AppColors.lightYellow,
  );

  static final easyButton = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    backgroundColor: AppColors.lightGreen,
  );

  static final intermediateButton = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    backgroundColor: AppColors.lightYellow,
  );

  static final hardButton = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    backgroundColor: AppColors.lightRed,
  );
}
