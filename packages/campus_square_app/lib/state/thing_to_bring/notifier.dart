import 'dart:async';

import 'package:campus_square_app/logic/things_to_bring/types/thing_to_bring.dart';
import 'package:campus_square_app/state/lecture_thing_to_bring/provider.dart';
import 'package:campus_square_app/state/schedule_list/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThingsToBringNotifier extends AsyncNotifier<Set<ThingToBring>> {

  @override
  FutureOr<Set<ThingToBring>> build() {
    return _getThingsToBring();
  }

  Future<Set<ThingToBring>> _getThingsToBring() async {
    final scheduleList = ref.watch(scheduleListNotifier);
    final lectureThingToBrings = ref.watch(lectureThingToBringNotifier);

    if (scheduleList.hasValue && lectureThingToBrings.hasValue) {
      final schedule = scheduleList.value!;
      final lectureThingToBring = lectureThingToBrings.value!;

      final thingsToBring = <ThingToBring>{};
      for (final lecture in schedule) {
        final thingToBrings = lectureThingToBring[lecture.lecture] ?? {};
        thingsToBring.addAll(thingToBrings.map((e) => ThingToBring(
          name: e.name,
          lectureName: lecture.lecture,
        )));
      }

      return thingsToBring;
    }

    return {};
  }
}