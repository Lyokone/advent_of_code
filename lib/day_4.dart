import 'dart:convert';

import 'dart:io';
import 'package:collection/collection.dart';

Future<BingoGame> getBoards() async {
  final file = File('input/day4.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  final bingo = BingoGame();

  int i = 0;
  await lines.forEach((element) {
    if (i == 0) {
      bingo.drawnedNumbers =
          element.split(',').map((e) => int.parse(e)).toList();
    } else {
      if (element.isEmpty) {
        bingo.boards.add(BingoBoard([]));
      } else {
        final bingoBoard = bingo.boards.last;
        bingoBoard.lines.add(element
            .split(' ')
            .where((element) => element.isNotEmpty)
            .map((e) => int.parse(e))
            .toList());
      }
    }

    i++;
  });

  bingo.boards.forEach((element) => element.generateColumns());

  return bingo;
}

class BingoGame {
  List<int> drawnedNumbers = [];
  List<BingoBoard> boards = [];

  int currentIndex = -1;
}

class BingoBoard {
  final List<List<int>> lines;
  List<List<int>> columns = [];

  BingoBoard(this.lines);

  bool newNumber(drawnedNumber) {
    for (var line in lines) {
      line.remove(drawnedNumber);
      if (line.isEmpty) {
        return true;
      }
    }
    for (var column in columns) {
      column.remove(drawnedNumber);
      if (column.isEmpty) {
        return true;
      }
    }

    return false;
  }

  void generateColumns() {
    List.generate(lines.first.length, (index) {
      columns.add(List.generate(lines.first.length, (y) => y)
          .map((e) => lines[e][index])
          .toList());
    });
  }

  int value() {
    return lines.map((e) => e.sum).sum;
  }
}

Future<void> firstPart() async {
  final bingoGame = await getBoards();

  for (int number in bingoGame.drawnedNumbers) {
    for (var board in bingoGame.boards) {
      final winning = board.newNumber(number);
      if (winning) {
        print(board.value() * number);
        return;
      }
    }
  }
}

Future<void> secondPart() async {
  final lostBingoGame = await getBoards();
  int? lastValue;

  for (int number in lostBingoGame.drawnedNumbers) {
    for (var board in [...lostBingoGame.boards]) {
      final winning = board.newNumber(number);
      if (winning) {
        lastValue = board.value() * number;
        lostBingoGame.boards.remove(board);
      }
    }
  }
  print(lastValue);
}

void main() async {
  await firstPart();
  await secondPart();
}
