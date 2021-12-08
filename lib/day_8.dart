import 'dart:convert';

import 'dart:io';
import 'package:collection/collection.dart';

Future<List<DigitDisplay>> getResultDigits() async {
  final file = File('input/day8.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  final data = await lines.map((line) {
    final data = line.split(' | ');
    return DigitDisplay(data[1].split(" ").map((e) => e.split('')).toList(),
        data[0].split(" ").map((e) => e.split('')).toList());
  }).toList();
  return data;
}

class DigitDisplay {
  final List<List<String>> results;
  final List<List<String>> inputs;

  final Map<int, String> mapping = {};

  DigitDisplay(this.results, this.inputs);

  int getKey(String value) {
    return mapping.keys.firstWhere((element) => mapping[element] == value);
  }

  int getResultValue() {
    return int.parse(results.map((e) {
      final data = e.map((value) => getKey(value)).toList();
      data.sort();
      final number = data.join('');
      if (number == "123567") {
        return 0;
      } else if (number == "36") {
        return 1;
      } else if (number == "13457") {
        return 2;
      } else if (number == "13467") {
        return 3;
      } else if (number == "2346") {
        return 4;
      } else if (number == "12467") {
        return 5;
      } else if (number == "124567") {
        return 6;
      } else if (number == "136") {
        return 7;
      } else if (number == "1234567") {
        return 8;
      } else if (number == "123467") {
        return 9;
      }
      print("Error, should not happen");
      return 0;
    }).join(''));
  }
}

part1(List<List<String>> digits) {
  return digits
      .map((digit) =>
          digit.where((element) => [2, 3, 4, 7].contains(element.length)))
      .map((e) => e.length)
      .sum;
}

const kSevenLenght = 3;
const kOneLenght = 2;
const kFourLenght = 4;

const listAllLetters = ["a", "b", "c", "d", "e", "f", "g"];

part2(List<DigitDisplay> digits) {
  return digits.map((e) {
    final seven =
        e.inputs.firstWhere((element) => element.length == kSevenLenght);
    final one = e.inputs.firstWhere((element) => element.length == kOneLenght);

    // Find the mapping for the top number (1) deduced from one and seven
    final oneBinding = seven.firstWhere((element) => !one.contains(element));
    e.mapping[1] = oneBinding;

    // Find the mapping for the bottom right (6) deduce from the one number and the number with 9 occurences
    final sixBiding = listAllLetters.firstWhere((element) =>
        e.inputs.where((input) => input.contains(element)).length == 9);

    e.mapping[6] = sixBiding;
    one.remove(sixBiding);
    e.mapping[3] = one.first;

    // Find the mapping for the top left (2) deduced from the one number and the number with 6 occurences
    final twoBiding = listAllLetters.firstWhere((element) =>
        e.inputs.where((input) => input.contains(element)).length == 6);

    e.mapping[2] = twoBiding;

    // Find the mapping for the (5) deduced from the one number and the number with 4 occurences
    final fiveBiding = listAllLetters.firstWhere((element) =>
        e.inputs.where((input) => input.contains(element)).length == 4);
    e.mapping[5] = fiveBiding;

    // Find (4) by finding the last not used element in the 4 from first part
    final four =
        e.inputs.firstWhere((element) => element.length == kFourLenght);
    e.mapping.values.forEach((element) {
      four.remove(element);
    });
    e.mapping[4] = four.first;

    // The last one :)
    e.mapping[7] = listAllLetters
        .firstWhere((element) => !e.mapping.values.contains(element));

    return e.getResultValue();
  }).sum;
}

void main() async {
  final digits = await getResultDigits();
  print(part2(digits));
}
