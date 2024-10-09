import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_ages.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(ButtonInitialState()) {
    // Handle FetchAges event
    on<FetchAges>((event, emit) async {
      emit(AgesLoading());
      var returnedData = await sl<GetAgesUseCase>().call(null);

      returnedData.fold(
        (message) => emit(AgesLoadFailure(message: message)),
        (data) => emit(AgesLoaded(ages: data)),
      );
    });

    // Handle SelectAge event
    on<SelectAge>((event, emit) {
      emit(AgeSelectionState(event.age));
    });

    // Handle SelectGender event
    on<SelectGender>((event, emit) {
      emit(GenderSelectionState(event.index));
    });

    // Handle ExecuteUseCase event for button actions
    on<ExecuteUseCase>((event, emit) async {
      emit(ButtonLoadingState());
      try {
        Either returnedData = await event.usecase.call(event.params);
        returnedData.fold(
          (error) => emit(ButtonFailureState(errorMessage: error)),
          (data) => emit(ButtonSuccessState()),
        );
      } catch (e) {
        emit(ButtonFailureState(errorMessage: e.toString()));
      }
    });
  }
}
