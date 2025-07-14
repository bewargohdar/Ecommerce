import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/common/widget/button/basic_reactive_button.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/domain/usecase/signin.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecomerce/features/auth/presentation/page/forgot_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterPasswordPage extends StatelessWidget {
  final SigninUserReq signinUserReq;
  EnterPasswordPage({super.key, required this.signinUserReq});
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 40,
        ),
        child: BlocListener<AuthBloc, AuthState>(
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
              AppNavigator.pushAndRemove(context, const Scaffold());
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _enterPassword(context),
                const SizedBox(height: 20),
                _passwordFiled(context),
                const SizedBox(height: 20),
                _continueButton(context),
                const SizedBox(height: 20),
                _forgetPassword(context),
              ],
            ),
          ),
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
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicReactiveButton(
      onPressed: () {
        signinUserReq.password = _passwordCon.text;
        context.read<AuthBloc>().add(
              ExecuteUseCase(
                usecase: SigninUsecase(),
                params: signinUserReq,
              ),
            );
      },
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
              AppNavigator.push(context, ForgotPage());
            },
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
