import '../../data/models/game_state.dart';
import '../../domain/entities/player.dart';
import '../../domain/usecases/check_winner.dart';
import '../../domain/usecases/reset_game.dart';

class GameController {
  final CheckWinner _checkWinner;
  final ResetGame _resetGame;

  GameController({
    CheckWinner? checkWinner,
    ResetGame? resetGame,
  })  : _checkWinner = checkWinner ?? CheckWinner(),
        _resetGame = resetGame ?? ResetGame();

  /// Make a move at the specified index
  GameState makeMove(GameState currentState, int index) {
    // Validate move
    if (!_isValidMove(currentState, index)) {
      return currentState;
    }

    // Create new board with the move
    final newBoard = List<Player>.from(currentState.board);
    newBoard[index] = currentState.currentPlayer;

    // Check for winner or draw
    final tempState = currentState.copyWith(board: newBoard);
    final winnerResult = _checkWinner.execute(tempState);

    // Handle game over
    if (winnerResult.isGameOver) {
      return _handleGameOver(currentState, newBoard, winnerResult);
    }

    // Continue game with next player
    return currentState.copyWith(
      board: newBoard,
      currentPlayer: currentState.currentPlayer.opponent,
    );
  }

  /// Reset the current game
  GameState resetGame(GameState currentState, {bool resetScore = false}) {
    return _resetGame.execute(currentState, resetScore: resetScore);
  }

  /// Check if a move is valid
  bool _isValidMove(GameState state, int index) {
    // Game must not be over
    if (state.isGameOver) return false;

    // Index must be valid
    if (index < 0 || index >= 9) return false;

    // Cell must be empty
    if (state.board[index] != Player.none) return false;

    return true;
  }

  /// Handle game over state
  GameState _handleGameOver(
      GameState currentState,
      List<Player> newBoard,
      WinnerResult winnerResult,
      ) {
    if (winnerResult.hasWinner) {
      final newXWins = winnerResult.winner == Player.x
          ? currentState.xWins + 1
          : currentState.xWins;
      final newOWins = winnerResult.winner == Player.o
          ? currentState.oWins + 1
          : currentState.oWins;

      return currentState.copyWith(
        board: newBoard,
        winner: winnerResult.winner,
        winningLine: winnerResult.winningLine,
        xWins: newXWins,
        oWins: newOWins,
      );
    } else if (winnerResult.isDraw) {
      return currentState.copyWith(
        board: newBoard,
        isDraw: true,
        draws: currentState.draws + 1,
      );
    }

    return currentState;
  }
}