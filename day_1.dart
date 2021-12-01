import 'dart:convert';

import 'dart:io';

Future<List<int>> getListOfDepths() async {
  final file = File('input/day1.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  final depths = <int>[];
  try {
    await for (var line in lines) {
      depths.add(int.parse(line));
    }
  } catch (e) {
    print('Error: $e');
  }

  return depths;
}

void main() async {
  final depths = await getListOfDepths();

  int depthIncreasing = 0;
  for (var i = 0; i < depths.length - 1; i++) {
    if (depths[i] < depths[i + 1]) {
      depthIncreasing++;
    }
  }

  print(depthIncreasing);

  int depthIncreasingWindow = 0;
  int depth0 = depths[0];
  int depth1 = depths[1];
  int depth2 = depths[2];
  int depth3 = depths[3];

  int firstWindow = depth0 + depth1 + depth2;
  int secondWindow = depth1 + depth2 + depth3;

  for (var i = 4; i < depths.length; i++) {
    if (firstWindow < secondWindow) {
      depthIncreasingWindow++;
    }

    depth0 = depth1;
    depth1 = depth2;
    depth2 = depth3;
    depth3 = depths[i];

    firstWindow = depth0 + depth1 + depth2;
    secondWindow = depth1 + depth2 + depth3;
  }
  if (firstWindow < secondWindow) {
    depthIncreasingWindow++;
  }

  print(depthIncreasingWindow);
}
