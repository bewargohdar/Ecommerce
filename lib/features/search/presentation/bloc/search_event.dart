part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends SearchEvent {}

class SearchTermChanged extends SearchEvent {
  final String term;

  const SearchTermChanged(this.term);

  @override
  List<Object> get props => [term];
}

class FilterChanged extends SearchEvent {
  final SearchFilter filter;

  const FilterChanged(this.filter);

  @override
  List<Object> get props => [filter];
}

class SearchSubmitted extends SearchEvent {}
