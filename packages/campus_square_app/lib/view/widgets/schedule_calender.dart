import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:table_calendar/table_calendar.dart';

/// カレンダーの開始日
/// 会津大学の開講日に設定してある
/// ソース: https://ja.wikipedia.org/wiki/%E4%BC%9A%E6%B4%A5%E5%A4%A7%E5%AD%A6
final firstDay = DateTime.utc(1993, 4, 1);

/// カレンダーの終了日
/// いつ廃校になるかわからないので、現在時刻の10年後に設定してある
final endDay = Jiffy.now().add(years: 10).dateTime;

/// 表示するカレンダーのフォーマットの状態
final calenderFormatProvider = StateProvider((ref) {
  return CalendarFormat.month;
});

/// 選択されている日付の状態
final selectedDayProvider = StateProvider((ref) {
  return DateTime.now();
});

/// スケジュール確認用のカレンダーを表示するウィジェット
class ScheduleCalender extends ConsumerWidget {
  const ScheduleCalender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // カレンダーのフォーマットを取得
    final calenderFormat = ref.watch(calenderFormatProvider);
    // 選択されている日付を取得
    final selectedDay = ref.watch(selectedDayProvider);

    return TableCalendar(
      calendarFormat: calenderFormat,
      onFormatChanged: (format) {
        // カレンダーのフォーマットを更新
        ref.read(calenderFormatProvider.notifier).state = format;
      },
      onDaySelected: (selectedDay, focusedDay) {
        // 選択されている日付を更新
        ref.read(selectedDayProvider.notifier).state = selectedDay;
      },
      selectedDayPredicate: (day) {
        // 選択されている日付を強調
        return isSameDay(selectedDay, day);
      },
      firstDay: firstDay,
      lastDay: endDay,
      focusedDay: selectedDay,
    );
  }
}
