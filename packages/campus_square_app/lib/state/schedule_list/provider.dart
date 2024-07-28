import 'package:campus_square_api/campus_square_api.dart';
import 'package:campus_square_app/state/schedule_list/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef _Notifier = ScheduleListNotifier;
typedef _State = List<Schedule>;

final scheduleListNotifier = AsyncNotifierProvider<_Notifier, _State>(
    () {
      return _Notifier();
    }
);
