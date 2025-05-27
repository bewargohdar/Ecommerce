part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserEntity user;

  HomeLoaded(this.user);
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

final class CategoriesLoaded extends HomeState {
  final List<CategoryEntity> categories;

  CategoriesLoaded(this.categories);
}

// New composite state that can hold both user and categories data
final class HomeDataLoaded extends HomeState {
  final UserEntity? user;
  final List<CategoryEntity>? categories;
  final bool isLoadingUser;
  final bool isLoadingCategories;
  final String? userError;
  final String? categoriesError;

  HomeDataLoaded({
    this.user,
    this.categories,
    this.isLoadingUser = false,
    this.isLoadingCategories = false,
    this.userError,
    this.categoriesError,
  });

  HomeDataLoaded copyWith({
    UserEntity? user,
    List<CategoryEntity>? categories,
    bool? isLoadingUser,
    bool? isLoadingCategories,
    String? userError,
    String? categoriesError,
    bool clearUserError = false,
    bool clearCategoriesError = false,
  }) {
    return HomeDataLoaded(
      user: user ?? this.user,
      categories: categories ?? this.categories,
      isLoadingUser: isLoadingUser ?? this.isLoadingUser,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      userError: clearUserError ? null : (userError ?? this.userError),
      categoriesError: clearCategoriesError
          ? null
          : (categoriesError ?? this.categoriesError),
    );
  }
}
