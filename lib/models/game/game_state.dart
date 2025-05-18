import 'package:four_in_a_row_super/controllers/scenario_controller.dart';

/*
  This class contains all the information of the game.
*/

class GameState {
  late int columns;
  late int rows;
  late List<List<int>> grid;

  late int currentPlayer;
  late bool isGameOver;

  late List<int> playerOnePowerUps; // -1 : no one, 0 : bomb, 1 : play twice
  late List<int> playerTwoPowerUps;
  late int playerOneSelectedPowerUp; // -1 : no one, 0 : first, 1 : second
  late int playerTwoSelectedPowerUp;
  late int playerOneScore;
  late int playerTwoScore;
  late int pointsToScore;
  late int winner;
  late int round;
  bool call;

  ScenarioController scenarioController;

  GameState({
    required this.scenarioController,
    required this.call,
  }) {
    List<int> sizes = call ? scenarioController.getCurrentGridSize() : [6, 7];
    columns = sizes[1];
    rows = sizes[0];
    grid = List.generate(rows, (index) => List.filled(columns, 0));

    currentPlayer = 0;
    isGameOver = false;

    playerOnePowerUps = [0, 0];
    playerTwoPowerUps = [0, 0];

    playerOneSelectedPowerUp = -1;
    playerTwoSelectedPowerUp = -1;

    playerOneScore = 0;
    playerTwoScore = 0;
    pointsToScore = call ? scenarioController.getPointsToScore() : 1;

    round = 0;

    winner = 0;
  }

  GameState clone() {
    GameState newState =
        GameState(scenarioController: scenarioController, call: false);
    newState.columns = columns;
    newState.rows = rows;
    newState.grid = List.generate(rows, (i) => List.from(grid[i]));
    newState.currentPlayer = currentPlayer;
    newState.isGameOver = isGameOver;

    return newState;
  }
}
