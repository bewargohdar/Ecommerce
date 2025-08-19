import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/features/profile/domain/entity/user.dart';
import 'package:ecomerce/features/profile/domain/usecase/get_single_user.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetSingleUser getSingleUser;

  ProfileBloc({
    required this.getSingleUser,
  }) : super(ProfileState.initial()) {
    on<LoadUserProfileEvent>(_loadUserProfile);
    on<UpdateUserInfoEvent>(_updateUserInfo);
    on<ToggleEditModeEvent>(_toggleEditMode);

    on<SignOutEvent>(_signOut);
    on<ClearProfileMessagesEvent>(_clearProfileMessages);
  }

  Future<void> _loadUserProfile(
    LoadUserProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        getUserState: DataLoading(),
        isLoading: true,
        errorMessage: null,
      ),
    );

    final result = await getSingleUser(event.userId);

    if (result is DataSuccess<UserEntity>) {
      emit(
        state.copyWith(
          getUserState: result,
          currentUser: result.data,
          isLoading: false,
          successMessage: 'Profile loaded successfully',
        ),
      );
    } else if (result is DataError) {
      emit(
        state.copyWith(
          getUserState: result,
          isLoading: false,
          errorMessage: 'Failed to load profile: ${result.error?.toString()}',
        ),
      );
    }
  }

  Future<void> _updateUserInfo(
    UpdateUserInfoEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.currentUser == null) return;

    emit(
      state.copyWith(
        updateUserState: DataLoading(),
        isLoading: true,
        errorMessage: null,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    // Create updated user with new info
    final updatedUser = UserEntity(
      id: state.currentUser!.id,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      phone: event.phone,
      maidenName: state.currentUser!.maidenName,
      age: state.currentUser!.age,
      gender: state.currentUser!.gender,
      username: state.currentUser!.username,
      birthDate: state.currentUser!.birthDate,
      image: state.currentUser!.image,
      bloodGroup: state.currentUser!.bloodGroup,
      height: state.currentUser!.height,
      weight: state.currentUser!.weight,
      eyeColor: state.currentUser!.eyeColor,
      hair: state.currentUser!.hair,
      ip: state.currentUser!.ip,
      address: state.currentUser!.address,
      macAddress: state.currentUser!.macAddress,
      university: state.currentUser!.university,
      bank: state.currentUser!.bank,
      company: state.currentUser!.company,
      ein: state.currentUser!.ein,
      ssn: state.currentUser!.ssn,
      userAgent: state.currentUser!.userAgent,
      crypto: state.currentUser!.crypto,
      role: state.currentUser!.role,
    );

    emit(
      state.copyWith(
        updateUserState: DataSuccess(updatedUser),
        currentUser: updatedUser,
        isLoading: false,
        isEditing: false,
        successMessage: 'Profile updated successfully',
      ),
    );
  }

  Future<void> _toggleEditMode(
    ToggleEditModeEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        isEditing: !state.isEditing,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  Future<void> _signOut(
    SignOutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );

    // TODO: Implement sign out logic (clear tokens, navigate to login, etc.)
    await Future.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        isLoading: false,
        successMessage: 'Signed out successfully',
      ),
    );
  }

  Future<void> _clearProfileMessages(
    ClearProfileMessagesEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        errorMessage: null,
        successMessage: null,
      ),
    );
  }
}
