// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecomerce/features/auth/domain/entity/user_entity.dart';

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final int gender;

  UserModel(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.image,
      required this.gender});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId:
          map['userId'] as String? ?? '', // Default to an empty string if null
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      image: map['image'] as String? ?? '', // Provide a default value if null
      gender: map['gender'] != null
          ? map['gender'] as int
          : 0, // Default to 0 if null
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        image: image,
        gender: gender);
  }
}
