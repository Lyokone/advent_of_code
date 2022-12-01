import 'package:advent_of_code/2022/day_1.dart';
import 'package:test/test.dart';

import 'day_1_input.dart';

void main() {
  test('Small Input', () async {
    Day1 day = Day1('''
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
''');
    expect(day.solvePartOne(), equals('24000'));
    expect(day.solvePartTwo(), equals('45000'));
  });

  test('Big Input', () async {
    Day1 day = Day1(day_1_input);
    print("Part 1 solution: ${day.solvePartOne()}");
    print("Part 2 solution: ${day.solvePartTwo()}");
  });
}
