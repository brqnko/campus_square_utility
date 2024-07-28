import 'package:campus_square_app/logic/things_to_bring/types/thing_to_bring.dart';
import 'package:campus_square_app/state/thing_to_bring/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef _Notifier = ThingsToBringNotifier;
typedef _State = Set<ThingToBring>;

final thingsToBringNotifier = AsyncNotifierProvider<_Notifier, _State>(
    () {
      return _Notifier();
    }
);