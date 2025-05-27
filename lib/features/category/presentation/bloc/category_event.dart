part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class FetchCategories extends CategoryEvent {
  FetchCategories();
}
