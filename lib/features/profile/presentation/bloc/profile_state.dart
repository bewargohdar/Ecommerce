part of 'profile_bloc.dart';

class ProfileState {
  final DataState<UserEntity> getUserState;
  final DataState<UserEntity> updateUserState;
  final DataState<String> uploadImageState;
  final UserEntity? currentUser;
  final bool isLoading;
  final bool isEditing;
  final String? errorMessage;
  final String? successMessage;

  const ProfileState({
    required this.getUserState,
    required this.updateUserState,
    required this.uploadImageState,
    this.currentUser,
    this.isLoading = false,
    this.isEditing = false,
    this.errorMessage,
    this.successMessage,
  });

  factory ProfileState.initial() => ProfileState(
        getUserState: DataInitial(),
        updateUserState: DataInitial(),
        uploadImageState: DataInitial(),
        currentUser: null,
      );

  ProfileState copyWith({
    DataState<UserEntity>? getUserState,
    DataState<UserEntity>? updateUserState,
    DataState<String>? uploadImageState,
    UserEntity? currentUser,
    bool? isLoading,
    bool? isEditing,
    String? errorMessage,
    String? successMessage,
  }) =>
      ProfileState(
        getUserState: getUserState ?? this.getUserState,
        updateUserState: updateUserState ?? this.updateUserState,
        uploadImageState: uploadImageState ?? this.uploadImageState,
        currentUser: currentUser ?? this.currentUser,
        isLoading: isLoading ?? this.isLoading,
        isEditing: isEditing ?? this.isEditing,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
      );
}
