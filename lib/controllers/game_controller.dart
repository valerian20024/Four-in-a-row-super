import 'dart:math';
import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import 'package:four_in_a_row_super/models/rules/gravity_direction_rule.dart';
import '../models/game/game_state.dart';
import 'package:four_in_a_row_super/controllers/ai_controller.dart';
import 'package:four_in_a_row_super/models/game/game_mode.dart';

/*
  This controller handles the state of the game being played. It communicates with
  the UI via setters and getters and mofifies its underlying GameState object.
  This controller also communicates with Scenario Controller to obtain informations
  aboutthe current game's settings (such as grid size for example).
*/
class GameController extends ChangeNotifier {
  ScenarioController scenarioController;
  late GameState gameState;
  late AIController aiController;
  double winningAnimationPosition;
  static const winningAnimationStartPosition = 900.0; // the very bottom
  static const winningAnimationEndPosition = 400.0; // up
  bool switchPlayerAllowed = true;
  bool isAImove = false;

  GameMode _gameMode = GameMode.local;
  GameModeDifficulty _difficulty = GameModeDifficulty.easy;

  GameMode get gameMode => _gameMode;
  GameModeDifficulty get difficulty => _difficulty;

  void setGameMode(GameMode mode) {
    if (_gameMode != mode) {
      _gameMode = mode;
      notifyListeners();
    }
  }

  void setDifficulty(GameModeDifficulty diff) {
    if (_difficulty != diff) {
      _difficulty = diff;
      aiController = AIController(difficulty: _difficulty);
      notifyListeners();
    }
  }

  GameController({
    required this.scenarioController,
    this.winningAnimationPosition = winningAnimationStartPosition,
  }) {
    gameState = GameState(scenarioController: scenarioController, call: true);
    aiController = AIController(difficulty: _difficulty);
  }

  double getAnimationPosition() {
    return winningAnimationPosition;
  }

  /*
    This method gets triggered when a player realizes an action.
    It analyzes context to understand what kind of action to take, e.g.
    place a checker, place a bomb, use a power up.
  */
  void placeSomething(String side, int index) {
    if (gameState.isGameOver) return;

    int player = gameState.currentPlayer;
    int p1powerupSelection = gameState.playerOneSelectedPowerUp;
    int p2powerupSelection = gameState.playerTwoSelectedPowerUp;

    // no power up is selected
    if ((player == 0 && p1powerupSelection == -1) ||
        (player == 1 && p2powerupSelection == -1)) {
      placeChecker(side, index);
    } else {
      int powerup = player == 0
          ? gameState.playerOnePowerUps[p1powerupSelection]
          : gameState.playerTwoPowerUps[p2powerupSelection];

      // if it's a blank power up
      if (powerup == -1) {
        placeChecker(side, index);
      }

      // if it's a bomb
      if (powerup == 0) {
        placeBomb(side, index);
        deselectPowerUp(player);
        consumerPowerUp(
            player, player == 0 ? p1powerupSelection : p2powerupSelection);
      }

      // if it's play twice
      if (powerup == 1) {
        _disallowSwitchingPlayers();
        placeChecker(side, index);
        consumerPowerUp(
            player, player == 0 ? p1powerupSelection : p2powerupSelection);
        deselectPowerUp(getCurrentPlayer());
      }
    }

    countScores(gameState.grid);
    updateGameOverState();
  }

  /*
    This method will find the first empty cell to place something to.
    Direction : from left to right.
    It can either place a bomb (and trigger the corresponding logic) or
    a checker, and thus fill the empty space with it.
  */
  void placeLeft(int rowIndex, int checker, bool bomb) {
    int last = gameState.grid[0].length - 1;
    int first = -1;

    for (int columnIndex = first; columnIndex <= last; columnIndex++) {
      // if rowIndex is at the bottom, we color
      if (columnIndex == last) {
        if (bomb) {
          // ! bomb
          _explode(rowIndex, columnIndex);
        } else {
          gameState.grid[rowIndex][columnIndex] = checker;
        }
        break;
      } else {
        // if next one is empty we loop again
        if (gameState.grid[rowIndex][columnIndex + 1] == 0) {
          continue;
        } else {
          // if at the beginning of the grid, can't add more checkers
          if (columnIndex == first) {
            // ! bomb
            if (bomb) {
              _explode(rowIndex, columnIndex);
            } else {
              _disallowSwitchingPlayers(); // forbids changing player
            }
            return;
          } else {
            if (bomb) {
              // ! bomb
              _explode(rowIndex, columnIndex);
            } else {
              gameState.grid[rowIndex][columnIndex] = checker;
            }
            break;
          }
        }
      }
    }
  }

