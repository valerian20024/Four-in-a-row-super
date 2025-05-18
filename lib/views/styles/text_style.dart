import 'package:flutter/material.dart';
import 'app_colors.dart';

// This file defines various textstyle to use throughout the app, instead of manually hardcoding them.
// It is divided by classes, for grouping types of TextStyles together
// Then, one can access a specific TextStyle using for example :
//
// import 'text_style.dart';
//
// const Text('Choose your rules', style: HeadingTextStyle.mediumHeading)
//

abstract class MainAppTextStyle {
  static const TextStyle appTitle = TextStyle(
    color: AppColors.white,
    fontSize: 40,
    fontWeight: FontWeight.normal,
    fontFamily: 'Luckiest_Guy',
  );

  static const TextStyle appSubTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.normal,
    fontFamily: 'Honk',
  );

  static const TextStyle fallingCheckers = TextStyle(
      color: AppColors.invisibleWhite, fontFamily: 'Honk', fontSize: 14);
}

// * all the textstyle for text (heading) in general
abstract class HeadingTextStyle {
  // to be used with small size heading text thoughout the app
  static const TextStyle smallHeading = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Luckiest_Guy',
  );

  // to be used with medium size heading text thoughout the app
  static const TextStyle mediumHeading = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.normal,
    fontFamily: 'Luckiest_Guy',
  );
}

// * All the textstyle for texts in general
abstract class WhiteTextStyle {
  // contains textstyle for the build number in the homepage
  static const TextStyle homepageBuildText = TextStyle(
    color: AppColors.white,
    fontSize: 12,
    fontWeight: FontWeight.w200,
  );

  // to be used with small texts throughout the app
  static const TextStyle smallText = TextStyle(
      color: AppColors.white, fontSize: 16, fontWeight: FontWeight.normal);

  // to be used with medium size text thoughout the app
  static const TextStyle mediumText = TextStyle(
      color: AppColors.white, fontSize: 18, fontWeight: FontWeight.normal);
}

abstract class BlackTextStyle {
  // contains textstyle for the build number in the homepage
  static const TextStyle homepageBuildText = TextStyle(
    color: AppColors.black,
    fontSize: 12,
    fontWeight: FontWeight.w200,
  );

  // to be used with small texts throughout the app
  static const TextStyle smallText = TextStyle(
      color: AppColors.black, fontSize: 16, fontWeight: FontWeight.normal);

  // to be used with medium size text thoughout the app
  static const TextStyle mediumText = TextStyle(
      color: AppColors.black, fontSize: 18, fontWeight: FontWeight.normal);
}

abstract class RedTextStyle {
  // to be used with small texts throughout the app
  static const TextStyle smallText = TextStyle(
      color: AppColors.lightRed, fontSize: 16, fontWeight: FontWeight.bold);

  // to be used with medium size text thoughout the app
  static const TextStyle mediumText = TextStyle(
      color: AppColors.lightRed, fontSize: 18, fontWeight: FontWeight.bold);
}

// * All the textstyles for buttons in general
abstract class ButtonsTextStyle {
  // for every buttons (big) in the homepage
  static const TextStyle homepageButton = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.normal,
    fontFamily: 'Luckiest_Guy',
  );

  // for the widely used bottom back button
  static const TextStyle backButton = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.normal,
    fontFamily: 'Luckiest_Guy',
  );
}
