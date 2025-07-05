part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfileEvent extends ProfileEvent {
  final int userId;

  const LoadUserProfileEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateUserInfoEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const UpdateUserInfoEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  @override
  List<Object> get props => [firstName, lastName, email, phone];
}

class ToggleEditModeEvent extends ProfileEvent {
  const ToggleEditModeEvent();

  @override
  List<Object> get props => [];
}

class SignOutEvent extends ProfileEvent {
  const SignOutEvent();

  @override
  List<Object> get props => [];
}

class ClearProfileMessagesEvent extends ProfileEvent {
  const ClearProfileMessagesEvent();

  @override
  List<Object> get props => [];
}