  /*
    This method will find the first empty cell to place something to.
    Direction : from right to left.
    It can either place a bomb (and trigger the corresponding logic) or
    a checker, and thus fill the empty space with it.
  */
  void placeRight(int rowIndex, int checker, bool bomb) {
    int last = 0;
    int first = gameState.grid[0].length;

    for (int columnIndex = first; columnIndex >= last; columnIndex--) {
      // if rowIndex is at the bottom, we color
      if (columnIndex == last) {
        if (bomb) {
          // ! bomb
          _explode(rowIndex, columnIndex);
        } else {
          gameState.grid[rowIndex][columnIndex] = checker;
        }
        break;
      } else {
        // if next one is empty we loop again
        if (gameState.grid[rowIndex][columnIndex - 1] == 0) {
          continue;
        } else {
          // if at the beginning of the grid, can't add more checkers
          if (columnIndex == first) {
            // ! bomb
            if (bomb) {
              _explode(rowIndex, columnIndex);
            } else {
              _disallowSwitchingPlayers(); // forbids changing player
            }
            return;
          } else {
            if (bomb) {
              // ! bomb
              _explode(rowIndex, columnIndex);
            } else {
              gameState.grid[rowIndex][columnIndex] = checker;
            }
            break;
          }
        }
      }
    }
  }

  /*
    This method will find the first empty cell to place something to.
    Direction : from top to bottom.
    It can either place a bomb (and trigger the corresponding logic) or
    a checker, and thus fill the empty space with it.
  */
  void placeUp(int columnIndex, int checker, bool bomb) {
    int last = gameState.grid.length - 1;
    int first = -1;

    for (int rowIndex = first; rowIndex <= last; rowIndex++) {
      // if rowIndex is at the bottom, we color
      if (rowIndex == last) {
        if (bomb) {
          // ! bomb
          _explode(rowIndex, columnIndex);
        } else {
          gameState.grid[rowIndex][columnIndex] = checker;
        }
        break;
      } else {
        // if next one is empty we loop again
        if (gameState.grid[rowIndex + 1][columnIndex] == 0) {
          continue;
        } else {
          // if at the beginning of the grid, can't add more checkers
          if (rowIndex == first) {
            // ! bomb
            if (bomb) {
              _explode(rowIndex, columnIndex);
            } else {
              _disallowSwitchingPlayers(); // forbids changing player
            }
            return;
          } else {
            if (bomb) {
              // ! bomb
              _explode(rowIndex, columnIndex);
            } else {
              gameState.grid[rowIndex][columnIndex] = checker;
            }
            break;
          }
        }
      }
    }
  }

  /*
    This method will find the first empty cell to place something to.
    Direction : from bottom to up.
    It can either place a bomb (and trigger the corresponding logic) or
    a checker, and thus fill the empty space with it.
  */
  void placeDown(int columnIndex, int checker, bool bomb) {
    int last = 0;
    int first = gameState.grid.length;

    for (int rowIndex = first; rowIndex >= last; rowIndex--) {
      // if rowIndex is at the bottom, we color
      if (rowIndex == last) {
        if (bomb) {
          // ! bomb
          _explode(rowIndex, columnIndex);
        } else {
          gameState.grid[rowIndex][columnIndex] = checker;
        }
        break;
      } else {
        // if next one is empty we loop again
        if (gameState.grid[rowIndex - 1][columnIndex] == 0) {
          continue;
        } else {
          // if at the beginning of the grid, can't add more checkers
          if (rowIndex == first) {
            // ! bomb
            if (bomb) {
              _explode(rowIndex, columnIndex);
            } else {
              _disallowSwitchingPlayers(); // forbid changing player
            }
            return;
          } else {
            if (bomb) {
              // ! bomb
              _explode(rowIndex, columnIndex);
            } else {
              gameState.grid[rowIndex][columnIndex] = checker;
            }
            break;
          }
        }
      }
    }
  }

