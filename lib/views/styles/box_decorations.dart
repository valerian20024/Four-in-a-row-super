import 'package:flutter/material.dart';
import 'app_colors.dart';

/*
  This file contains all the box decorations for diverse parts of the
  app. These decorations are extremely useful when dealing with 
  Container widgets.
*/

// Decorations for RulesView page's widgets.
abstract class RulePresentation {
  static final smallRedContainerDecoration = BoxDecoration(
      color: AppColors.lightRed,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: AppColors.darkRed,
        width: 1.5,
      ));

  static final smallYellowContainerDecoration = BoxDecoration(
      color: AppColors.lightYellow,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: AppColors.darkYellow,
        width: 1.5,
      ));

  static final ruleDescriptionBoxDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: AppColors.black,
      width: 2.0,
    ),
  );

  static final ruleExplanationBox = BoxDecoration(
    color: AppColors.darkBlue,
    borderRadius: BorderRadius.circular(30),
  );
}

abstract class WinningPopupDecoration {
  static final outer = BoxDecoration(
    color: AppColors.darkBlue,
    border: Border.all(
      color: AppColors.white,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(20),
  );
}
