import 'dart:convert';

import 'dart:io';

Future<List<List<int>>> getErrors() async {
  final file = File('input/day3.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  return lines
      .map((event) => event.split('').map((e) => int.parse(e)).toList())
      .toList();
}

void main() async {
  final bitsErrors = await getErrors();

  final popularInts = List.generate(
      bitsErrors[0].length, (index) => mostCommon(index, bitsErrors)).toList();
  final notPopularInts = inverseBit(popularInts);

  print(getValue(popularInts) * getValue(notPopularInts));

  var bitsErrorsOxygen = await getErrors();
  for (int i = 0; i < bitsErrors[0].length; i++) {
    if (bitsErrorsOxygen.length == 1) {
      break;
    }
    final mostCommonBit = mostCommon(i, bitsErrorsOxygen);
    bitsErrorsOxygen = bitsErrorsOxygen
        .where((element) => element[i] == mostCommonBit)
        .toList();
  }

  final oxygen = bitsErrorsOxygen[0];

  var bitsErrorsCO2 = await getErrors();
  for (int i = 0; i < bitsErrors[0].length; i++) {
    if (bitsErrorsCO2.length == 1) {
      break;
    }
    final lessCommonBit = lessCommon(i, bitsErrorsCO2);
    bitsErrorsCO2 =
        bitsErrorsCO2.where((element) => element[i] == lessCommonBit).toList();
  }

  final co2 = bitsErrorsCO2[0];

  print(getValue(oxygen) * getValue(co2));
}

int mostCommon(int position, List<List<int>> data) {
  final bits = List.generate(data.length, (index) => data[index][position]);
  if (bits.count(0) > bits.count(1)) {
    return 0;
  }
  return 1;
}

int lessCommon(int position, List<List<int>> data) {
  return 1 - (mostCommon(position, data));
}

List<int> inverseBit(List<int> input) {
  return input.map((e) => 1 - e).toList();
}

int getValue(List<int> input) {
  return int.parse(input.join(), radix: 2);
}

extension ListExtension<T extends Comparable> on List<T> {
  int count(T element) {
    final numberOfOccurences = this.where((e) => e == element);
    return numberOfOccurences.length;
  }
}