  /*
    This method handles the logic for triggering the right
    placing function and passing it the required data from the context.
  */
  void placeChecker(String side, int index) {
    int playerCheckerType = gameState.currentPlayer == 0 ? 1 : 2;

    switch (side) {
      case 'left':
        placeLeft(index, playerCheckerType, false);
        break;
      case 'right':
        placeRight(index, playerCheckerType, false);
        break;
      case 'up':
        placeUp(index, playerCheckerType, false);
        break;
      case 'down':
        placeDown(index, playerCheckerType, false);
        break;
      default:
        throw Exception('Cannot have another side than left, right, up, down');
    }
    switchPlayer();
    if (gameMode == GameMode.ai && gameState.currentPlayer == 0 && !gameState.isGameOver) {
      isAImove = false; 
      notifyListeners();
    }
    _allowSwitchingPlayers();
    notifyListeners();
  }

  /*
    This method will erase a 3 x 3 grid around the bomb being placed.
  */
  void _explode(int row, int col) {
    for (int i = row - 1; i <= row + 1; i++) {
      for (int j = col - 1; j <= col + 1; j++) {
        if (i >= 0 &&
            i < gameState.grid.length &&
            j >= 0 &&
            j < gameState.grid[0].length) {
          gameState.grid[i][j] = 0;
        }
      }
    }
    notifyListeners();
  }

  /*
    This method handles the logic for triggering the right
    placing function and passing it the required data from the context.
  */
  void placeBomb(String side, int index) {
    switch (side) {
      case 'left':
        placeLeft(index, 1, true); // mock using 1 as checker type
        break;
      case 'right':
        placeRight(index, 1, true);
        break;
      case 'up':
        placeUp(index, 1, true);
        break;
      case 'down':
        placeDown(index, 1, true);
        break;
      default:
        throw Exception('Cannot have another side than left, right, up, down');
    }

    // gravityfy all the checkers if gravity type is trivial (i.e. normal)
    GravityDirectionRule gravity = scenarioController.getGravityType();
    if (gravity.isNormal()) {
      for (int i = index - 1; i < index + 2; i++) {
        // only for the columns that are inside the grid
        if (i > 0 && i < gameState.grid[0].length) {
          _gravityfy(i, gameState.grid);
        }
      }
    }

    switchPlayer();
    deselectPowerUp(getCurrentPlayer());
    notifyListeners();
  }

  /*
    This method removes the power up that's been used by the current player.
  */
  void consumerPowerUp(int player, int id) {
    if (player == 0) {
      gameState.playerOnePowerUps[id] = -1;
    }
    if (player == 1) {
      gameState.playerTwoPowerUps[id] = -1;
    }
  }

  /*
    Sets a flag that allows to switch players.
  */
  void _allowSwitchingPlayers() {
    switchPlayerAllowed = true;
    notifyListeners();
  }

  /*
    Sets a flag that disallows switching players.
  */
  void _disallowSwitchingPlayers() {
    switchPlayerAllowed = false;
    notifyListeners();
  }

  /*
    This method counts the number of checkers placed as
    four in a row. It counts for both players at the same time.
    Updates the variables of the gamestate.
  */
  void countScores(List<List<int>> ll) {
    int scoreP1 = 0;
    int scoreP2 = 0;

    int nbcols = ll[0].length;
    int nbrows = ll.length;

    // HORIZONTAL PASS
    for (int i = 0; i < nbrows; i++) {
      // for each line
      int counter = 0;
      int type = 1;

      for (int j = 0; j < nbcols; j++) {
        // for each col
        if (ll[i][j] == 0) {
          counter = 0;
        }
        if (ll[i][j] == type) {
          counter++;
        }
        if (ll[i][j] != type) {
          counter = 1;
          type = ll[i][j];
        }

        if (counter == 4) {
          if (type == 1) {
            scoreP1++;
          }
          if (type == 2) {
            scoreP2++;
          }
          counter = 0;
        }
      }
    }

    // VERTICAL PASS
    for (int j = 0; j < nbcols; j++) {
      // for each column
      int counter = 0;
      int type = 1;

      for (int i = 0; i < nbrows; i++) {
        // for each line
        if (ll[i][j] == 0) {
          counter = 0;
        }
        if (ll[i][j] == type) {
          counter++;
        }
        if (ll[i][j] != type) {
          counter = 1;
          type = ll[i][j];
        }

        if (counter == 4) {
          if (type == 1) {
            scoreP1++;
          }
          if (type == 2) {
            scoreP2++;
          }

          counter = 0;
        }
      }
    }

    // DOWN-RIGHT PASS
    for (int row = 0; row < nbrows - 3; row++) {
      for (int col = 0; col < nbcols - 3; col++) {
        int type = ll[row][col];
        if (type != 0 &&
            type == ll[row + 1][col + 1] &&
            type == ll[row + 2][col + 2] &&
            type == ll[row + 3][col + 3]) {
          if (type == 1) scoreP1++;
          if (type == 2) scoreP2++;
        }
      }
    }

    // DOWN-LEFT PASS
    for (int row = 0; row < nbrows - 3; row++) {
      for (int col = 3; col < nbcols; col++) {
        int type = ll[row][col];
        if (type != 0 &&
            type == ll[row + 1][col - 1] &&
            type == ll[row + 2][col - 2] &&
            type == ll[row + 3][col - 3]) {
          if (type == 1) scoreP1++;
          if (type == 2) scoreP2++;
        }
      }
    }
    gameState.playerOneScore = scoreP1;
    gameState.playerTwoScore = scoreP2;
    notifyListeners();
  }

