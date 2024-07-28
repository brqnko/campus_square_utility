import 'package:campus_square_app/view/dialogs/lecture_detail.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:campus_square_app/view/widgets/today_is_holiday.dart';
import 'package:flutter/material.dart';
import 'package:campus_square_api/src/entity/schedule.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> scheduleList;

  const ScheduleList(this.scheduleList, {super.key});

  @override
  Widget build(BuildContext context) {
    if (scheduleList.isEmpty) {
      return const TodayIsHoliday();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: scheduleList.length,
      itemBuilder: (context, index) {
        final schedule = scheduleList[index];

        return ListTile(
          onTap: () {
            showLectureDetailDialog(context, schedule.lecture);
          },
          title: Text(schedule.lecture),
          subtitle: Text('${schedule.period}, ${schedule.room}, ${_translateCondition(schedule.type, context)}'),
        );
      },
    );
  }
}

String _translateCondition(ScheduleCondition type, BuildContext context) {
  switch(type) {
    case ScheduleCondition.opening:
      return context.l10n.schedule_condition_opening;
    case ScheduleCondition.supplementary:
      return context.l10n.schedule_condition_supplementary;
    case ScheduleCondition.unknown:
      return context.l10n.schedule_condition_unknown;
  }
}
