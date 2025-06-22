part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class FetchHomeData extends HomeEvent {}

final class FetchUserInfo extends HomeEvent {}

final class FetchCategories extends HomeEvent {}
