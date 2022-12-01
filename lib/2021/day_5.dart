import 'dart:convert';

import 'dart:io';
import 'dart:math';
import 'package:collection/collection.dart';

Future<HydroMap> getLines() async {
  final file = File('input/day5.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  List<Line> hydroLines = [];

  await lines.forEach((element) {
    hydroLines.add(Line.fromString(element));
  });

  return HydroMap(hydroLines);
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  factory Point.fromString(String input) {
    final coordinates = input.split(',');
    final x = int.parse(coordinates[0]);
    final y = int.parse(coordinates[1]);
    return Point(x, y);
  }

  @override
  String toString() {
    return "($x,$y)";
  }
}

class Line {
  final Point start;
  final Point end;

  Line(this.start, this.end);

  factory Line.fromString(String input) {
    final points = input.split(" -> ");
    final start = Point.fromString(points[0]);
    final end = Point.fromString(points[1]);
    return Line(start, end);
  }

  List<Point> getPoints() {
    if (start.x == end.x) {
      return List.generate(
        (end.y - start.y).abs() + 1,
        (index) => Point(start.x, min(start.y, end.y) + index),
      );
    } else if (start.y == end.y) {
      return List.generate(
        (end.x - start.x).abs() + 1,
        (index) => Point(min(start.x, end.x) + index, start.y),
      );
    }
    // Commented for part 2
    // return [];
    final xDirection = start.x > end.x ? -1 : 1;
    final yDirection = start.y > end.y ? -1 : 1;

    return List.generate(
      (end.x - start.x).abs() + 1,
      (index) =>
          Point(start.x + index * xDirection, start.y + index * yDirection),
    );
  }
}

class HydroMap {
  final List<Line> lines;
  late final List<List<int>> hydroMap;

  HydroMap(this.lines) {
    final maxX = lines
        .map((e) => [e.start.x, e.end.x])
        .expand((element) => element)
        .reduce(max);
    final maxY = lines
        .map((e) => [e.start.y, e.end.y])
        .expand((element) => element)
        .reduce(max);

    hydroMap =
        List.generate(maxX + 1, (index) => List.filled(maxY + 1, 0)).toList();
  }
}

void main() async {
  final hydroMap = await getLines();
  for (var line in hydroMap.lines) {
    for (var point in line.getPoints()) {
      hydroMap.hydroMap[point.x][point.y] += 1;
    }
  }
  print(hydroMap.hydroMap
      .map((e) => e.where((element) => element > 1).length)
      .sum);
}

extension ListExtension<T extends Comparable> on List<T> {
  int count(T element) {
    final numberOfOccurences = this.where((e) => e == element);
    return numberOfOccurences.length;
  }
}
