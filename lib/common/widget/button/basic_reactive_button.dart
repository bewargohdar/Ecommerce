import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicReactiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final Widget? content;
  const BasicReactiveButton(
      {required this.onPressed,
      this.title = '',
      this.height,
      this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is ButtonLoadingState) {
        return _loading();
      }
      return _initial();
    });
  }

  Widget _loading() {
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 50),
        ),
        child: Container(
            height: height ?? 50,
            alignment: Alignment.center,
            child: const CircularProgressIndicator()));
  }

  Widget _initial() {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 50),
        ),
        child: content ??
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400),
            ));
  }
}
