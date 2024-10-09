import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthState {}

// Common States for Button Actions
class ButtonInitialState extends AuthState {}

class ButtonLoadingState extends AuthState {}

class ButtonSuccessState extends AuthState {}

class ButtonFailureState extends AuthState {
  final String errorMessage;
  ButtonFailureState({required this.errorMessage});
}

// States for Age Display
class AgesLoading extends AuthState {}

class AgesLoaded extends AuthState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> ages;
  AgesLoaded({required this.ages});
}

class AgesLoadFailure extends AuthState {
  final String message;
  AgesLoadFailure({required this.message});
}

// States for Age Selection
class AgeSelectionState extends AuthState {
  final String selectedAge;
  AgeSelectionState(this.selectedAge);
}

// States for Gender Selection
class GenderSelectionState extends AuthState {
  final int selectedGender;
  GenderSelectionState(this.selectedGender);
}
