import 'dart:convert';

import 'dart:io';
import 'package:collection/collection.dart';

Future<List<int>> getListOfDepths() async {
  final file = File('input/day1.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  return lines.map((event) => int.parse(event)).toList();
}

void main() async {
  final depths = await getListOfDepths();

  print(List.generate(depths.length - 1, (index) => 1 + index)
      .map((i) => depths[i - 1] < depths[i] ? 1 : 0)
      .toList()
      .sum);

  print(List.generate(depths.length - 3, (index) => index)
      .map((i) =>
          depths.sublist(i + 1, i + 4).sum > depths.sublist(i, i + 3).sum
              ? 1
              : 0)
      .toList()
      .sum);
}
