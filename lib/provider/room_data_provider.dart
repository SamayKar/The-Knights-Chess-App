import 'package:flutter/material.dart';
import '../models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  bool isMoveDone = false;
  int _prev_i = -1;
  int _prev_j = -1;
  String _prev_piece = "";
  Color _prev_color = Colors.red;
  bool _isWhiteKingMoved = false;
  bool _isRightWhiteRookMoved = false;
  bool _isLeftWhiteRookMoved = false;
  bool _isBlackKingMoved = false;
  bool _isRightBlackRookMoved = false;
  bool _isLeftBlackRookMoved = false;
  bool _isWhiteTurn = true;
  bool _kingCheckCondition = false;
  bool _isBlackKingCheckExist = false;
  bool _isWhiteKingCheckExist = false;

  List<List<String>> _ChessPieceIndexes = [
    [
      'rook_B',
      'knight_B',
      'bishop_B',
      'queen_B',
      'king_B',
      'bishop_B',
      'knight_B',
      'rook_B'
    ],
    [
      'pawn_B',
      'pawn_B',
      'pawn_B',
      'pawn_B',
      'pawn_B',
      'pawn_B',
      'pawn_B',
      'pawn_B'
    ],
    ['Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty'],
    ['Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty'],
    ['Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty'],
    ['Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty', 'Empty'],
    [
      'pawn_W',
      'pawn_W',
      'pawn_W',
      'pawn_W',
      'pawn_W',
      'pawn_W',
      'pawn_W',
      'pawn_W'
    ],
    [
      'rook_W',
      'knight_W',
      'bishop_W',
      'queen_W',
      'king_W',
      'bishop_W',
      'knight_W',
      'rook_W'
    ],
  ];

  List<List<Color>> _colorindexes = [
    [
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
    ],
    [
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70
    ],
    [
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent
    ],
    [
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70
    ],
    [
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent
    ],
    [
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70
    ],
    [
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent
    ],
    [
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
      Colors.deepOrangeAccent,
      Colors.white70,
    ]
  ];

  Player _player1 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'X',
  );

  Player _player2 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'O',
  );

  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;
  List<List<String>> get ChessPieceIndexes => _ChessPieceIndexes;
  List<List<Color>> get colorindexes => _colorindexes;
  int get prev_i => _prev_i;
  int get prev_j => _prev_j;
  String get prev_piece => _prev_piece;
  Color get prev_color => _prev_color;
  bool get isWhiteKingMoved => _isWhiteKingMoved;
  bool get isRightWhiteRookMoved => _isRightWhiteRookMoved;
  bool get isLeftWhiteRookMoved => _isLeftWhiteRookMoved;
  bool get isBlackKingMoved => _isBlackKingMoved;
  bool get isRightBlackRookMoved => _isRightBlackRookMoved;
  bool get isLeftBlackRookMoved => _isLeftBlackRookMoved;
  bool get isWhiteTurn => _isWhiteTurn;
  bool get kingCheckCondition => _kingCheckCondition;
  bool get isWhiteKingCheckExist => _isWhiteKingCheckExist;
  bool get isBlackKingCheckExist => _isBlackKingCheckExist;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;

    print(_roomData);
    print('*********');
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  //______________________________________________

  bool checkforWhiteKingCheckExist() {
    bool b = false;
    if (_isWhiteTurn) {
      int pos = whiteKingPos();
      int j = pos % 10;
      int i = pos ~/ 10;

      _ChessPieceIndexes[i][j] = 'Empty';
      if (isWhiteKingChecked(i, j)) {
        b = true;
      }
      _ChessPieceIndexes[i][j] = 'king_W';
    }
    return b;
  }

  bool checkforBlackKingCheckExist() {
    bool b = false;
    if (!_isWhiteTurn) {
      int pos = blackKingPos();
      int j = pos % 10;
      int i = pos ~/ 10;

      _ChessPieceIndexes[i][j] = 'Empty';
      if (isBlackKingChecked(i, j)) {
        b = true;
      }
      _ChessPieceIndexes[i][j] = 'king_B';
    }
    return b;
  }

  bool IsValidMove(
      int _prev_i, int _prev_j, curr_i, curr_j, String chessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];
    String piece2 = _ChessPieceIndexes[curr_i][curr_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (piece1[piece1.length - 1] == piece2[piece2.length - 1]) {
      return false;
    }

    if (_isWhiteTurn && !_kingCheckCondition) {
      _isWhiteKingCheckExist = checkforWhiteKingCheckExist();
    }
    if (!_isWhiteTurn && !_kingCheckCondition) {
      _isBlackKingCheckExist = checkforBlackKingCheckExist();
    }

    if ((chessPiece == 'king_B' || chessPiece == 'king_W') &&
        !_kingCheckCondition) {
      if (chessPiece == 'king_W') {
        _ChessPieceIndexes[_prev_i][_prev_j] = 'Empty';
        _ChessPieceIndexes[curr_i][curr_j] = 'Empty';
        if (isWhiteKingChecked(curr_i, curr_j)) {
          _ChessPieceIndexes[curr_i][curr_j] = piece2;
          _ChessPieceIndexes[_prev_i][_prev_j] = 'king_W';
          return false;
        }
        _ChessPieceIndexes[_prev_i][_prev_j] = 'king_W';
        _ChessPieceIndexes[curr_i][curr_j] = piece2;
      }
      if (chessPiece == 'king_B') {
        _ChessPieceIndexes[_prev_i][_prev_j] = 'Empty';
        _ChessPieceIndexes[curr_i][curr_j] = 'Empty';
        if (isBlackKingChecked(
          curr_i,
          curr_j,
        )) {
          _ChessPieceIndexes[curr_i][curr_j] = piece2;
          _ChessPieceIndexes[_prev_i][_prev_j] = 'king_B';
          return false;
        }
        _ChessPieceIndexes[curr_i][curr_j] = piece2;
        _ChessPieceIndexes[_prev_i][_prev_j] = 'king_B';
      }
      if (((curr_j - _prev_j).abs() <= 1) && ((curr_i - _prev_i).abs() <= 1)) {
        return true;
      }
    }

    if (chessPiece == 'bishop_B' || chessPiece == 'bishop_W') {
      if ((curr_j - _prev_j == curr_i - _prev_i) ||
          (curr_j + curr_i == _prev_j + _prev_i)) {
        if (curr_j + curr_i == _prev_j + _prev_i) {
          if (_prev_i < curr_i) {
            int temp = _prev_i;
            _prev_i = curr_i;
            curr_i = temp;
            temp = _prev_j;
            _prev_j = curr_j;
            curr_j = temp;
          }
          for (int i = _prev_i - 1, j = _prev_j + 1;
              i >= curr_i + 1;
              i--, j++) {
            if (_ChessPieceIndexes[i][j] != 'Empty') {
              return false;
            }
          }
          return true;
        } else {
          if (_prev_i > curr_i) {
            int temp = _prev_i;
            _prev_i = curr_i;
            curr_i = temp;
            temp = _prev_j;
            _prev_j = curr_j;
            curr_j = temp;
          }
          for (int i = _prev_i + 1, j = _prev_j + 1;
              i <= curr_i - 1;
              i++, j++) {
            if (_ChessPieceIndexes[i][j] != 'Empty') {
              return false;
            }
          }
          return true;
        }
      }
    }

    if (chessPiece == 'knight_B' || chessPiece == 'knight_W') {
      if (((curr_j - _prev_j).abs() >= 1) &&
          ((curr_i - _prev_i).abs() >= 1) &&
          ((curr_j - _prev_j).abs() + (curr_i - _prev_i).abs() == 3)) {
        return true;
      }
    }
    if (chessPiece == 'pawn_B') {
      if (_prev_i == 1 &&
          curr_i == 3 &&
          _prev_j == curr_j &&
          !_kingCheckCondition) {
        if (piece2 != 'Empty') {
          return false;
        }
        if (_prev_i > curr_i) {
          if (_ChessPieceIndexes[_prev_i - 1][_prev_j] != 'Empty') {
            return false;
          }
        } else {
          if (_ChessPieceIndexes[_prev_i + 1][_prev_j] != 'Empty') {
            return false;
          }
        }
        return true;
      }
      if ((curr_i - _prev_i == 1) &&
          _prev_j == curr_j &&
          !_kingCheckCondition) {
        if (piece2 != 'Empty') {
          return false;
        }
        return true;
      }
      if ((piece2[piece2.length - 1] == 'W' || _kingCheckCondition) &&
          (curr_j == _prev_j + 1 || curr_j == _prev_j - 1) &&
          curr_i == _prev_i + 1) {
        return true;
      }
    }
    if (chessPiece == 'pawn_W') {
      if ((_prev_i == 6 &&
          curr_i == 4 &&
          _prev_j == curr_j &&
          !_kingCheckCondition)) {
        if (piece2 != 'Empty') {
          return false;
        }
        if (_prev_i > curr_i) {
          if (_ChessPieceIndexes[_prev_i - 1][_prev_j] != 'Empty') {
            return false;
          }
        } else {
          if (_ChessPieceIndexes[_prev_i + 1][_prev_j] != 'Empty') {
            return false;
          }
        }
        return true;
      }
      if ((_prev_i - curr_i == 1) &&
          _prev_j == curr_j &&
          !_kingCheckCondition) {
        if (piece2 != 'Empty') {
          return false;
        }
        return true;
      }
      if ((piece2[piece2.length - 1] == 'B' || _kingCheckCondition) &&
          (curr_j == _prev_j - 1 || curr_j == _prev_j + 1) &&
          curr_i == _prev_i - 1) {
        return true;
      }
    }
    if (chessPiece == 'rook_B' || chessPiece == 'rook_W') {
      if ((_prev_j == curr_j) || (_prev_i == curr_i)) {
        if (_prev_j == curr_j) {
          if (_prev_i > curr_i) {
            int temp = _prev_i;
            _prev_i = curr_i;
            curr_i = temp;
          }
          for (int i = _prev_i + 1; i <= curr_i - 1; i++) {
            if (_ChessPieceIndexes[i][_prev_j] != 'Empty') {
              return false;
            }
          }
        }
        if (_prev_i == curr_i) {
          if (_prev_j > curr_j) {
            int temp = _prev_j;
            _prev_j = curr_j;
            curr_j = temp;
          }
          for (int j = _prev_j + 1; j <= curr_j - 1; j++) {
            if (_ChessPieceIndexes[_prev_i][j] != 'Empty') {
              return false;
            }
          }
        }
        return true;
      }
    }
    if (chessPiece == 'queen_B' || chessPiece == 'queen_W') {
      if ((curr_j - _prev_j == curr_i - _prev_i) ||
          (curr_j + curr_i == _prev_j + _prev_i)) {
        if (curr_j + curr_i == _prev_j + _prev_i) {
          if (_prev_i < curr_i) {
            int temp = _prev_i;
            _prev_i = curr_i;
            curr_i = temp;
            temp = _prev_j;
            _prev_j = curr_j;
            curr_j = temp;
          }
          for (int i = _prev_i - 1, j = _prev_j + 1;
              i >= curr_i + 1;
              i--, j++) {
            if (_ChessPieceIndexes[i][j] != 'Empty') {
              return false;
            }
          }
          return true;
        }
        if (curr_j - _prev_j == curr_i - _prev_i) {
          if (_prev_i > curr_i) {
            int temp = _prev_i;
            _prev_i = curr_i;
            curr_i = temp;
            temp = _prev_j;
            _prev_j = curr_j;
            curr_j = temp;
          }
          for (int i = _prev_i + 1, j = _prev_j + 1;
              i <= curr_i - 1;
              i++, j++) {
            if (_ChessPieceIndexes[i][j] != 'Empty') {
              return false;
            }
          }
          return true;
        }
      }
      if ((_prev_j == curr_j) || (_prev_i == curr_i)) {
        if (_prev_j == curr_j) {
          if (_prev_i > curr_i) {
            int temp = _prev_i;
            _prev_i = curr_i;
            curr_i = temp;
          }
          for (int i = _prev_i + 1; i <= curr_i - 1; i++) {
            if (_ChessPieceIndexes[i][_prev_j] != 'Empty') {
              return false;
            }
          }
        }
        if (_prev_i == curr_i) {
          if (_prev_j > curr_j) {
            int temp = _prev_j;
            _prev_j = curr_j;
            curr_j = temp;
          }
          for (int j = _prev_j + 1; j <= curr_j - 1; j++) {
            if (_ChessPieceIndexes[_prev_i][j] != 'Empty') {
              return false;
            }
          }
        }
        return true;
      }
    }

    return false;
  }

  bool isWhiteShortCastlePossible(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isWhiteKingMoved == false &&
        _isRightWhiteRookMoved == false &&
        ChessPiece == 'king_W' &&
        i == 7 &&
        j == 6 &&
        _ChessPieceIndexes[7][5] == 'Empty' &&
        _ChessPieceIndexes[7][6] == 'Empty') {
      _ChessPieceIndexes[7][4] = 'Empty';
      _ChessPieceIndexes[7][7] = 'Empty';
      if (!isWhiteKingChecked(7, 4) &&
          !isWhiteKingChecked(7, 5) &&
          !isWhiteKingChecked(7, 6) &&
          !isWhiteKingChecked(7, 7)) {
        _ChessPieceIndexes[7][4] = 'king_W';
        _ChessPieceIndexes[7][7] = 'rook_W';
        return true;
      }
      _ChessPieceIndexes[7][4] = 'king_W';
      _ChessPieceIndexes[7][7] = 'rook_W';
    }
    return false;
  }

  bool WhiteShortCastle(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isWhiteKingMoved == false &&
        _isRightWhiteRookMoved == false &&
        ChessPiece == 'king_W' &&
        i == 7 &&
        j == 6 &&
        _ChessPieceIndexes[7][5] == 'Empty' &&
        _ChessPieceIndexes[7][6] == 'Empty') {
      _ChessPieceIndexes[7][4] = 'Empty';
      _ChessPieceIndexes[7][7] = 'Empty';
      if (!isWhiteKingChecked(7, 4) &&
          !isWhiteKingChecked(7, 5) &&
          !isWhiteKingChecked(7, 6) &&
          !isWhiteKingChecked(7, 7)) {
        _isWhiteKingMoved = true;
        _isRightWhiteRookMoved == true;
        return true;
      }
      _ChessPieceIndexes[7][4] = 'king_W';
      _ChessPieceIndexes[7][7] = 'rook_W';
    }
    return false;
  }

  bool isWhiteLongCastlePossible(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isWhiteKingMoved == false &&
        _isLeftWhiteRookMoved == false &&
        ChessPiece == 'king_W' &&
        i == 7 &&
        j == 2 &&
        _ChessPieceIndexes[7][1] == 'Empty' &&
        _ChessPieceIndexes[7][2] == 'Empty' &&
        _ChessPieceIndexes[7][3] == 'Empty') {
      _ChessPieceIndexes[7][0] = 'Empty';
      _ChessPieceIndexes[7][4] = 'Empty';
      if (!isWhiteKingChecked(7, 0) &&
          !isWhiteKingChecked(7, 1) &&
          !isWhiteKingChecked(7, 2) &&
          !isWhiteKingChecked(7, 3) &&
          !isWhiteKingChecked(7, 4)) {
        _ChessPieceIndexes[7][4] = 'king_W';
        _ChessPieceIndexes[7][0] = 'rook_W';
        return true;
      }
      _ChessPieceIndexes[7][4] = 'king_W';
      _ChessPieceIndexes[7][0] = 'rook_W';
    }
    return false;
  }

  bool WhiteLongCastle(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isWhiteKingMoved == false &&
        _isLeftWhiteRookMoved == false &&
        ChessPiece == 'king_W' &&
        i == 7 &&
        j == 2 &&
        _ChessPieceIndexes[7][1] == 'Empty' &&
        _ChessPieceIndexes[7][2] == 'Empty' &&
        _ChessPieceIndexes[7][3] == 'Empty') {
      _ChessPieceIndexes[7][0] = 'Empty';
      _ChessPieceIndexes[7][4] = 'Empty';
      if (!isWhiteKingChecked(7, 0) &&
          !isWhiteKingChecked(7, 1) &&
          !isWhiteKingChecked(7, 2) &&
          !isWhiteKingChecked(7, 3) &&
          !isWhiteKingChecked(7, 4)) {
        _isWhiteKingMoved = true;
        _isLeftWhiteRookMoved == true;
        return true;
      }
      _ChessPieceIndexes[7][4] = 'king_W';
      _ChessPieceIndexes[7][0] = 'rook_W';
    }
    return false;
  }

  bool isBlackLongCastlePossible(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isBlackKingMoved == false &&
        _isLeftBlackRookMoved == false &&
        ChessPiece == 'king_B' &&
        i == 0 &&
        j == 2 &&
        _ChessPieceIndexes[0][1] == 'Empty' &&
        _ChessPieceIndexes[0][2] == 'Empty' &&
        _ChessPieceIndexes[0][3] == 'Empty') {
      _ChessPieceIndexes[0][0] = 'Empty';
      _ChessPieceIndexes[0][4] = 'Empty';
      if (!isBlackKingChecked(0, 0) &&
          !isBlackKingChecked(0, 1) &&
          !isBlackKingChecked(0, 2) &&
          !isBlackKingChecked(0, 3) &&
          !isBlackKingChecked(
            0,
            4,
          )) {
        _ChessPieceIndexes[0][4] = 'king_B';
        _ChessPieceIndexes[0][0] = 'rook_B';
        return true;
      }
      _ChessPieceIndexes[0][4] = 'king_B';
      _ChessPieceIndexes[0][0] = 'rook_B';
    }
    return false;
  }

  bool BlackLongCastle(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isBlackKingMoved == false &&
        _isLeftBlackRookMoved == false &&
        ChessPiece == 'king_B' &&
        i == 0 &&
        j == 2 &&
        _ChessPieceIndexes[0][1] == 'Empty' &&
        _ChessPieceIndexes[0][2] == 'Empty' &&
        _ChessPieceIndexes[0][3] == 'Empty') {
      _ChessPieceIndexes[0][0] = 'Empty';
      _ChessPieceIndexes[0][4] = 'Empty';
      if (!isBlackKingChecked(0, 0) &&
          !isBlackKingChecked(0, 1) &&
          !isBlackKingChecked(0, 2) &&
          !isBlackKingChecked(0, 3) &&
          !isBlackKingChecked(
            0,
            4,
          )) {
        _isBlackKingMoved = true;
        _isLeftBlackRookMoved == true;
        return true;
      }
      _ChessPieceIndexes[0][4] = 'king_B';
      _ChessPieceIndexes[0][0] = 'rook_B';
    }
    return false;
  }

  bool isBlackShortCastlePossible(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isBlackKingMoved == false &&
        _isRightBlackRookMoved == false &&
        ChessPiece == 'king_B' &&
        i == 0 &&
        j == 6 &&
        _ChessPieceIndexes[0][5] == 'Empty' &&
        _ChessPieceIndexes[0][6] == 'Empty') {
      _ChessPieceIndexes[0][7] = 'Empty';
      _ChessPieceIndexes[0][4] = 'Empty';
      if (!isBlackKingChecked(0, 4) &&
          !isBlackKingChecked(0, 5) &&
          !isBlackKingChecked(0, 6) &&
          !isBlackKingChecked(
            0,
            7,
          )) {
        _ChessPieceIndexes[0][7] = 'rook_B';
        _ChessPieceIndexes[0][4] = 'king_B';
        return true;
      }
      _ChessPieceIndexes[0][4] = 'king_B';
      _ChessPieceIndexes[0][7] = 'rook_B';
    }
    return false;
  }

  bool BlackShortCastle(
      int _prev_i, int _prev_j, int i, int j, String ChessPiece) {
    String piece1 = _ChessPieceIndexes[_prev_i][_prev_j];

    if (_isWhiteTurn && piece1[piece1.length - 1] == 'B') {
      return false;
    }
    if (!_isWhiteTurn && piece1[piece1.length - 1] == 'W') {
      return false;
    }

    if (_isBlackKingMoved == false &&
        _isRightBlackRookMoved == false &&
        ChessPiece == 'king_B' &&
        i == 0 &&
        j == 6 &&
        _ChessPieceIndexes[0][5] == 'Empty' &&
        _ChessPieceIndexes[0][6] == 'Empty') {
      _ChessPieceIndexes[0][7] = 'Empty';
      _ChessPieceIndexes[0][4] = 'Empty';
      if (!isBlackKingChecked(0, 4) &&
          !isBlackKingChecked(0, 5) &&
          !isBlackKingChecked(0, 6) &&
          !isBlackKingChecked(
            0,
            7,
          )) {
        _isBlackKingMoved = true;
        _isRightBlackRookMoved == true;
        return true;
      }
      _ChessPieceIndexes[0][4] = 'king_B';
      _ChessPieceIndexes[0][7] = 'rook_B';
    }
    return false;
  }

  int whiteKingPos() //returns white king position in 10i+j form
  {
    for (int i = 0; i <= 7; i++) {
      for (int j = 0; j <= 7; j++) {
        if (_ChessPieceIndexes[i][j] == 'king_W') {
          return 10 * i + j;
        }
      }
    }
    return 0;
  }

  int blackKingPos() //returns black king position in 10i+j form
  {
    for (int i = 0; i <= 7; i++) {
      for (int j = 0; j <= 7; j++) {
        if (_ChessPieceIndexes[i][j] == 'king_B') {
          return 10 * i + j;
        }
      }
    }
    return 0;
  }

  bool isWhiteKingChecked(int i, int j) // is white king checked at position i,j
  {
    _kingCheckCondition = true;
    for (int x = 0; x <= 7; x++) {
      for (int y = 0; y <= 7; y++) {
        String ChessPiece = _ChessPieceIndexes[x][y];
        if (ChessPiece[ChessPiece.length - 1] == 'B') {
          _isWhiteTurn = !_isWhiteTurn;
          if (IsValidMove(
            x,
            y,
            i,
            j,
            ChessPiece,
          )) {
            _isWhiteTurn = !_isWhiteTurn;
            _kingCheckCondition = false;
            return true;
          }
          _isWhiteTurn = !_isWhiteTurn;
        }
      }
    }
    _kingCheckCondition = false;
    return false;
  }

  bool isBlackKingChecked(int i, int j) // is white king checked at position i,j
  {
    _kingCheckCondition = true;
    for (int x = 0; x <= 7; x++) {
      for (int y = 0; y <= 7; y++) {
        String ChessPiece = _ChessPieceIndexes[x][y];
        if (ChessPiece[ChessPiece.length - 1] == 'W') {
          _isWhiteTurn = !_isWhiteTurn;
          if (IsValidMove(
            x,
            y,
            i,
            j,
            ChessPiece,
          )) {
            _isWhiteTurn = !_isWhiteTurn;
            _kingCheckCondition = false;
            return true;
          }
          _isWhiteTurn = !_isWhiteTurn;
        }
      }
    }
    _kingCheckCondition = false;
    return false;
  }

  bool isWhiteCheckmate() {
    if (!checkforWhiteKingCheckExist()) {
      return false;
    }
    for (int i1 = 0; i1 < 8; i1++) {
      for (int j1 = 0; j1 < 8; j1++) {
        String piece1 = _ChessPieceIndexes[i1][j1];
        if (piece1[piece1.length - 1] == 'W') {
          for (int i2 = 0; i2 < 8; i2++) {
            for (int j2 = 0; j2 < 8; j2++) {
              String piece2 = _ChessPieceIndexes[i2][j2];
              if (IsValidMove(
                i1,
                j1,
                i2,
                j2,
                _ChessPieceIndexes[i1][j1],
              )) {
                _ChessPieceIndexes[i1][j1] = 'Empty';
                _ChessPieceIndexes[i2][j2] = piece1;
                if (checkforWhiteKingCheckExist() == false) {
                  _ChessPieceIndexes[i1][j1] = piece1;
                  _ChessPieceIndexes[i2][j2] = piece2;
                  return false;
                }
                _ChessPieceIndexes[i1][j1] = piece1;
                _ChessPieceIndexes[i2][j2] = piece2;
              }
            }
          }
        }
      }
    }
    return true;
  }

  bool isBlackCheckmate() {
    if (!checkforBlackKingCheckExist()) {
      return false;
    }

    for (int i1 = 0; i1 < 8; i1++) {
      for (int j1 = 0; j1 < 8; j1++) {
        String piece1 = _ChessPieceIndexes[i1][j1];
        if (piece1[piece1.length - 1] == 'B') {
          for (int i2 = 0; i2 < 8; i2++) {
            for (int j2 = 0; j2 < 8; j2++) {
              String piece2 = _ChessPieceIndexes[i2][j2];
              if (IsValidMove(
                i1,
                j1,
                i2,
                j2,
                _ChessPieceIndexes[i1][j1],
              )) {
                _ChessPieceIndexes[i1][j1] = 'Empty';
                _ChessPieceIndexes[i2][j2] = piece1;
                if (checkforBlackKingCheckExist() == false) {
                  _ChessPieceIndexes[i1][j1] = piece1;
                  _ChessPieceIndexes[i2][j2] = piece2;
                  return false;
                }
                _ChessPieceIndexes[i1][j1] = piece1;
                _ChessPieceIndexes[i2][j2] = piece2;
              }
            }
          }
        }
      }
    }
    return true;
  }

  bool isNoWhiteMovesPossible() //game draw
  {
    for (int i1 = 0; i1 < 8; i1++) {
      for (int j1 = 0; j1 < 8; j1++) {
        String piece1 = _ChessPieceIndexes[i1][j1];
        if (piece1[piece1.length - 1] == 'W') {
          for (int i2 = 0; i2 < 8; i2++) {
            for (int j2 = 0; j2 < 8; j2++) {
              if (IsValidMove(
                i1,
                j1,
                i2,
                j2,
                _ChessPieceIndexes[i1][j1],
              )) {
                return false;
              }
            }
          }
        }
      }
    }
    return true;
  }

  bool isNoBlackMovesPossible() //game draw
  {
    for (int i1 = 0; i1 < 8; i1++) {
      for (int j1 = 0; j1 < 8; j1++) {
        String piece1 = _ChessPieceIndexes[i1][j1];
        if (piece1[piece1.length - 1] == 'B') {
          for (int i2 = 0; i2 < 8; i2++) {
            for (int j2 = 0; j2 < 8; j2++) {
              if (IsValidMove(i1, j1, i2, j2, _ChessPieceIndexes[i1][j1])) {
                return false;
              }
            }
          }
        }
      }
    }
    return true;
  }

  void showGameDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Thanks for Playing'),
            ),
          ],
        );
      },
    );
  }

  bool IsValidMoveCheck(int previ, int prevj, int i, int j, String prevPiece) {
    if (isBlackShortCastlePossible(previ, prevj, i, j, prevPiece)) {
      print('true a');
      return true;
    }
    if (isBlackLongCastlePossible(previ, prevj, i, j, prevPiece)) {
      print('true b');
      return true;
    }
    if (isWhiteShortCastlePossible(previ, prevj, i, j, prevPiece)) {
      print('true c');
      return true;
    }
    if (isWhiteShortCastlePossible(previ, prevj, i, j, prevPiece)) {
      print('true d');
      return true;
    }

    if (IsValidMove(previ, prevj, i, j, prevPiece)) {
      String temp = _ChessPieceIndexes[i][j];
      _ChessPieceIndexes[i][j] = prevPiece;
      _ChessPieceIndexes[previ][prevj] = 'Empty';

      if (checkforBlackKingCheckExist() || checkforWhiteKingCheckExist()) {
        _ChessPieceIndexes[previ][prevj] = prevPiece;
        _ChessPieceIndexes[i][j] = temp;
        print('false e');
        return false;
      }

      _ChessPieceIndexes[previ][prevj] = prevPiece;
      _ChessPieceIndexes[i][j] = temp;
      print('true f');
      return true;
    }

    print('false g');
    return false;
  }

  //__________________________________________

  void updateDisplayElements(int index, BuildContext context) {
    int i = index ~/ 8;
    int j = index % 8;

    Color color = _colorindexes[i][j];
    String chessPiece = _ChessPieceIndexes[i][j];

    //__________________________________________

    if (_prev_i == -1 && chessPiece == 'Empty') {
    } else if (_prev_i == -1) {
      _prev_i = i;
      _prev_j = j;
      _prev_piece = chessPiece;
      _prev_color = color;
      _colorindexes[i][j] = Colors.deepOrange[700]!;
    } else if (_prev_i == i && _prev_j == j) {
      _prev_i = -1;
      _colorindexes[i][j] = _prev_color;
    } else if (WhiteShortCastle(_prev_i, _prev_j, i, j, _prev_piece)) {
      _colorindexes[7][4] = Colors.deepOrangeAccent;
      _colorindexes[7][7] = Colors.white70;
      _colorindexes[7][6] = Colors.deepOrangeAccent;
      _colorindexes[7][7] = Colors.white70;
      _ChessPieceIndexes[7][4] = 'Empty';
      _ChessPieceIndexes[7][5] = 'rook_W';
      _ChessPieceIndexes[7][6] = 'king_W';
      _ChessPieceIndexes[7][7] = 'Empty';
      _isWhiteTurn = !_isWhiteTurn;
      _prev_i = -1;
    } else if (WhiteLongCastle(_prev_i, _prev_j, i, j, _prev_piece)) {
      _colorindexes[7][0] = Colors.deepOrangeAccent;
      _colorindexes[7][2] = Colors.deepOrangeAccent;
      _colorindexes[7][3] = Colors.white70;
      _colorindexes[7][4] = Colors.deepOrangeAccent;
      _ChessPieceIndexes[7][0] = 'Empty';
      _ChessPieceIndexes[7][2] = 'king_W';
      _ChessPieceIndexes[7][3] = 'rook_W';
      _ChessPieceIndexes[7][4] = 'Empty';
      _isWhiteTurn = !_isWhiteTurn;
      _prev_i = -1;
    } else if (BlackShortCastle(_prev_i, _prev_j, i, j, _prev_piece)) {
      _colorindexes[0][4] = Colors.white70;
      _colorindexes[0][7] = Colors.deepOrangeAccent;
      _colorindexes[0][6] = Colors.white70;
      _colorindexes[0][5] = Colors.deepOrangeAccent;
      _ChessPieceIndexes[0][4] = 'Empty';
      _ChessPieceIndexes[0][5] = 'rook_B';
      _ChessPieceIndexes[0][6] = 'king_B';
      _ChessPieceIndexes[0][7] = 'Empty';
      _isWhiteTurn = !_isWhiteTurn;
      _prev_i = -1;
    } else if (BlackLongCastle(_prev_i, _prev_j, i, j, _prev_piece)) {
      _colorindexes[0][0] = Colors.white70;
      _colorindexes[0][2] = Colors.white70;
      _colorindexes[0][3] = Colors.deepOrangeAccent;
      _colorindexes[0][4] = Colors.white70;
      _ChessPieceIndexes[0][0] = 'Empty';
      _ChessPieceIndexes[0][2] = 'king_B';
      _ChessPieceIndexes[0][3] = 'rook_B';
      _ChessPieceIndexes[0][4] = 'Empty';
      _isWhiteTurn = !_isWhiteTurn;
      _prev_i = -1;
    } else if (IsValidMove(_prev_i, _prev_j, i, j, _prev_piece)) {
      _colorindexes[_prev_i][_prev_j] = _prev_color;
      _colorindexes[i][j] = color;

      String temp = _ChessPieceIndexes[i][j];
      _ChessPieceIndexes[i][j] = _prev_piece;
      _ChessPieceIndexes[_prev_i][_prev_j] = 'Empty';

      if (_prev_piece == 'pawn_W' && i == 0) {
        _ChessPieceIndexes[i][j] = 'queen_W';
        _colorindexes[i][j] = color;
      }
      if (_prev_piece == 'pawn_B' && i == 7) {
        _ChessPieceIndexes[i][j] = 'queen_B';
        _colorindexes[i][j] = color;
      }

      _isWhiteTurn = !_isWhiteTurn;

      if (_isWhiteTurn && checkforWhiteKingCheckExist()) {
        if (isWhiteCheckmate()) {
          showGameDialog(context, 'Black won by Checkmate!');
        }
      }

      if (!_isWhiteTurn && checkforBlackKingCheckExist()) {
        if (isBlackCheckmate()) {
          showGameDialog(context, 'White won by Checkmate!');
        }
      }

      _isWhiteTurn = !_isWhiteTurn;

      if (checkforBlackKingCheckExist() || checkforWhiteKingCheckExist()) {
        _ChessPieceIndexes[_prev_i][_prev_j] = _prev_piece;
        _colorindexes[_prev_i][_prev_j] = _prev_color;
        _ChessPieceIndexes[i][j] = temp;
        _colorindexes[i][j] = color;

        _prev_i = -1;
      } else {
        if (_prev_piece == 'king_W') {
          _isWhiteKingMoved = true;
        }
        if (_prev_piece == 'king_B') {
          _isBlackKingMoved = true;
        }
        if (_prev_piece == 'rook_B' && _prev_i == 0 && _prev_j == 7) {
          _isRightBlackRookMoved = true;
        }
        if (_prev_piece == 'rook_B' && _prev_i == 0 && _prev_j == 0) {
          _isLeftBlackRookMoved = true;
        }
        if (_prev_piece == 'rook_W' && _prev_i == 7 && _prev_j == 7) {
          _isRightWhiteRookMoved = true;
        }
        if (_prev_piece == 'rook_W' && _prev_i == 7 && _prev_j == 0) {
          _isLeftWhiteRookMoved = true;
        }

        _isWhiteTurn = !_isWhiteTurn;
        _prev_i = -1;

        if (!_isWhiteTurn) {}
        if (_isWhiteTurn) {}

        if ((!_isWhiteTurn && isNoBlackMovesPossible()) ||
            (_isWhiteTurn && isNoWhiteMovesPossible())) {
          showGameDialog(context, 'Game Draw by Stalemate!');
        }
      }
    } else {
      _ChessPieceIndexes[_prev_i][_prev_j] = _prev_piece;
      _colorindexes[_prev_i][_prev_j] = _prev_color;
      _prev_i = -1;
    }

    // ____________________________________________
    notifyListeners();
  }
}
