import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_ages.dart';
import 'package:ecomerce/features/auth/domain/usecase/signin.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(ButtonInitialState()) {
    on<FetchAges>(_onFetchAges);
    on<SelectAge>(_selectAge);
    on<SelectGender>(_selectGender);
    on<ExecuteUseCase>(_executeUseCase);
    on<SignInEvent>(_signIn);
  }
  Future<void> _onFetchAges(FetchAges event, Emitter<AuthState> emit) async {
    emit(AgesLoading());
    var returnedData = await sl<GetAgesUseCase>().call(null);

    returnedData.fold(
      (message) => emit(AgesLoadFailure(message: message)),
      (data) => emit(AgesLoaded(ages: data)),
    );
  }

  Future<void> _selectAge(SelectAge event, Emitter<AuthState> emit) async {
    emit(AgeSelectionState(event.age));
  }

  Future<void> _selectGender(
      SelectGender event, Emitter<AuthState> emit) async {
    emit(GenderSelectionState(event.index));
  }

  Future<void> _executeUseCase(
      ExecuteUseCase event, Emitter<AuthState> emit) async {
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
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(ButtonLoadingState());
    try {
      Either returnedData = await sl<SigninUsecase>().call(event.signinUserReq);
      returnedData.fold(
        (error) => emit(ButtonFailureState(errorMessage: error)),
        (data) => emit(ButtonSuccessState()),
      );
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
