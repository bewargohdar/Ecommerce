import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/common/widget/button/basic_app_button.dart';
import 'package:ecomerce/features/auth/presentation/page/forgot_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EnterPasswordPage extends StatelessWidget {
  const EnterPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _enterPassword(context),
            const SizedBox(height: 20),
            _passwordFiled(context),
            const SizedBox(height: 20),
            _continueButton(),
            const SizedBox(height: 20),
            _forgetPassword(context),
          ],
        ),
      ),
    );
  }

  Widget _enterPassword(BuildContext context) {
    return const Text(
      'Sign in',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _passwordFiled(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Password',
      ),
    );
  }

  Widget _continueButton() {
    return BasicAppButton(
      onPressed: () {},
      title: 'Continue',
    );
  }

  Widget _forgetPassword(context) {
    return RichText(
        text: TextSpan(
      children: [
        const TextSpan(
          text: 'Forget Password? ',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
        TextSpan(
          text: 'Reset',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Navigate to the create account page
              AppNavigator.push(context, const ForgotPage());
            },
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
