enum Player {
  x,
  o,
  none;

  String get symbol {
    switch (this) {
      case Player.x:
        return 'X';
      case Player.o:
        return 'O';
      case Player.none:
        return '';
    }
  }

  String get name {
    switch (this) {
      case Player.x:
        return 'Player X';
      case Player.o:
        return 'Player O';
      case Player.none:
        return 'None';
    }
  }

  Player get opponent {
    switch (this) {
      case Player.x:
        return Player.o;
      case Player.o:
        return Player.x;
      case Player.none:
        return Player.none;
    }
  }

  bool get isValid => this != Player.none;
}