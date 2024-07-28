import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';

class TodayIsHoliday extends StatelessWidget {
  const TodayIsHoliday({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Icon(Icons.holiday_village_outlined, size: 80),
          Text(
            context.l10n.no_lecture_today,
            style: AppTextStyle.textB.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
