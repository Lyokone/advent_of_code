import 'dart:convert';

import 'dart:io';
import 'package:collection/collection.dart';

Future<List<int>> getListOfFishes() async {
  final file = File('input/day6.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  final data = (await lines.first).split(',').map((e) => int.parse(e)).toList();
  final fishes = List.filled(9, 0);
  for (int value in data) {
    fishes[value]++;
  }

  // To create a mutable copy
  return List<int>.from(fishes);
}

numberOfFishesAfterNDays(int days) async {
  final fishes = await getListOfFishes();

  for (int day = 0; day < days; day++) {
    final currentBirth = fishes.removeAt(0);
    fishes[6] += currentBirth;
    fishes.add(currentBirth);
  }

  print(fishes.sum);
}

void main() async {
  numberOfFishesAfterNDays(80);

  numberOfFishesAfterNDays(256);
}
