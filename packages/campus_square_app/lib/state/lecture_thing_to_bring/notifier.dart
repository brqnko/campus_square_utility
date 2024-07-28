import 'dart:async';

import 'package:campus_square_app/external/lecture_things_cache/provider.dart';
import 'package:campus_square_app/logic/lecture_thing_to_bring/types/lecture_thing_to_bring.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LectureThingToBringNotifier extends AsyncNotifier<Map<String, Set<LectureThingToBring>>> {
  final Map<String, Set<LectureThingToBring>> _lectureThingToBring = {};

  void addLectureThingToBring(String lectureName, LectureThingToBring lectureThingToBring) {
    if (_lectureThingToBring.containsKey(lectureName)) {
      _lectureThingToBring[lectureName]!.add(lectureThingToBring);
    } else {
      _lectureThingToBring[lectureName] = {lectureThingToBring};
    }

    state = AsyncData(_lectureThingToBring);
    _saveLectureThingToBringPerf(lectureName);
  }

  void removeLectureThingToBring(String lectureName, LectureThingToBring lectureThingToBring) {
    if (_lectureThingToBring.containsKey(lectureName)) {
      _lectureThingToBring[lectureName]!.remove(lectureThingToBring);
    }

    state = AsyncData(_lectureThingToBring);
    _saveLectureThingToBringPerf(lectureName);
  }

  Future<void> _saveLectureThingToBringPerf(String lectureName) async {
    final lectureThingsToBringCache = ref.read(lectureThingsCacheProvider);
    if (_lectureThingToBring.containsKey(lectureName)) {
      await lectureThingsToBringCache.saveLectureThings(
        lectureName,
        _lectureThingToBring[lectureName]!.map((thingToBring) => thingToBring.name).toSet(),
      );
    }
  }

  @override
  FutureOr<Map<String, Set<LectureThingToBring>>> build() {
    return _loadLectureThingToBringPerf();
  }

  Future<Map<String, Set<LectureThingToBring>>> _loadLectureThingToBringPerf() async {
    return {};
  }
}