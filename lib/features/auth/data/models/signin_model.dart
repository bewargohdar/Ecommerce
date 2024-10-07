// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SigninModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? gender;
  String? age;
  SigninModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
    required this.age,
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

  factory SigninModel.fromMap(Map<String, dynamic> map) {
    return SigninModel(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      gender: map['gender'] != null ? map['gender'] as int : null,
      age: map['age'] != null ? map['age'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SigninModel.fromJson(String source) =>
      SigninModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
