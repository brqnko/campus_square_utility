import 'package:campus_square_app/external/campussquare/providers.dart';
import 'package:campus_square_app/external/login_data_cache//provider.dart';
import 'package:campus_square_app/logic/login_data/types/login_data.dart';
import 'package:campus_square_app/view/dialogs/login_failed.dart';
import 'package:campus_square_app/view/dialogs/login_progress.dart';
import 'package:campus_square_app/view/theme/colors.dart';
import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameInputProvider = StateProvider<String>((ref) => '');
final passwordInputProvider = StateProvider<String>((ref) => '');

class LoginDialog extends ConsumerWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campusSquare = ref.read(campusSquareProvider);

    final userNameInput = TextField(
      enableSuggestions: false,
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: context.l10n.username,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.textInputFocusedColor),
        ),
      ),
      onChanged: (value) {
        ref.read(userNameInputProvider.notifier).state = value;
      },
    );

    final passwordInput = TextField(
      enableSuggestions: false,
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: context.l10n.password,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.textInputFocusedColor),
        ),
      ),
      onChanged: (value) {
        ref.read(passwordInputProvider.notifier).state = value;
      },
    );

    final loginButton = ElevatedButton(
      onPressed: () async {
        final String userName = ref.read(userNameInputProvider);
        final String password = ref.read(passwordInputProvider);

        showLoginProgressDialog(context);

        try {
          await campusSquare.login(userName, password).then((value) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            ref.read(isLoggedInProvider.notifier).state = true;

            ref.read(loginDataCacheProvider).saveLoginData(LoginData(
              userName: userName,
              password: password,
            ));
          });
        } catch (e) {
          String reason = e.toString();
          if (reason.contains("Exception: ")) {
            reason = reason.replaceFirst("Exception: ", "");
          }

          Navigator.of(context).pop();
          showLoginFailedDialog(context, reason);
        }
      },
      child: Text(context.l10n.sign_in),
    );

    final loginText = Text(
      context.l10n.sign_in,
      style: AppTextStyle.textB,
    );

    final descriptionText = Text(
      context.l10n.to_continue_campus_square,
      style: AppTextStyle.textS.copyWith(
        color: Colors.black54,
      ),
    );

    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loginText,
                descriptionText,
                userNameInput,
                passwordInput,
                const SizedBox(height: 16),
                Center(
                  child: loginButton,
                ),
              ],
            ),
          ),
        )
    );
  }
}

void showLoginDialog(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return const LoginDialog();
    },
  );
}
