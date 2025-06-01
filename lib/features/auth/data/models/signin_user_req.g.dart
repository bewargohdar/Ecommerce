// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_user_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninUserReq _$SigninUserReqFromJson(Map<String, dynamic> json) =>
    SigninUserReq(
      email: json['email'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SigninUserReqToJson(SigninUserReq instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