  /*
    This method implements an algorithm that makes all the checkers in a specifed
    column 'fall'. It is used in the popout version and when a bomb explodes.
  */
  void _gravityfy(int column, List<List<int>> grid) {
    int rows = grid.length;

    // analyze what checkers are placed in the column
    List<int> checkers = [];
    for (int i = 0; i < rows; i++) {
      if (grid[i][column] == 0) {
      } else {
        checkers.add(grid[i][column]);
      }
    }

    // creates [0, 0, ... , checkers left]
    int length = checkers.length;
    List<int> zeros = List.filled(rows - length, 0);
    List<int> newcol = zeros + checkers;

    // replace with new values
    for (int i = 0; i < rows; i++) {
      grid[i][column] = newcol[i];
    }
  }

  /*
    This method gets triggered when a player want to pop a checker out of the grid.
    It thus removes the last checker.
  */
  void popout(int columnIndex) {
    if (gameState.isGameOver) {
      return;
    }
    int rowIndex = scenarioController.getCurrentGridSize()[0] - 1;
    gameState.grid[rowIndex][columnIndex] = 0;
    _gravityfy(columnIndex, gameState.grid);
    switchPlayer();
    notifyListeners();
  }

  /*
    Checks if the game is over and updates the gameState variable.
  */
  void updateGameOverState() {
    if (gameState.playerOneScore >= gameState.pointsToScore ||
        gameState.playerTwoScore >= gameState.pointsToScore) {
      gameState.winner =
          gameState.playerOneScore > gameState.playerTwoScore ? 0 : 1;
      notifyListeners();
      pokeWinningAnimation();
      gameState.isGameOver = true;
    } else {
      gameState.isGameOver = false;
    }
    notifyListeners();
  }

  int getWinner() {
    return gameState.winner;
  }

  int getPowerUpId(int player, int id) {
    if (player == 0) {
      return gameState.playerOnePowerUps[id];
    }
    if (player == 1) {
      return gameState.playerTwoPowerUps[id];
    }
    throw Exception("getPowerUpId: There is no such player");
  }

  int getSelectedPowerUp(int player) {
    if (player == 0) {
      return gameState.playerOneSelectedPowerUp;
    }
    if (player == 1) {
      return gameState.playerTwoSelectedPowerUp;
    } else {
      throw Exception("getSelectedPowerUp: There is no such player");
    }
  }

  /*
    This method allocates a given power up to a free space
    in the relevant player's inventory.
  */
  _givePlayerPowerUp(int powerup, int player) {
    if (player == 0) {
      for (int i = 0; i < gameState.playerOnePowerUps.length; i++) {
        if (gameState.playerOnePowerUps[i] == -1) {
          gameState.playerOnePowerUps[i] = powerup;
          break;
        }
      }
    }
    if (player == 1) {
      for (int i = 0; i < gameState.playerTwoPowerUps.length; i++) {
        if (gameState.playerTwoPowerUps[i] == -1) {
          gameState.playerTwoPowerUps[i] = powerup;
          break;
        }
      }
    }
  }

  /*
    This method gives a random power up from the set of available
    power ups (depending on the rules) to a player.
  */
  _giveRandomPowerUp() {
    int randomPlayer = Random().nextInt(2);
    List<int> possiblePowerups = [];
    if (scenarioController.isBombRuleActive()) {
      possiblePowerups.add(0);
    }
    if (scenarioController.isPlayTwiceRuleActive()) {
      possiblePowerups.add(1);
    }
    if (possiblePowerups.isEmpty) {
      return;
    }

    int randomPowerUp =
        possiblePowerups[Random().nextInt(possiblePowerups.length)];

    _givePlayerPowerUp(randomPowerUp, randomPlayer);
  }

