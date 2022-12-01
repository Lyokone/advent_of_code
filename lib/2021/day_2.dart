import 'dart:convert';

import 'dart:io';

class Direction {
  final String direction;
  final int amount;

  Direction(this.direction, this.amount);
}

Future<List<Direction>> getListOfDirection() async {
  final file = File('input/day2.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  return lines.map((event) {
    final data = event.split(" ");
    return Direction(data[0], int.parse(data[1]));
  }).toList();
}

void main() async {
  final directions = await getListOfDirection();

  int forwardAmount = 0;
  int depth = 0;

  for (final direction in directions) {
    if (direction.direction == "forward") {
      forwardAmount += direction.amount;
    } else if (direction.direction == "down") {
      depth += direction.amount;
    } else if (direction.direction == "up") {
      depth -= direction.amount;
    }
  }

  print(forwardAmount * depth);

  forwardAmount = 0;
  int aim = 0;
  depth = 0;

  for (final direction in directions) {
    if (direction.direction == "forward") {
      forwardAmount += direction.amount;
      depth += direction.amount * aim;
    } else if (direction.direction == "down") {
      aim += direction.amount;
    } else if (direction.direction == "up") {
      aim -= direction.amount;
    }
  }

  print(forwardAmount * depth);
}
