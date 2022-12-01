/// Base class to extend in order to
/// solve a day of Advent of Code.
abstract class AdventDay<T> {
  AdventDay(this.inputs);

  /// The inputs of the day
  final String inputs;

  /// The parser to use to parse the inputs
  T parser();

  /// First part solver
  String solvePartOne();

  /// Second part solver
  String solvePartTwo();
}
