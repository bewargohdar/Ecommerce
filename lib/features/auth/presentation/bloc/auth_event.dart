import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';

abstract class AuthEvent {}

// Age Display Events
class FetchAges extends AuthEvent {}

// Age Selection Events
class SelectAge extends AuthEvent {
  final String age;
  SelectAge(this.age);
}

// Gender Selection Events
class SelectGender extends AuthEvent {
  final int index;
  SelectGender(this.index);
}

// Button Action Events
class ExecuteUseCase extends AuthEvent {
  final dynamic params;
  final Usecase usecase;
  ExecuteUseCase({this.params, required this.usecase});
}

//sign in events
class SignInEvent extends AuthEvent {
  final SigninUserReq signinUserReq;
  SignInEvent(this.signinUserReq);
}
