import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';

class LoginFailedDialog extends StatelessWidget {
  final String reason;

  const LoginFailedDialog(this.reason, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.login_failed),
      content: Text(reason),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.l10n.ok),
        ),
      ],
    );
  }
}

void showLoginFailedDialog(BuildContext context, String reason) {
  showDialog(
    context: context,
    builder: (context) {
      return LoginFailedDialog(reason);
    },
  );
}
