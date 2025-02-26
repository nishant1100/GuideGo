// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_guides_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllGuidesDTO _$GetAllGuidesDTOFromJson(Map<String, dynamic> json) =>
    GetAllGuidesDTO(
      id: json['_id'] as String?,
      full_name: json['full_name'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
      available: json['avaiable'] as String,
    );

Map<String, dynamic> _$GetAllGuidesDTOToJson(GetAllGuidesDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'full_name': instance.full_name,
      'price': instance.price,
      'image': instance.image,
      'avaiable': instance.available,
    };
