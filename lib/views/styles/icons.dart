import 'package:flutter/material.dart';
import 'app_colors.dart';

/*
  This file will contain all the icons used in the app.
*/

abstract class AppIcons {
  //static const Icon optionsWheel = Color.fromARGB(255, 241, 66, 66);
  static const double arrowSize = 28.0;

  static const Icon arrowDownward = Icon(Icons.arrow_downward,
      size: arrowSize, color: AppColors.transparentWhite);

  static const Icon arrowUpward = Icon(Icons.arrow_upward,
      size: arrowSize, color: AppColors.transparentWhite);

  static const Icon arrowLeftward = Icon(Icons.arrow_back,
      size: arrowSize, color: AppColors.transparentWhite);

  static const Icon arrowRightward = Icon(Icons.arrow_forward,
      size: arrowSize, color: AppColors.transparentWhite);

  static const Icon popout = Icon(Icons.system_update_alt,
      size: arrowSize, color: AppColors.transparentWhite);
}
