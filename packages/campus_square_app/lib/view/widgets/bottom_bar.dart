import 'package:campus_square_app/view/pages/config.dart';
import 'package:campus_square_app/view/pages/launch.dart';
import 'package:campus_square_app/view/pages/schedule.dart';
import 'package:campus_square_app/view/router/bottom_path.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 現在表示しているページのインデックスの状態
final indexProvider = StateProvider((ref) {
  return 0;
});

final pages = [
  const SchedulePage(),
  const LaunchPage(),
  const ConfigPage(),
];

/// ボトムナビゲーションバーを表示するウィジェット
class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// ページのインデックスを監視
    final index = ref.watch(indexProvider);

    /// ボトムナビゲーションバーのアイテム
    final items = [
      /// スケジュール
      BottomNavigationBarItem(
        icon: BottomPath.schedule.icon,
        label: context.l10n.schedule,
      ),
      /// ランチ
      BottomNavigationBarItem(
        icon: BottomPath.launch.icon,
        label: context.l10n.launch,
      ),
      /// 設定
      BottomNavigationBarItem(
        icon: BottomPath.config.icon,
        label: context.l10n.config,
      ),
    ];

    return BottomNavigationBar(
      items: items,
      currentIndex: index,
      onTap: (index) {
        /// インデックスを更新
        ref.read(indexProvider.notifier).state = index;
      },
    );
  }
}
