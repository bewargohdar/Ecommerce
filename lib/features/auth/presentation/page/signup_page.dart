import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/common/widget/button/basic_app_button.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';

import 'package:ecomerce/features/auth/presentation/page/gender_page.dart';
import 'package:ecomerce/features/auth/presentation/page/signin_page.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signupText(context),
              const SizedBox(height: 20),
              _firstNameField(context),
              const SizedBox(height: 20),
              _lastNameField(context),
              const SizedBox(height: 20),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 20),
              _continueButton(context),
              const SizedBox(height: 20),
              _forgetPassword(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupText(BuildContext context) {
    return const Text(
      'Create Account',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _firstNameField(BuildContext context) {
    return TextField(
      controller: _firstNameCon,
      decoration: const InputDecoration(
        hintText: 'First Name',
      ),
    );
  }

  Widget _lastNameField(BuildContext context) {
    return TextField(
      controller: _lastNameCon,
      decoration: const InputDecoration(
        hintText: 'Last Name',
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: 'Email Address',
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.push(
            context,
            GenderAndAgeSelectionPage(
              userCreationReq: UserCredentialRequestModel(
                firstName: _firstNameCon.text,
                lastName: _lastNameCon.text,
                email: _emailCon.text,
                password: _passwordCon.text,
              ),
            ));
      },
      title: 'Continue',
    );
  }

  Widget _forgetPassword(context) {
    return RichText(
        text: TextSpan(
      children: [
        const TextSpan(
          text: 'Do you have an account? ',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
        TextSpan(
          text: 'Sign in',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Navigate to the create account page
              AppNavigator.push(context, SigninPage());
            },
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
