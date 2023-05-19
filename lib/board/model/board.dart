class Board {
  final List<BoardTile> _board =
      List.generate(81, (_) => BoardTile(), growable: false);
  final List<List<BoardTile>> _rows =
      List.generate(9, (index) => [], growable: false);
  final List<List<BoardTile>> _columns =
      List.generate(9, (index) => [], growable: false);
  final List<List<BoardTile>> _boxes =
      List.generate(9, (index) => [], growable: false);

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
      // Check if the current index already has a value
      BoardTile tile = _board[index];
      if (tile.solved) {
        return traceBack(index + 1);
      }
      // Update the notes of the current Index
      Set<int> alreadyExists = {};
      for (BoardTile item in [
        ..._rows[tile.row],
        ..._columns[tile.col],
        ..._boxes[tile.box]
      ]) {
        alreadyExists.add(item.num);
      }
      // Try out the notes
      for (int i in tile.notes.difference(alreadyExists)) {
        tile.num = i;
        if (traceBack(index + 1)) return true;
        tile.num = 0;
      }
      // print("Cant Find at $index\nNotes: ${tile.notes}\nExist:$alreadyExists");
      return false;
    }

    fillNotes();
    return traceBack(0);
  }

  void _initGroupTiles() {
    int rowIdx = 0;
    int colIdx = 0;
    int boxIdx = 0;
    for (BoardTile tile in _board) {
      if (colIdx == 9) {
        rowIdx++;
        colIdx = 0;
      }
      boxIdx = colIdx ~/ 3 + 3 * (rowIdx ~/ 3);
      tile.row = rowIdx;
      tile.col = colIdx;
      tile.box = boxIdx;
      _rows[rowIdx].add(tile);
      _columns[colIdx].add(tile);
      _boxes[boxIdx].add(tile);
      colIdx++;
    }
  }

  void fillNotes() {
    for (List<BoardTile> list in [..._rows, ..._columns, ..._boxes]) {
      Set alreadyExists = {};
      for (BoardTile tile in list) {
        if (!tile.solved) continue;
        alreadyExists.add(tile.num);
      }
      for (BoardTile tile in list) {
        if (tile.solved) continue;
        tile.notes.removeAll(alreadyExists);
        // tile.check();
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

  bool get solved => (num != 0);

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
