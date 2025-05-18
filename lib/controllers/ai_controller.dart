import 'dart:math';
import 'package:four_in_a_row_super/models/game/game_mode.dart';
import 'package:four_in_a_row_super/models/game/game_state.dart';

/*
  This controller is reponsible for managing the AI.
*/

class AIController {
  final GameModeDifficulty difficulty;

  AIController({required this.difficulty});

  int get maxDepth => difficulty.maxDepth;

  // Main function to get the best move
  int getBestMove(GameState gameState) {
    int bestMove = -1;
    int bestScore = -999999999;
    int currentPlayer =
        gameState.currentPlayer + 1; // Adjusting for player numbering

    for (int col in getOrderOfColumns(gameState)) {
      if (isColumnPlayable(gameState, col)) {
        // Simulate the move
        GameState simulatedState = simulateMove(gameState, col, currentPlayer);

        // Run minimax
        int score = minimax(
            simulatedState, maxDepth - 1, false, -1000000000, 1000000000);

        // Choose the column with the highest score
        if (score > bestScore) {
          bestScore = score;
          bestMove = col;
        }
      }
    }

    return bestMove; // Return the best column
  }

  // Minimax
  int minimax(
      GameState state, int depth, bool isMaximizing, int alpha, int beta) {
    int currentPlayer = state.currentPlayer + 1;
    int opponent = currentPlayer == 1 ? 2 : 1;
    bool isTerminal = isTerminalNode(state);

    if (depth == 0 || isTerminal) {
      if (isTerminal) {
        if (isWinningMove(state, currentPlayer)) {
          return 1000000000; // Large positive number for a win
        } else if (isWinningMove(state, opponent)) {
          return -1000000000; // Large negative number for a loss
        } else {
          return 0; // Draw
        }
      } else {
        return evaluateBoard(state);
      }
    }

    if (isMaximizing) {
      int value = -999999999;
      for (int col in getOrderOfColumns(state)) {
        if (isColumnPlayable(state, col)) {
          GameState newState = simulateMove(state, col, currentPlayer);
          newState.currentPlayer =
              (state.currentPlayer == 0) ? 1 : 0; // Switch player
          int newScore = minimax(newState, depth - 1, false, alpha, beta);
          value = max(value, newScore);
          alpha = max(alpha, value);
          if (alpha >= beta) {
            break;
          }
        }
      }
      return value;
    } else {
      int value = 999999999;
      for (int col in getOrderOfColumns(state)) {
        if (isColumnPlayable(state, col)) {
          GameState newState = simulateMove(state, col, opponent);
          newState.currentPlayer = (state.currentPlayer == 0)
              ? 1
              : 0; // Switch back to maximizing player
          int newScore = minimax(newState, depth - 1, true, alpha, beta);
          value = min(value, newScore);
          beta = min(beta, value);
          if (alpha >= beta) {
            break;
          }
        }
      }
      return value;
    }
  }

  // Heuristic evaluation
  int evaluateBoard(GameState state) {
    int score = 0;
    int currentPlayer = state.currentPlayer + 1;

    // Score center column
    int centerColumn = state.columns ~/ 2;
    int centerCount = 0;
    for (int row = 0; row < state.rows; row++) {
      if (state.grid[row][centerColumn] == currentPlayer) {
        centerCount++;
      }
    }
    score += centerCount * 3; // Adjust weight as needed

    // Score Horizontal
    for (int row = 0; row < state.rows; row++) {
      for (int col = 0; col < state.columns - 3; col++) {
        List<int> window = state.grid[row].sublist(col, col + 4);
        score += evaluateWindow(window, currentPlayer);
      }
    }

    // Score Vertical
    for (int col = 0; col < state.columns; col++) {
      List<int> colArray = [];
      for (int row = 0; row < state.rows; row++) {
        colArray.add(state.grid[row][col]);
      }
      for (int row = 0; row < state.rows - 3; row++) {
        List<int> window = colArray.sublist(row, row + 4);
        score += evaluateWindow(window, currentPlayer);
      }
    }

    // Score positive sloped diagonal
    for (int row = 0; row < state.rows - 3; row++) {
      for (int col = 0; col < state.columns - 3; col++) {
        List<int> window = [];
        for (int i = 0; i < 4; i++) {
          window.add(state.grid[row + i][col + i]);
        }
        score += evaluateWindow(window, currentPlayer);
      }
    }

    // Score negative sloped diagonal
    for (int row = 3; row < state.rows; row++) {
      for (int col = 0; col < state.columns - 3; col++) {
        List<int> window = [];
        for (int i = 0; i < 4; i++) {
          window.add(state.grid[row - i][col + i]);
        }
        score += evaluateWindow(window, currentPlayer);
      }
    }

    return score;
  }

