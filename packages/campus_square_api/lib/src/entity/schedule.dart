import 'package:campus_square_api/campus_square_api.dart';

enum ScheduleCondition {
  opening,
  supplementary,
  unknown
}

ScheduleCondition fromString(String type) {
  switch (type) {
    case 'kaiko':
      return ScheduleCondition.opening;
    case 'kyuko':
      return ScheduleCondition.supplementary;
    default:
      return ScheduleCondition.unknown;
  }
}

final _sourceRegExp = RegExp(r'"(\w+)"');
final _periodRegExp = RegExp(r'(\d+-\d+限|\d+限)(:)?');
final _classInfoRegExp2 = RegExp(r'\[\S+\]\s+\S+\s+(.+?)\s+\[\S+\]');
final _classInfoRegExp1 = RegExp(r'@([A-Za-z0-9]+)\s*：?\s*(.+)|');

class Schedule {
  ScheduleCondition type;
  String period, lecture, room;
  Schedule(this.type, this.period, this.lecture, this.room);

  /// Converts an HTML element to a Schedule object
  factory Schedule.fromHTMLElement(String htmlElement) {
    final sourceMatch = _sourceRegExp.firstMatch(htmlElement);
    final periodMatch = _periodRegExp.firstMatch(htmlElement);
    var classInfoMatch = _classInfoRegExp1.firstMatch(htmlElement);
    if (classInfoMatch == null || classInfoMatch.group(1) == null) {
      classInfoMatch = _classInfoRegExp2.firstMatch(htmlElement);
      if (sourceMatch == null || periodMatch == null || classInfoMatch == null) {
        throw Exception('Failed to parse schedule');
      }

      final source = sourceMatch.group(1)!;
      final period = periodMatch.group(1)!;
      final name = classInfoMatch.group(1)!;
      final code = classInfoMatch.group(1)!;

      return Schedule(fromString(source), period, name, code);
    }
    if (sourceMatch == null || periodMatch == null) {
      throw Exception('Failed to parse schedule');
    }
    if (sourceMatch == null || periodMatch == null || classInfoMatch == null) {
      throw Exception('Failed to parse schedule');
    }

    final source = sourceMatch.group(1)!;
    final period = periodMatch.group(1)!;
    final code = classInfoMatch.group(1)!;
    final name = classInfoMatch.group(2)!;

    return Schedule(fromString(source), period, name, code);
  }

  @override
  String toString() {
    return 'Schedule{type: $type, period: $period, lecture: $lecture, room: $room}';
  }
}