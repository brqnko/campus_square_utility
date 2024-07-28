import 'dart:io';

import 'package:campus_square_api/src/campus_square_api_base.dart';
import 'package:campus_square_api/src/entity/schedule.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('schedule', () async {
    CampusSquare api = CampusSquare();

    print('Username: ');
    String? userName = stdin.readLineSync();
    print('Password: ');
    String? password = stdin.readLineSync();

    await api.login(userName!, password!);
    List<Schedule> schedules = await api.checkSchedule(2024, 7, 31);
    print(schedules);
  });
}