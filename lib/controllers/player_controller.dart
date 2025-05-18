import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import '../models/game/player.dart';

/*
  This controller handles the player's data found in settings.
*/

class PlayerController extends ChangeNotifier {
  Player playerOne = Player(
    color: AppColors.lightYellow,
    name: 'Player 1',
  );

  Player playerTwo = Player(
    color: AppColors.lightRed,
    name: 'Player 2',
  );

  Color getPlayerColor(int id) {
    switch (id) {
      case 0:
        return (playerOne.color);
      case 1:
        return (playerTwo.color);
      default:
        throw Exception("id should be 0 or 1");
    }
  }

  Color getPlayerOneColor() {
    return getPlayerColor(0);
  }

  Color getPlayerTwoColor() {
    return getPlayerColor(1);
  }

  /*
    This method prints the color of the specified player into the terminal.
    For debugging use.
  */
  printPlayerColor() {
    debugPrint(playerOne.color.toString());
  }

  setPlayerColor(int id, Color color) {
    switch (id) {
      case 0:
        playerOne.color = color;
        break;
      case 1:
        playerTwo.color = color;
        break;
      default:
        throw Exception(
            'id should be 0 or 1'); // todo should maybe create classes for exceptions
    }
    notifyListeners();
  }

  String getPlayerName(int id) {
    switch (id) {
      case 0:
        return (playerOne.name);
      case 1:
        return (playerTwo.name);
      default:
        throw Exception("id should be 0 or 1");
    }
  }

  String getPlayerOneName() {
    return getPlayerName(0);
  }

  String getPlayerTwoName() {
    return getPlayerName(1);
  }

  void setPlayerOneName(String name) {
    playerOne.name = name;
    notifyListeners();
  }

  void setPlayerTwoName(String name) {
    playerTwo.name = name;
    notifyListeners();
  }

  void setPlayerName(int id, String name) {
    switch (id) {
      case 0:
        playerOne.name = name;
        break;
      case 1:
        playerTwo.name = name;
        break;
      default:
        throw Exception('id should be 0 or 1');
    }
    notifyListeners();
  }
}
