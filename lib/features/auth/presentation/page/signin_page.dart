import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/common/widget/button/basic_app_button.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/presentation/page/enter_password_page.dart';
import 'package:ecomerce/features/auth/presentation/page/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signinText(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _continueButton(context),
            const SizedBox(height: 20),
            _createAccount(context),
          ],
        ),
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return const Text(
      'Sign in',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Email Address',
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.push(
            context,
            EnterPasswordPage(
              signinUserReq: SigninUserReq(email: _emailCon.text),
            ));
      },
      title: 'Continue',
    );
  }

  Widget _createAccount(context) {
    return RichText(
        text: TextSpan(
      children: [
        const TextSpan(
          text: 'Don\'t have an account? ',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
        TextSpan(
          text: 'Create Account',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, SignupPage());
            },
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
