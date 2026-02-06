import '../../data/models/game_state.dart';
import '../entities/player.dart';

class CheckWinner {
  static const List<List<int>> _winningCombinations = [
    [0, 1, 2], // Top row
    [3, 4, 5], // Middle row
    [6, 7, 8], // Bottom row
    [0, 3, 6], // Left column
    [1, 4, 7], // Middle column
    [2, 5, 8], // Right column
    [0, 4, 8], // Diagonal top-left to bottom-right
    [2, 4, 6], // Diagonal top-right to bottom-left
  ];

  WinnerResult call(GameState state) {
    return execute(state);
  }

  WinnerResult execute(GameState state) {
    // Check for winner
    for (final combination in _winningCombinations) {
      final a = state.board[combination[0]];
      final b = state.board[combination[1]];
      final c = state.board[combination[2]];

      if (a != Player.none && a == b && b == c) {
        return WinnerResult(
          winner: a,
          winningLine: combination,
          isGameOver: true,
        );
      }
    }

    // Check for draw
    final isDraw = state.board.every((cell) => cell != Player.none);
    if (isDraw) {
      return WinnerResult(
        isDraw: true,
        isGameOver: true,
      );
    }

    // Game is still ongoing
    return WinnerResult(
      isGameOver: false,
    );
  }

  /// Check if a move would create a winning combination
  bool wouldWin(List<Player> board, int index, Player player) {
    final testBoard = List<Player>.from(board);
    testBoard[index] = player;

    for (final combination in _winningCombinations) {
      final a = testBoard[combination[0]];
      final b = testBoard[combination[1]];
      final c = testBoard[combination[2]];

      if (a == player && a == b && b == c) {
        return true;
      }
    }

    return false;
  }
}

class WinnerResult {
  final Player? winner;
  final bool isDraw;
  final List<int>? winningLine;
  final bool isGameOver;

  WinnerResult({
    this.winner,
    this.isDraw = false,
    this.winningLine,
    required this.isGameOver,
  });

  bool get hasWinner => winner != null;
}// TODO Implement this library.