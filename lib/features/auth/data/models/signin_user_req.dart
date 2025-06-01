import 'package:json_annotation/json_annotation.dart';

part 'signin_user_req.g.dart';

@JsonSerializable()
class SigninUserReq {
  final String email;
  String? password;

  SigninUserReq({
    required this.email,
    this.password,
  });

  factory SigninUserReq.fromJson(Map<String, dynamic> json) =>
      _$SigninUserReqFromJson(json);

  Map<String, dynamic> toJson() => _$SigninUserReqToJson(this);
}
