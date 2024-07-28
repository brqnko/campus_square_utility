import 'package:campus_square_app/logic/lecture_thing_to_bring/types/lecture_thing_to_bring.dart';
import 'package:campus_square_app/state/lecture_thing_to_bring/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef _Notifier = LectureThingToBringNotifier;
typedef _State = Map<String, Set<LectureThingToBring>>;

final lectureThingToBringNotifier = AsyncNotifierProvider<_Notifier, _State>(
    () {
      return _Notifier();
    }
);