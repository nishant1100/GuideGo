// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      full_name: json['full_name'] as String,
      image: json['image'] as String?,
      phone: json['phone'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'full_name': instance.full_name,
      'image': instance.image,
      'phone': instance.phone,
      'username': instance.username,
      'password': instance.password,
    };
