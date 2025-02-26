// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      guideId: json['guideId'] as String?,
      pickupDate: json['pickupDate'] as String,
      pickupTime: json['pickupTime'] as String,
      noofPeople: json['noofPeople'] as String,
      pickupType: json['pickupType'] as String,
      pickupLocation: json['pickupLocation'] as String,
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'pickupDate': instance.pickupDate,
      'pickupTime': instance.pickupTime,
      'noofPeople': instance.noofPeople,
      'guideId': instance.guideId,
      'pickupType': instance.pickupType,
      'pickupLocation': instance.pickupLocation,
    };
