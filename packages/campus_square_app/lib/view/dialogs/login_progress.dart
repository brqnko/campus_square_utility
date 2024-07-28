import 'package:campus_square_app/external/campussquare/providers.dart';
import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProgressDialog extends ConsumerWidget {
  const LoginProgressDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campusSquare = ref.watch(campusSquareProvider);
    if (campusSquare.isLoggedIn) {
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                context.l10n.logging_in,
                style: AppTextStyle.textS.copyWith(
                  color: Colors.black54,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  context.l10n.cancel,
                  style: AppTextStyle.textS.copyWith(
                    color: Colors.black54,
                  )
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

void showLoginProgressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const LoginProgressDialog();
    },
  );
}