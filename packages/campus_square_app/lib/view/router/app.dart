import 'package:campus_square_app/external/campussquare/providers.dart';
import 'package:campus_square_app/external/lecture_things_cache/provider.dart';
import 'package:campus_square_app/external/login_data_cache/provider.dart';
import 'package:campus_square_app/logic/lecture_thing_to_bring/types/lecture_thing_to_bring.dart';
import 'package:campus_square_app/state/lecture_thing_to_bring/provider.dart';

import 'go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    _tryLoginWithCache(ref);
    _tryLoadLectureThingsToBring(ref);

    return MaterialApp.router(
      routerDelegate: router.routerDelegate, // GoRouter
      routeInformationParser: router.routeInformationParser, // GoRouter
      routeInformationProvider: router.routeInformationProvider, // GoRouter
      debugShowCheckedModeBanner: false,
      localizationsDelegates:
      AppLocalizations.localizationsDelegates, // localizations
      supportedLocales: AppLocalizations.supportedLocales, // localizations
      locale: Locale(Intl.systemLocale),
    );
  }
}

Future<void> _tryLoginWithCache(WidgetRef ref) async {
  final campusSquare = ref.read(campusSquareProvider);
  final loginCache = await ref.read(loginDataCacheProvider).getLoginData();

  if (loginCache != null) {
    try {
      await campusSquare.login(loginCache.userName, loginCache.password).then((
          value) {
        ref
            .read(isLoggedInProvider.notifier)
            .state = true;
      });
    } catch (e) {
      print(e);
    }
  }
}

  Future<void> _tryLoadLectureThingsToBring(WidgetRef ref) async {
  final lectureThingsCache = ref.read(lectureThingsCacheProvider);
  final lectureThings = await lectureThingsCache.loadLectureThings();
  for (final lectureName in lectureThings.keys) {
    for (final thingToBring in lectureThings[lectureName]!) {
      ref.read(lectureThingToBringNotifier.notifier).addLectureThingToBring(
        lectureName,
        LectureThingToBring(
          name: thingToBring,
        ),
      );
    }
  }
}