// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideApiModel _$GuideApiModelFromJson(Map<String, dynamic> json) =>
    GuideApiModel(
      full_name: json['full_name'] as String,
      guideId: json['_id'] as String?,
      price: json['price'] as String,
      image: json['image'] as String,
      available: json['available'] as String,
    );

Map<String, dynamic> _$GuideApiModelToJson(GuideApiModel instance) =>
    <String, dynamic>{
      '_id': instance.guideId,
      'full_name': instance.full_name,
      'price': instance.price,
      'image': instance.image,
      'available': instance.available,
    };
