import 'package:campus_square_app/view/pages/home.dart';
import 'package:campus_square_app/view/pages/language.dart';
import 'package:campus_square_app/view/router/page_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider(
    (ref) {
      final home = GoRoute(
        path: PagePath.home.path,
        name: PagePath.home.name,
        builder: (_, __) => const HomePage(),
      );

      final language = GoRoute(
        path: PagePath.language.path,
        name: PagePath.language.name,
        builder: (_, __) => const LanguagePage(),
      );

      return GoRouter(
        routes: [
          home,
          language,
        ],
      );
    }
);