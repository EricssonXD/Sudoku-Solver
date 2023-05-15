// ignore_for_file: avoid_print
import 'board_sample.dart';
import 'package:sudoku_solver/board/model/board.dart';

void main() {
  Board board = Board(input: BoardSample.sample1);
  board.solveBoard();
  // for (var rows in board.board) {
  //   for (var i in rows) {
  //     print(i.notes);
  //   }
  // }
  printBoard(board);
}

void printBoard(Board b) {
  for (var i in b.board) {
    print(i);
  }
}
