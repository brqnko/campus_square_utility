import 'package:campus_square_app/view/router/bottom_path.dart';
import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ページとアップバー、ボトムナビゲーションバーを表示するウィジェット
/// Scaffoldウィジェットを使用
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 表示するべきページを取得
    final pageIndex = ref.watch(indexProvider);
    final page = pages[pageIndex];

    /// アップバーを作成
    final appBar = AppBar(
      title: Text(
        getPageNameL10nByIndex(pageIndex, context, ref),
        style: AppTextStyle.tabM.copyWith(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blue,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      bottomNavigationBar: const BottomBar(),
      body: page,
    );
  }
}
