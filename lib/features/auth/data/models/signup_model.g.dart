// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialRequestModel _$UserCredentialRequestModelFromJson(
        Map<String, dynamic> json) =>
    UserCredentialRequestModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    )
      ..gender = (json['gender'] as num?)?.toInt()
      ..age = json['age'] as String?;

Map<String, dynamic> _$UserCredentialRequestModelToJson(
        UserCredentialRequestModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'age': instance.age,
    };
