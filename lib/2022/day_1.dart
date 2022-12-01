import 'package:advent_of_code/utils/base_class.dart';
import 'package:collection/collection.dart';

class Day1 extends AdventDay<List<List<int>>> {
  Day1(String inputs) : super(inputs);

  @override
  List<List<int>> parser() {
    final List<List<int>> result = [];
    List<int> current = [];
    for (final String line in inputs.split('\n')) {
      if (line.isEmpty) {
        result.add(current);
        current = [];
      } else {
        current.add(int.parse(line));
      }
    }
    result.add(current);
    return result;
  }

  Iterable<int> elvesCaloriesSorted(List<List<int>> elves) {
    final input = parser();

    final elvesCalories = input.map((e) => e.sum).toList();
    elvesCalories.sort();
    return elvesCalories.reversed;
  }

  @override
  String solvePartOne() {
    final elvesCalories = elvesCaloriesSorted(parser());
    return elvesCalories.first.toString();
  }

  @override
  String solvePartTwo() {
    final elvesCalories = elvesCaloriesSorted(parser());
    return elvesCalories.take(3).sum.toString();
  }
}
