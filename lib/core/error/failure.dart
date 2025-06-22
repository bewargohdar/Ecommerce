abstract class Failure {
  final String message;
  Failure({this.message = 'An unexpected error occurred'});
}

class ServerFailure extends Failure {
  ServerFailure({String message = 'A server error occurred'})
      : super(message: message);
}

class CacheFailure extends Failure {}
