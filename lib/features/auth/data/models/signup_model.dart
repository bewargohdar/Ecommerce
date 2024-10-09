// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'age': age,
    };
  }

  factory UserCredentialRequestModel.fromMap(Map<String, dynamic> map) {
    return UserCredentialRequestModel(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCredentialRequestModel.fromJson(String source) =>
      UserCredentialRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
