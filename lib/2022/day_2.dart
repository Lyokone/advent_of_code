import 'package:advent_of_code/utils/base_class.dart';
import 'package:collection/collection.dart';

class BaseElement {
  static int numberOfPoints(BaseElement a, BaseElement b) {
    if (a is Rock && b is Paper) {
      return 0;
    } else if (a is Rock && b is Scissors) {
      return 6;
    } else if (a is Paper && b is Rock) {
      return 6;
    } else if (a is Paper && b is Scissors) {
      return 0;
    } else if (a is Scissors && b is Rock) {
      return 0;
    } else if (a is Scissors && b is Paper) {
      return 6;
    } else {
      return 3;
    }
  }

  loosingElements() {
    if (this is Rock) {
      return Paper();
    } else if (this is Paper) {
      return Scissors();
    } else {
      return Rock();
    }
  }

  drawElement() {
    if (this is Rock) {
      return Rock();
    } else if (this is Paper) {
      return Paper();
    } else {
      return Scissors();
    }
  }

  winningElements() {
    if (this is Rock) {
      return Scissors();
    } else if (this is Paper) {
      return Rock();
    } else {
      return Paper();
    }
  }

  getCorrectedElement(BaseElement other) {
    if (this is Rock) {
      return other.winningElements();
    } else if (this is Paper) {
      return other.drawElement();
    } else {
      return other.loosingElements();
    }
  }
}

class Rock extends BaseElement {}

class Paper extends BaseElement {}

class Scissors extends BaseElement {}

class Day2 extends AdventDay<List<List<BaseElement>>> {
  Day2(String inputs) : super(inputs);

  final gamePointMap = {
    Rock: 1,
    Paper: 2,
    Scissors: 3,
  };

  @override
  List<List<BaseElement>> parser() {
    final List<List<BaseElement>> result = [];
    List<BaseElement> current = [];
    for (final String line in inputs.split('\n')) {
      if (line.isEmpty) {
        continue;
      }
      if (line.contains("A")) {
        current.add(Rock());
      }
      if (line.contains("B")) {
        current.add(Paper());
      }
      if (line.contains("C")) {
        current.add(Scissors());
      }
      if (line.contains("X")) {
        current.add(Rock());
      }
      if (line.contains("Y")) {
        current.add(Paper());
      }
      if (line.contains("Z")) {
        current.add(Scissors());
      }
      result.add(current);
      current = [];
    }
    return result;
  }

  @override
  String solvePartOne() {
    return parser()
        .map((e) =>
            BaseElement.numberOfPoints(e[1], e[0]) +
            gamePointMap[e[1].runtimeType]!)
        .sum
        .toString();
  }

  @override
  String solvePartTwo() {
    return parser()
        .map((e) {
          final BaseElement correctedElement = e[1].getCorrectedElement(e[0]);
          final score = BaseElement.numberOfPoints(correctedElement, e[0]) +
              gamePointMap[correctedElement.runtimeType]!;
          return score;
        })
        .sum
        .toString();
  }
}
