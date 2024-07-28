import 'package:campus_square_app/view/pages/config.dart';
import 'package:campus_square_app/view/pages/launch.dart';
import 'package:campus_square_app/view/pages/schedule.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:campus_square_app/view/widgets/schedule_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BottomPath {
  schedule('/schedule', Icon(Icons.schedule), SchedulePage()),
  launch('/launch', Icon(Icons.emoji_food_beverage), LaunchPage()),
  config('/config', Icon(Icons.settings), ConfigPage());

  const BottomPath(this.path, this.icon, this.page);
  final String path;
  final Icon icon;
  final Widget page;
}

String getPageNameL10nByIndex(int index, BuildContext context, WidgetRef ref) {
  switch (index) {
    case 0:
      {
        final selectedDay = ref.watch(selectedDayProvider);
        return '${context.l10n.schedule} (${selectedDay.year}/${selectedDay
            .month}/${selectedDay.day})';
      }
    case 1:
      return context.l10n.launch;
    case 2:
      return context.l10n.config;
    default:
      return 'getPageNameL10nByIndex error';
  }
}