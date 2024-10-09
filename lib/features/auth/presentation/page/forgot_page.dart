import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/common/widget/button/basic_app_button.dart';

import 'package:ecomerce/features/auth/domain/usecase/send_password_reset.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_state.dart';

import 'package:ecomerce/features/auth/presentation/page/password_reset_email.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPage extends StatelessWidget {
  ForgotPage({super.key});
  final TextEditingController _emailCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ButtonFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state is ButtonSuccessState) {
            AppNavigator.pushAndRemove(context, const PasswordResetEmailPage());
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _forgotText(context),
              const SizedBox(height: 20),
              _forgotField(context),
              const SizedBox(height: 20),
              _continueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forgotText(BuildContext context) {
    return const Text(
      'Forgot Password',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _forgotField(BuildContext context) {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: 'Enter Email Address',
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicAppButton(
        onPressed: () {
          context.read<AuthBloc>().add(
                ExecuteUseCase(
                  usecase: SendPasswordResetEmailUseCase(),
                  params: _emailCon.text,
                ),
              );
        },
        title: 'Continue',
      );
    });
  }
}
