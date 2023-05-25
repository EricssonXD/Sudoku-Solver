// ignore_for_file: avoid_print

import 'board_sample.dart';
import 'package:sudoku_solver/board/model/board.dart';

void main() {
  timeFunction(() {
    Board board = Board(input: BoardSample.sample2);
    if (board.solveBoard()) {
      print("Solved!");
    } else {
      print("f");
    }
    print(board);
  });
}

void timeFunction(Function fun) {
  Stopwatch stopwatch = Stopwatch()..start();
  fun();
  print('Function executed in ${stopwatch.elapsed}');
}
