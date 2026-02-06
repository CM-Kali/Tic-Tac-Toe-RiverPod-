// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  List<Player> get board => throw _privateConstructorUsedError;
  Player get currentPlayer => throw _privateConstructorUsedError;
  Player? get winner => throw _privateConstructorUsedError;
  bool get isDraw => throw _privateConstructorUsedError;
  List<int>? get winningLine => throw _privateConstructorUsedError;
  int get xWins => throw _privateConstructorUsedError;
  int get oWins => throw _privateConstructorUsedError;
  int get draws => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {List<Player> board,
      Player currentPlayer,
      Player? winner,
      bool isDraw,
      List<int>? winningLine,
      int xWins,
      int oWins,
      int draws});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPlayer = null,
    Object? winner = freezed,
    Object? isDraw = null,
    Object? winningLine = freezed,
    Object? xWins = null,
    Object? oWins = null,
    Object? draws = null,
  }) {
    return _then(_value.copyWith(
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      currentPlayer: null == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Player?,
      isDraw: null == isDraw
          ? _value.isDraw
          : isDraw // ignore: cast_nullable_to_non_nullable
              as bool,
      winningLine: freezed == winningLine
          ? _value.winningLine
          : winningLine // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      xWins: null == xWins
          ? _value.xWins
          : xWins // ignore: cast_nullable_to_non_nullable
              as int,
      oWins: null == oWins
          ? _value.oWins
          : oWins // ignore: cast_nullable_to_non_nullable
              as int,
      draws: null == draws
          ? _value.draws
          : draws // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Player> board,
      Player currentPlayer,
      Player? winner,
      bool isDraw,
      List<int>? winningLine,
      int xWins,
      int oWins,
      int draws});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPlayer = null,
    Object? winner = freezed,
    Object? isDraw = null,
    Object? winningLine = freezed,
    Object? xWins = null,
    Object? oWins = null,
    Object? draws = null,
  }) {
    return _then(_$GameStateImpl(
      board: null == board
          ? _value._board
          : board // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      currentPlayer: null == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Player?,
      isDraw: null == isDraw
          ? _value.isDraw
          : isDraw // ignore: cast_nullable_to_non_nullable
              as bool,
      winningLine: freezed == winningLine
          ? _value._winningLine
          : winningLine // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      xWins: null == xWins
          ? _value.xWins
          : xWins // ignore: cast_nullable_to_non_nullable
              as int,
      oWins: null == oWins
          ? _value.oWins
          : oWins // ignore: cast_nullable_to_non_nullable
              as int,
      draws: null == draws
          ? _value.draws
          : draws // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GameStateImpl extends _GameState {
  const _$GameStateImpl(
      {final List<Player> board = const [
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none
      ],
      this.currentPlayer = Player.x,
      this.winner,
      this.isDraw = false,
      final List<int>? winningLine,
      this.xWins = 0,
      this.oWins = 0,
      this.draws = 0})
      : _board = board,
        _winningLine = winningLine,
        super._();

  final List<Player> _board;
  @override
  @JsonKey()
  List<Player> get board {
    if (_board is EqualUnmodifiableListView) return _board;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_board);
  }

  @override
  @JsonKey()
  final Player currentPlayer;
  @override
  final Player? winner;
  @override
  @JsonKey()
  final bool isDraw;
  final List<int>? _winningLine;
  @override
  List<int>? get winningLine {
    final value = _winningLine;
    if (value == null) return null;
    if (_winningLine is EqualUnmodifiableListView) return _winningLine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int xWins;
  @override
  @JsonKey()
  final int oWins;
  @override
  @JsonKey()
  final int draws;

  @override
  String toString() {
    return 'GameState(board: $board, currentPlayer: $currentPlayer, winner: $winner, isDraw: $isDraw, winningLine: $winningLine, xWins: $xWins, oWins: $oWins, draws: $draws)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            const DeepCollectionEquality().equals(other._board, _board) &&
            (identical(other.currentPlayer, currentPlayer) ||
                other.currentPlayer == currentPlayer) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.isDraw, isDraw) || other.isDraw == isDraw) &&
            const DeepCollectionEquality()
                .equals(other._winningLine, _winningLine) &&
            (identical(other.xWins, xWins) || other.xWins == xWins) &&
            (identical(other.oWins, oWins) || other.oWins == oWins) &&
            (identical(other.draws, draws) || other.draws == draws));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_board),
      currentPlayer,
      winner,
      isDraw,
      const DeepCollectionEquality().hash(_winningLine),
      xWins,
      oWins,
      draws);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {final List<Player> board,
      final Player currentPlayer,
      final Player? winner,
      final bool isDraw,
      final List<int>? winningLine,
      final int xWins,
      final int oWins,
      final int draws}) = _$GameStateImpl;
  const _GameState._() : super._();

  @override
  List<Player> get board;
  @override
  Player get currentPlayer;
  @override
  Player? get winner;
  @override
  bool get isDraw;
  @override
  List<int>? get winningLine;
  @override
  int get xWins;
  @override
  int get oWins;
  @override
  int get draws;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
