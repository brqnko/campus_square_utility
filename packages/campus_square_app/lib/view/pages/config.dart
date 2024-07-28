import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigPage extends ConsumerWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ListTile(
            //   title: Text(context.l10n.language),
            //   onTap: () {
            //     final router = ref.read(goRouterProvider);
            //     router.push('/config/language');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
