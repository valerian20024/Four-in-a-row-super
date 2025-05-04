import 'package:flutter/material.dart';

/* 
  This file defines all the colors used in the app. Those colors 
  should be the only ones to be used in the app, as to preserve
  coherence between colors throughout its utilization.
*/

abstract class AppColors {
  static const Color lightRed = Color.fromARGB(255, 241, 66, 66);
  static const Color darkRed = Color.fromARGB(255, 183, 42, 42);

  static const Color lightYellow = Color.fromARGB(255, 227, 212, 46);
  static const Color darkYellow = Color.fromARGB(255, 174, 167, 45);

  static const Color lightBlue = Color.fromARGB(255, 61, 104, 233);
  static const Color darkBlue = Color.fromARGB(255, 9, 44, 149);

  static const Color lightGreen = Color.fromARGB(255, 116, 218, 112);
  static const Color darkGreen = Color.fromARGB(255, 9, 95, 23);

  static const Color lightPurple = Color.fromARGB(255, 186, 112, 218);
  static const Color darkPurple = Color.fromARGB(255, 130, 9, 211);

  static const Color lightGrey = Color.fromARGB(255, 165, 165, 165);
  static const Color darkGrey = Color.fromARGB(255, 83, 83, 83);

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color transparent = Colors.transparent;
  static const Color transparentWhite = Color.fromARGB(98, 255, 255, 255);
  static const Color invisibleWhite = Color.fromARGB(40, 255, 255, 255);
  static const Color transparentBlack = Color.fromARGB(200, 0, 0, 0);
  static const Color invisibleBlack = Color.fromARGB(40, 0, 0, 0);
}
