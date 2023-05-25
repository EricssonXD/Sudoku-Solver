class Board {
  final List<BoardTile> _board =
      List.generate(81, (_) => BoardTile(), growable: false);
  late final List<List<BoardTile>> _rows;
  late final List<List<BoardTile>> _columns;
  late final List<List<BoardTile>> _boxes;

  Board({List<List<int>>? input}) {
    _initGroupTiles();
    int index = 0;
    for (List<int> row in input!) {
      for (int num in row) {
        _board[index].set(num);
        index++;
      }
    }
  }

  /// Returns **`True`** if successfully solved the board and **`False`** if otherwise
  bool solveBoard() {
    bool traceBack(int index) {
      // Check if its the end of the board
      if (index == 81) return true;
      // Check if the current index already has a value, skip if it already has a value
      BoardTile tile = _board[index];
      if (tile.isZero) {
        return traceBack(index + 1);
      }
      // Update the notes of the current Index
      Set<int> invalidNums = {};
      for (BoardTile item in [
        ..._rows[tile.row],
        ..._columns[tile.col],
        ..._boxes[tile.box]
      ]) {
        invalidNums.add(item.num);
      }
      // Try out the notes
      for (int i in tile.notes.difference(invalidNums)) {
        tile.num = i;
        if (traceBack(index + 1)) return true;
        tile.num = 0; // Reset
      }
      return false;
    }

    fillNotes();
    return traceBack(0);
  }

  void _initGroupTiles() {
    _rows = List.generate(
        9,
        (rowIndex) => List.generate(9, (i) {
              return _board[i + rowIndex * 9]..row = rowIndex;
            }, growable: false),
        growable: false);

    _columns = List.generate(
        9,
        (colIndex) => List.generate(9, (i) {
              return _board[i * 9 + colIndex]..col = colIndex;
            }, growable: false),
        growable: false);

    _boxes = List.generate(
        9,
        (boxIndex) => List.generate(9, (i) {
              return _board[9 * (i ~/ 3) +
                  i % 3 +
                  3 * (boxIndex % 3) +
                  27 * (boxIndex ~/ 3)]
                ..box = boxIndex;
            }, growable: false),
        growable: false);
  }

  void fillNotes() {
    for (List<BoardTile> list in [..._rows, ..._columns, ..._boxes]) {
      Set alreadyExists = {};
      for (BoardTile tile in list) {
        if (!tile.isZero) continue;
        alreadyExists.add(tile.num);
      }
      for (BoardTile tile in list) {
        if (tile.isZero) continue;
        tile.notes.removeAll(alreadyExists);
      }
    }
  }

  @override
  String toString() {
    int index = 0;
    String string = "";
    for (BoardTile tile in _board) {
      if (index == 9) {
        index = 0;
        string = "$string\n";
      }
      string = "$string$tile  ";
      index++;
    }
    return string;
  }
}

class BoardTile {
  Set<int> notes = {};
  int num;
  int col = -1;
  int row = -1;
  int box = -1;

  BoardTile({
    this.num = 0,
  }) {
    if (num != 0) {
      notes.add(num);
      return;
    }
    notes = {1, 2, 3, 4, 5, 6, 7, 8, 9};
  }

  bool get isZero => (num != 0);

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
