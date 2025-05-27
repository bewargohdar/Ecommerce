part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchUserInfo extends HomeEvent {}

class FetchCategories extends HomeEvent {}
