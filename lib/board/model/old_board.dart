import 'package:flutter/foundation.dart';

class Board {
  List<List<BoardTile>> board = List.generate(
      9, (_) => List.generate(9, (index) => BoardTile(), growable: false),
      growable: false);

  final List<List<BoardTile>> _columns =
      List.generate(9, (index) => [], growable: false);
  final List<List<BoardTile>> _boxes =
      List.generate(9, (index) => [], growable: false);

  Board({List<List<int>>? input}) {
    if (input != null) {
      board = input
          .map((e) => List.generate(9, (i) => BoardTile(num: e[i])))
          .toList();
    }
    _initColBox();
    return;
  }

  void _initColBox() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        _columns[i].add(board[j][i]);
        _boxes[_boxIndex(j, i)].add(board[i][j]);
      }
    }
  }

  bool solveBoard() {
    int loops = 0;
    while (!isSolved()) {
      print("while loop");
      loops++;
      if (!_updateAllNotes()) return false;
    }
    if (kDebugMode) {
      print("Solved after $loops iterations");
    }
    return true;
  }

  bool _updateAllNotes() {
    bool updates = false;
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (_updateNote(col, row)) updates = true;
      }
    }

    if (updates) return true;
    if (_updateNoteByElim()) updates = true;
    return updates;
  }

  bool _updateNoteByElim() {
    for (List<BoardTile> tileSet in [...board, ..._columns, ..._boxes]) {
      Set multiple = {0};
      Set once = {};
      for (BoardTile tile in tileSet) {
        if (tile.num != 0) continue;
        if (once.isEmpty) once.addAll(tile.notes);
        for (int number in tile.notes) {
          if (once.contains(number)) {
            multiple.add(number);
          } else {
            once.add(number);
          }
        }
      }
      once = once.difference(multiple);
      if (once.length == 1) {
        for (BoardTile tile in tileSet) {
          if (tile.num != 0) continue;
          if (tile.notes.contains(once.first)) {
            tile.set(once.first);
            print("Got ${tile.num}");
            return true;
          }
        }
      }
    }
    print("gg");
    return false;
  }

  bool _updateNote(int col, int row) {
    if (board[row][col].num != 0) return false;
    int prev = board[row][col].notes.length;
    Set toBeRemoved = {};
    toBeRemoved.addAll(_checkCol(col));
    toBeRemoved.addAll(_checkRow(row));
    toBeRemoved.addAll(_checkBox(col, row));
    board[row][col]
      ..notes.removeAll(toBeRemoved)
      ..check();
    if (prev == board[row][col].notes.length) return false;
    return true;
  }

  int _boxIndex(int col, int row) {
    int colIndex() {
      if (col < 3) {
        return 0;
      } else if (col < 6) {
        return 1;
      } else {
        return 2;
      }
    }

    if (row < 3) {
      return colIndex();
    } else if (row < 6) {
      return colIndex() + 3;
    } else {
      return colIndex() + 6;
    }
  }

  Set<int> _checkRow(int row) {
    Set<int> used = {for (BoardTile item in board[row]) item.num};
    return used;
  }

  Set<int> _checkCol(int col) {
    Set<int> used = {for (BoardTile item in _columns[col]) item.num};
    return used;
  }

  Set<int> _checkBox(int col, int row) {
    Set<int> used = {
      for (BoardTile item in _boxes[_boxIndex(col, row)]) item.num
    };
    return used;
  }

  bool isSolved() {
    for (List<BoardTile> row in board) {
      for (var item in row) {
        if (item.num == 0) return false;
      }
    }
    return true;
  }
}

class BoardTile {
  Set<int> notes = {};
  int num;

  BoardTile({
    this.num = 0,
  }) {
    if (num != 0) {
      notes.add(num);
      return;
    }
    notes = {1, 2, 3, 4, 5, 6, 7, 8, 9};
  }

  bool check() {
    if (num != 0) return true;

    if (notes.length == 1) {
      num = notes.first;
      return true;
    }
    return false;
  }

  bool set(int input) {
    if (num != 0) return false;
    num = input;
    return true;
  }

  @override
  String toString() {
    if (num == 0) return " ";
    return num.toString();
  }
}
