// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class UserCredentialRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? gender;
  String? age;

  UserCredentialRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory UserCredentialRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialRequestModelToJson(this);
}
