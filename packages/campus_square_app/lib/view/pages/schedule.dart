import 'package:campus_square_app/view/widgets/schedule_tab.dart';
import 'package:campus_square_app/view/widgets/schedule_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// スケジュールのページを表示するウィジェット
class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ScheduleCalender(),
        ScheduleTab(),
      ],
    );
  }
}
