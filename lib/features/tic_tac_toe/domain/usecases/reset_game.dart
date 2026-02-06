import '../../data/models/game_state.dart';
import '../entities/player.dart';

class ResetGame {
  GameState call(GameState currentState, {bool resetScore = false}) {
    return execute(currentState, resetScore: resetScore);
  }

  GameState execute(GameState currentState, {bool resetScore = false}) {
    if (resetScore) {
      return const GameState(
        board: [
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
        currentPlayer: Player.x,
        winner: null,
        isDraw: false,
        winningLine: null,
        xWins: 0,
        oWins: 0,
        draws: 0,
      );
    }

    return currentState.copyWith(
      board: const [
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
      ],
      currentPlayer: Player.x,
      winner: null,
      isDraw: false,
      winningLine: null,
    );
  }
}