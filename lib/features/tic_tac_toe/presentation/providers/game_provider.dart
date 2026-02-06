import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/game_state.dart';
import '../controller/game_controller.dart';

/// Game controller provider
final gameControllerProvider = Provider<GameController>((ref) {
  return GameController();
});

/// Game state notifier
class GameNotifier extends StateNotifier<GameState> {
  final GameController _controller;

  GameNotifier(this._controller) : super( const GameState());

  /// Make a move at the specified index
  void makeMove(int index) {
    state = _controller.makeMove(state, index);
  }

  /// Start a new game (keep scores)
  void newGame() {
    state = _controller.resetGame(state, resetScore: false);
  }

  /// Reset everything including scores
  void resetAll() {
    state = _controller.resetGame(state, resetScore: true);
  }

  /// Get current player
  String getCurrentPlayerName() {
    return state.currentPlayer.name;
  }

  /// Check if cell is occupied
  bool isCellOccupied(int index) {
    return state.isCellOccupied(index);
  }

  /// Check if cell is part of winning line
  bool isWinningCell(int index) {
    return state.isWinningCell(index);
  }
}

/// Game state provider
final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final controller = ref.watch(gameControllerProvider);
  return GameNotifier(controller);
});

/// Current player provider
final currentPlayerProvider = Provider<String>((ref) {
  final state = ref.watch(gameProvider);
  return state.currentPlayer.name;
});

/// Game status provider
final gameStatusProvider = Provider<String>((ref) {
  final state = ref.watch(gameProvider);
  return state.statusMessage;
});

/// Is game over provider
final isGameOverProvider = Provider<bool>((ref) {
  final state = ref.watch(gameProvider);
  return state.isGameOver;
});

/// Total games provider
final totalGamesProvider = Provider<int>((ref) {
  final state = ref.watch(gameProvider);
  return state.totalGames;
});