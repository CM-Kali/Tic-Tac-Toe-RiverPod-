import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/player.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
    ])
    List<Player> board,
    @Default(Player.x) Player currentPlayer,
    Player? winner,
    @Default(false) bool isDraw,
    List<int>? winningLine,
    @Default(0) int xWins,
    @Default(0) int oWins,
    @Default(0) int draws,
  }) = _GameState;

  const GameState._();

  bool get isGameOver => winner != null || isDraw;

  bool get hasStarted => board.any((cell) => cell != Player.none);

  int get totalGames => xWins + oWins + draws;

  String get statusMessage {
    if (winner != null) {
      return winner == Player.x ? 'Player X Wins!' : 'Player O Wins!';
    } else if (isDraw) {
      return "It's a Draw!";
    } else {
      return currentPlayer == Player.x ? "Player X's Turn" : "Player O's Turn";
    }
  }

  bool isCellOccupied(int index) {
    return board[index] != Player.none;
  }

  bool isWinningCell(int index) {
    return winningLine?.contains(index) ?? false;
  }
}