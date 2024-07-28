import 'dart:async';

import 'package:campus_square_api/campus_square_api.dart';
import 'package:campus_square_app/external/campussquare/providers.dart';
import 'package:campus_square_app/view/widgets/schedule_calender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleListNotifier extends AsyncNotifier<List<Schedule>> {

  @override
  FutureOr<List<Schedule>> build() async {
    return _getScheduleList();
  }

  Future<List<Schedule>> _getScheduleList() async {
    final campusSquare = ref.read(campusSquareProvider);
    final focusedDay = ref.watch(selectedDayProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);

    if (!isLoggedIn) {
      return [];
    }

    final scheduleList = await campusSquare.checkSchedule(focusedDay.year, focusedDay.month, focusedDay.day);

    return scheduleList;
  }
}