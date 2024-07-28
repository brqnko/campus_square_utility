import 'dart:io';

import 'package:campus_square_api/campus_square_api.dart';

void main() async {
  CampusSquare api = CampusSquare();

  print('Username: ');
  String? userName = stdin.readLineSync();
  print('Password: ');
  String? password = stdin.readLineSync();

  List<Schedule> schedules = await api.checkSchedule(2024, 7, 31);
  print(schedules);
}