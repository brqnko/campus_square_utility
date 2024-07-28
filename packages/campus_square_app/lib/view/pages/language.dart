import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.language),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: AppLocalizations.supportedLocales.map((delegate) {
              return ListTile(
                title: Text(delegate.toLanguageTag()),
                onTap: () async {
                  // TODO: ここで言語を変更する処理を書く
                  await AppLocalizations.delegate.load(Locale(delegate.languageCode));
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
