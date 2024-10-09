import 'package:ecomerce/common/helper/appbuttonsheet/app_button_sheet.dart';
import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/common/widget/button/basic_reactive_button.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/auth/data/models/signin_model.dart';
import 'package:ecomerce/features/auth/domain/usecase/signup.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecomerce/features/auth/presentation/widgets/ages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
  final UserCredentialRequestModel userCreationReq;

  const GenderAndAgeSelectionPage({required this.userCreationReq, super.key});

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
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tellUs(),
                  const SizedBox(height: 30),
                  _genders(context),
                  const SizedBox(height: 30),
                  howOld(),
                  const SizedBox(height: 30),
                  _age(context),
                ],
              ),
            ),
            const Spacer(),
            _finishButton(context),
          ],
        ),
      ),
    );
  }

  Widget _tellUs() {
    return const Text(
      'Tell us about yourself',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }

  Widget _genders(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        int selectedGender = (state is GenderSelectionState)
            ? state.selectedGender
            : 1; // Default to Men if not selected

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            genderTile(context, 1, 'Men', selectedGender),
            const SizedBox(width: 20),
            genderTile(context, 2, 'Women', selectedGender),
          ],
        );
      },
    );
  }

  Expanded genderTile(BuildContext context, int genderIndex, String gender,
      int selectedGender) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<AuthBloc>().add(SelectGender(genderIndex));
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: selectedGender == genderIndex
                ? AppColors.primary
                : AppColors.secondBackground,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              gender,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget howOld() {
    return const Text(
      'How old are you?',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Widget _age(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String selectedAge =
            (state is AgeSelectionState) ? state.selectedAge : 'Select Age';

        return GestureDetector(
          onTap: () {
            // Dispatch the FetchAges event here to load the age options
            context.read<AuthBloc>().add(FetchAges());

            AppBottomsheet.display(
              context,
              BlocProvider.value(
                value: context.read<AuthBloc>(),
                child: const Ages(),
              ),
            );
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedAge),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.secondBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Builder(builder: (context) {
          return BasicReactiveButton(
            onPressed: () {
              userCreationReq.gender =
                  context.read<AuthBloc>().state is GenderSelectionState
                      ? (context.read<AuthBloc>().state as GenderSelectionState)
                          .selectedGender
                      : 1; // Default to Men if not selected

              userCreationReq.age =
                  context.read<AuthBloc>().state is AgeSelectionState
                      ? (context.read<AuthBloc>().state as AgeSelectionState)
                          .selectedAge
                      : ''; // Default or placeholder

              context.read<AuthBloc>().add(ExecuteUseCase(
                    usecase: SignupUsecase(),
                    params: userCreationReq,
                  ));
            },
            title: 'Finish',
          );
        }),
      ),
    );
  }
}
