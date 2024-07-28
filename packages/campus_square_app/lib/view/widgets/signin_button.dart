import 'package:campus_square_app/view/dialogs/login.dart';
import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        showLoginDialog(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        maximumSize: const Size(150, 48),
        side: const BorderSide(color: Colors.black12, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.login, color: Colors.blue, size: 24,),
          const SizedBox(width: 4),
          Text(
            context.l10n.sign_in,
            style: AppTextStyle.buttonS.copyWith(
              color: Colors.blue,
            ),
          ),
        ],
      )
    );
  }
}
