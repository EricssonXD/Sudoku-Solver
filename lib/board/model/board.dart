import 'package:flutter/foundation.dart';

class Board {
  List<List<BoardItem>> board = List.generate(
      9, (_) => List.generate(9, (index) => BoardItem(), growable: false),
      growable: false);

  List<List<BoardItem>> columns =
      List.generate(9, (index) => [], growable: false);
  List<List<BoardItem>> boxes =
      List.generate(9, (index) => [], growable: false);

  Board({List<List<int>>? input}) {
    if (input != null) {
      board = input
          .map((e) => List.generate(9, (i) => BoardItem(num: e[i])))
          .toList();
    }
    initColBox();
    return;
  }

  void initColBox() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        columns[i].add(board[j][i]);
        boxes[_boxIndex(j, i)].add(board[i][j]);
      }
    }
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

  bool solveBoard() {
    int loops = 0;
    while (!isSolved()) {
      loops++;
      if (updateAllNotes()) return false;
    }
    if (kDebugMode) {
      print("Solved after $loops iterations");
    }
    return true;
  }

  bool updateAllNotes() {
    bool updates = false;
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (_updateNote(col, row)) updates = true;
      }
    }
    return updates;
  }

  bool _updateNote(int col, int row) {
    if (board[row][col].num != 0) return false;
    Set prev = board[row][col].notes;
    Set toBeRemoved = {};
    toBeRemoved.addAll(_checkCol(col));
    toBeRemoved.addAll(_checkRow(row));
    toBeRemoved.addAll(_checkBox(col, row));
    board[row][col]
      ..notes.removeAll(toBeRemoved)
      ..check();
    if (prev == board[row][col].notes) return false;
    return true;
  }

  Set<int> _checkRow(int row) {
    Set<int> used = {for (BoardItem item in board[row]) item.num};
    return used;
  }

  Set<int> _checkCol(int col) {
    Set<int> used = {for (BoardItem item in columns[col]) item.num};
    return used;
  }

  Set<int> _checkBox(int col, int row) {
    Set<int> used = {
      for (BoardItem item in boxes[_boxIndex(col, row)]) item.num
    };
    return used;
  }

  bool isSolved() {
    for (var row in board) {
      for (var item in row) {
        if (item.num == 0) return false;
      }
    }
    return true;
  }
}

class BoardItem {
  Set<int> notes = {};
  int num;

  BoardItem({
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

  @override
  String toString() {
    if (num == 0) return " ";
    return num.toString();
  }
}
