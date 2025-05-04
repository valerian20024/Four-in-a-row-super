import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/controllers/player_controller.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:provider/provider.dart';

/*
  This widget will render the player's turn and name, using adequate controllers.
  It will be build when the win condition rule is set such that there are no points
  in the game but instead, the first to place four checkers in the row wins.
*/
class PlayerTurnPanel extends StatelessWidget {
  final int player; // the player represented by this widget

  const PlayerTurnPanel({super.key, required this.player});

  Function _isPlayerTurn(GameController gameController, int player) {
    switch (player) {
      case 0:
        return gameController.isPlayerOneTurn;
      case 1:
        return gameController.isPlayerTwoTurn;
      default:
        throw Exception('player id should be equal to 0 or 1');
    }
  }

  Function _getPlayerColor(PlayerController playerController, int player) {
    switch (player) {
      case 0:
        return playerController.getPlayerOneColor;
      case 1:
        return playerController.getPlayerTwoColor;
      default:
        throw Exception('player id should be equal to 0 or 1');
    }
  }

  String _getText(PlayerController playerController, int player) {
    switch (player) {
      case 0:
        return playerController.getPlayerOneName();
      case 1:
        return playerController.getPlayerTwoName();
      default:
        throw Exception('player id should be equal to 0 or 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController =
        Provider.of<PlayerController>(context);
    final GameController gameController = Provider.of<GameController>(context);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: (Container(
        decoration: BoxDecoration(
          color: _isPlayerTurn(gameController, player)()
              ? Colors.white
              : Colors.transparent,
          border: Border.all(
            color: _isPlayerTurn(gameController, player)()
                ? Colors.white
                : Colors.transparent,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _getPlayerColor(playerController, player)(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                _getText(playerController, player),
                style: WhiteTextStyle.smallText,
              ),
            ),
          ),
        ),
      )),
    );
  }
}

/*
  This widget is used in the PointsGameboardUpperBar to display information about the player.
  Hence, its name, color (both from playerController) and points (from gamecontroller).
*/
class PlayerScorePanel extends PlayerTurnPanel {
  const PlayerScorePanel({super.key, required super.player});

  String _getScoreText(GameController gc, int player) {
    switch (player) {
      case 0:
        return "${gc.getP1score()} / ${gc.getPointsToScore()} points";
      case 1:
        return "${gc.getP2score()} / ${gc.getPointsToScore()} points";
      default:
        throw Exception('player id should be equal to 0 or 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController =
        Provider.of<PlayerController>(context);
    final GameController gameController = Provider.of<GameController>(context);

    return (Container(
      decoration: BoxDecoration(
        color: _isPlayerTurn(gameController, player)()
            ? Colors.white
            : Colors.transparent,
        border: Border.all(
          color: _isPlayerTurn(gameController, player)()
              ? Colors.white
              : Colors.transparent,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          //width: 120,
          //height: 65,
          decoration: BoxDecoration(
            color: _getPlayerColor(playerController, player)(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getText(playerController, player),
                    style: WhiteTextStyle.smallText,
                  ),
                  Text(
                    _getScoreText(gameController, player),
                    style: WhiteTextStyle.mediumText,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
