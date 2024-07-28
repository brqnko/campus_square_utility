import 'package:campus_square_app/external/lecture_things_cache/interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lectureThingsCacheProvider = Provider<LectureThingsCache>(
    (ref) {
      return LectureThingsCache();
    }
);