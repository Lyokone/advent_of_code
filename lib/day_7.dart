import 'dart:convert';
import 'dart:math';

import 'dart:io';
import 'package:collection/collection.dart';

Future<List<int>> getPositions() async {
  final file = File('input/day7.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  final data = (await lines.first).split(',').map((e) => int.parse(e)).toList();
  return data;
}

calculateAmount(int position, List<int> positions) {
  return positions.map((e) => sumFuel((position - e).abs())).sum;
}

int sumFuel(int value) {
  return (1 + value) * value ~/ 2;
}

void main() async {
  final positions = await getPositions();

  final maxPosition = positions.reduce(max);

  final minP = minBy(List.generate(maxPosition + 1, (index) => index),
      (position) => calculateAmount(position as int, positions));

  print(calculateAmount(minP!, positions));
}