  // Evaluate a window of 4 cells
  int evaluateWindow(List<int> window, int player) {
    int score = 0;
    int opponent = player == 1 ? 2 : 1;

    int countPlayer = window.where((cell) => cell == player).length;
    int countOpponent = window.where((cell) => cell == opponent).length;
    int countEmpty = window.where((cell) => cell == 0).length;

    if (countPlayer == 4) {
      score += 1000; // Win condition
    } else if (countPlayer == 3 && countEmpty == 1) {
      score += 5;
    } else if (countPlayer == 2 && countEmpty == 2) {
      score += 2;
    }

    if (countOpponent == 3 && countEmpty == 1) {
      score -= 50; // Higher penalty to block opponent
    }

    return score;
  }

  // Helper function to check if a column is playable
  bool isColumnPlayable(GameState state, int col) {
    return state.grid[0][col] == 0;
  }

  // Helper function to get valid locations
  List<int> getValidLocations(GameState state) {
    List<int> validLocations = [];
    for (int col = 0; col < state.columns; col++) {
      if (isColumnPlayable(state, col)) {
        validLocations.add(col);
      }
    }
    return validLocations;
  }

  // Helper function to order columns (center to sides)
  List<int> getOrderOfColumns(GameState state) {
    int center = state.columns ~/ 2;
    List<int> columns = [];
    columns.add(center);
    for (int offset = 1; offset <= center; offset++) {
      if (center - offset >= 0) columns.add(center - offset);
      if (center + offset < state.columns) columns.add(center + offset);
    }
    return columns;
  }

  // Check if the game is over
  bool isTerminalNode(GameState state) {
    return isWinningMove(state, 1) ||
        isWinningMove(state, 2) ||
        getValidLocations(state).isEmpty;
  }

  // Check if the last move resulted in a win for the player
  bool isWinningMove(GameState state, int player) {
    List<List<int>> grid = state.grid;
    int rows = state.rows;
    int columns = state.columns;

    // Check horizontal locations for win
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns - 3; col++) {
        if (grid[row][col] == player &&
            grid[row][col + 1] == player &&
            grid[row][col + 2] == player &&
            grid[row][col + 3] == player) {
          return true;
        }
      }
    }

    // Check vertical locations for win
    for (int col = 0; col < columns; col++) {
      for (int row = 0; row < rows - 3; row++) {
        if (grid[row][col] == player &&
            grid[row + 1][col] == player &&
            grid[row + 2][col] == player &&
            grid[row + 3][col] == player) {
          return true;
        }
      }
    }

    // Check positively sloped diagonals
    for (int row = 0; row < rows - 3; row++) {
      for (int col = 0; col < columns - 3; col++) {
        if (grid[row][col] == player &&
            grid[row + 1][col + 1] == player &&
            grid[row + 2][col + 2] == player &&
            grid[row + 3][col + 3] == player) {
          return true;
        }
      }
    }

    // Check negatively sloped diagonals
    for (int row = 3; row < rows; row++) {
      for (int col = 0; col < columns - 3; col++) {
        if (grid[row][col] == player &&
            grid[row - 1][col + 1] == player &&
            grid[row - 2][col + 2] == player &&
            grid[row - 3][col + 3] == player) {
          return true;
        }
      }
    }

    return false;
  }

  // Helper function to simulate a move
  GameState simulateMove(GameState state, int col, int player) {
    GameState newState = state.clone();

    // Drop the checker in the column
    for (int row = newState.rows - 1; row >= 0; row--) {
      if (newState.grid[row][col] == 0) {
        newState.grid[row][col] = player;
        break;
      }
    }

    // Update the current player
    newState.currentPlayer = state.currentPlayer;

    return newState;
  }

  int getMaxdepth() {
    return maxDepth;
  }
}
