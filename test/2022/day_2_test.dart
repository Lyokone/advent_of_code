import 'package:advent_of_code/2022/day_2.dart';
import 'package:test/test.dart';

import 'day_2_input.dart';

void main() {
  test('Small Input', () async {
    final day = Day2('''
A Y
B X
C Z
''');
    expect(day.solvePartOne(), equals('15'));
    expect(day.solvePartTwo(), equals('12'));
  });

  test('Big Input', () async {
    final day = Day2(bigInput);
    print("Part 1 solution: ${day.solvePartOne()}");
    print("Part 2 solution: ${day.solvePartTwo()}");
  });
}
