enum GameMode {
  ai, // Player vs AI
  local, // Local multiplayer
  online, // Online multiplayer
}

enum GameModeDifficulty {
  easy,
  intermediate,
  hard,
}

extension GameModeDifficultyExtension on GameModeDifficulty {
  int get maxDepth {
    switch (this) {
      case GameModeDifficulty.easy:
        return 3;
      case GameModeDifficulty.intermediate:
        return 5;
      case GameModeDifficulty.hard:
        return 7;
    }
  }
}
