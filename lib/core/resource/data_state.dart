import 'package:flutter/material.dart';

abstract class DataState<T> {
  T? data;
  final Exception? exception;

  DataState({this.data, this.exception});

  List<Key>? get loadingKeys => null;
  int? get identifier => null;
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataInitial<T> extends DataState<T> {
  T? initialData;

  DataInitial({this.initialData}) : super(data: initialData);
}

class DataFetching<T> extends DataState<T> {
  bool? isPaginate;

  @override
  List<Key>? loadingKeys;

  @override
  int? identifier;

  DataFetching(
      {this.isPaginate, this.loadingKeys, super.data, this.identifier}) {
    loadingKeys ??= [];
  }
}

class DataFailed<T> extends DataState<T> {
  DataFailed(Exception exception) : super(exception: exception);
}

class DataNotSet<T> extends DataState<T> {
  DataNotSet();
}
