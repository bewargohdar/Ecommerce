part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeEntity? homeEntity;
  final UserEntity? user;
  final List<CategoryEntity>? categories;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.homeEntity,
    this.user,
    this.categories,
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    HomeEntity? homeEntity,
    UserEntity? user,
    List<CategoryEntity>? categories,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return HomeState(
      homeEntity: homeEntity ?? this.homeEntity,
      user: user ?? this.user,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        homeEntity,
        user,
        categories,
        isLoading,
        error,
      ];
}
