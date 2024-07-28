import 'package:campus_square_app/external/campussquare/providers.dart';
import 'package:campus_square_app/state/schedule_list/provider.dart';
import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:campus_square_app/view/widgets/schedule_list.dart';
import 'package:campus_square_app/view/widgets/signin_button.dart';
import 'package:campus_square_app/view/widgets/things_to_bring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// selectedDayProviderの日付にあるスケジュールを表示するウィジェット
class ScheduleTab extends ConsumerWidget {
  const ScheduleTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // selectedDayProviderを監視
    final isLoggedIn = ref.watch(isLoggedInProvider);

    // selectedDayProviderの日付をタブとして表示
    final timeTableContainer = Container(
      color: Colors.blue,
      alignment: Alignment.center,
      height: 48,
      child: Text(
        context.l10n.time_table,
        style: AppTextStyle.tabM.copyWith(
          color: Colors.white,
        ),
      ),
    );

    final thingsToBringContainer = Container(
      color: Colors.blue,
      alignment: Alignment.center,
      height: 48,
      child: Text(
        context.l10n.things_to_bring,
        style: AppTextStyle.tabM.copyWith(
          color: Colors.white,
        ),
      ),
    );

    if (isLoggedIn) {
      final scheduleList = ref.watch(scheduleListNotifier);

      return Expanded(child: SingleChildScrollView(
        child: Column(
          children: [
            timeTableContainer,
            scheduleList.when(
              data: (data) {
                return ScheduleList(data);
              },
              error: (error, stackTrace) {
                return const Center();
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            thingsToBringContainer,
            const ThingsToBring(),
          ],
        ),
      ));
    } else {
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              timeTableContainer,
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.schedule, size: 48,),
                    const SizedBox(height: 8),
                    Text(
                        context.l10n.dont_miss_your_schedule,
                        style: AppTextStyle.textM.copyWith(
                          color: Colors.black87,
                        ),
                    ),
                    Text(
                        context.l10n.sign_in_to_see_your_schedule,
                        style: AppTextStyle.textS.copyWith(
                          color: Colors.black54,
                        ),
                    ),
                    const SizedBox(height: 16),
                    const SignInButton(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              thingsToBringContainer,
              const ThingsToBring(),
            ],
          ),
        )
      );
    }
  }
}
