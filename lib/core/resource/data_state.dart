abstract class DataState<T> {
  final T? data;
  final Exception? error;

  const DataState({this.data, this.error});
}

class DataInitial<T> extends DataState<T> {
  const DataInitial({super.data});
}

class DataLoading<T> extends DataState<T> {
  const DataLoading({super.data});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(Exception error) : super(error: error);
}