  /* 
    This method increments the round number and triggers
    the power up claim logic.
  */
  void _incrementRound() {
    gameState.round += 1;
    if (gameState.round % 5 == 0) {
      _giveRandomPowerUp();
    }
    notifyListeners();
  }

  /*
    This method switches player after checking all the conditions
    are met.
  */
  void switchPlayer() {
    if (switchPlayerAllowed) {
      gameState.currentPlayer = gameState.currentPlayer == 0 ? 1 : 0;
      _incrementRound();
    }

    if (gameMode == GameMode.ai && gameState.currentPlayer == 1) {
      isAImove = true;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 500), () {
        if (!gameState.isGameOver) {
          playAImove();
        }
      });
    } else {
      isAImove = false;
      notifyListeners();
    }

    notifyListeners();
  }


  int getCurrentPlayer() {
    return gameState.currentPlayer;
  }

  void setCurrentPlayer(int value) {
    gameState.currentPlayer = value;
  }

  void setRandomCurrentPlayer() {
    setCurrentPlayer(Random().nextInt(2));
  }

  void setPointToScoreToOne() {
    gameState.pointsToScore = 1;
    notifyListeners();
  }

  bool isPlayerOneTurn() {
    return getCurrentPlayer() == 0;
  }

  bool isPlayerTwoTurn() {
    return getCurrentPlayer() == 1;
  }

  /*
    This method gets called by the UI when a power up 
    is selected. It updates the according state in the gamestate
    and handles the logic for every press on the power up button.
  */
  void selectPowerUp(int id, int player) {
    if (player == 0) {
      if (gameState.playerOneSelectedPowerUp == id) {
        deselectPowerUp(player);
      } else {
        gameState.playerOneSelectedPowerUp = id;
      }
    }
    if (player == 1) {
      if (gameState.playerTwoSelectedPowerUp == id) {
        deselectPowerUp(player);
      } else {
        gameState.playerTwoSelectedPowerUp = id;
      }
    }
    notifyListeners();
  }

  /*
    This method makes the player deselect power up.
  */
  void deselectPowerUp(int player) {
    if (player == 0) {
      gameState.playerOneSelectedPowerUp = -1;
    }
    if (player == 1) {
      gameState.playerTwoSelectedPowerUp = -1;
    }
    notifyListeners();
  }

  int getRoundNumber() {
    return gameState.round;
  }

  /*
    This method removes the animation of winning when resetting
    a game.
  */
  void hideWinningAnimation() {
    winningAnimationPosition = winningAnimationStartPosition;
    notifyListeners();
  }

  /*
    This method launches the animation of winning when a player
    wins.
  */
  void pokeWinningAnimation() {
    winningAnimationPosition = winningAnimationEndPosition;
    notifyListeners();
  }

  /*
    Helper method to reset the grid.
  */
  void _resetGrid() {
    gameState.grid = List.generate(scenarioController.getCurrentGridSize()[0],
        (index) => List.filled(scenarioController.getCurrentGridSize()[1], 0));
  }

  /*
    This method resets a game.
  */
  void resetGame() {
    _resetGrid();
    gameState.currentPlayer = 0;
    gameState.isGameOver = false;
    gameState.playerOneScore = 0;
    gameState.playerTwoScore = 0;
    gameState.playerOneSelectedPowerUp = -1;
    gameState.playerTwoSelectedPowerUp = -1;
    gameState.playerOnePowerUps = List.filled(2, -1);
    gameState.playerTwoPowerUps = List.filled(2, -1);
    gameState.round = 0;

    hideWinningAnimation();
    notifyListeners();
  }

  /*
    This method places a checker by the AI. 
  */
  void playAImove() {
    int bestMove = aiController.getBestMove(gameState);
    placeSomething('up', bestMove);
  }

  void updatePointScoring() {
    gameState.pointsToScore = scenarioController.getPointsToScore();
  }

  int getP1score() {
    return gameState.playerOneScore;
  }

  int getP2score() {
    return gameState.playerTwoScore;
  }

  int getPointsToScore() {
    return gameState.pointsToScore;
  }
}
