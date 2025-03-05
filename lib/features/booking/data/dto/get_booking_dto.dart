import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetBookingDto {
  @JsonKey(name: "_id")
  final String? id;
  final String? userId;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String pickupType;
  final String pickupLocation;
  final String?placeImage;

  // Guide Fields
  final String? guideId;
  final String? guideName;
  final num? guidePrice;
  final String? guideImage;
  final String? guideAvailability;

  GetBookingDto({
    this.id,
    this.userId,
    this.placeImage,
    required this.pickupDate,
    required this.pickupTime,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
    this.guideId,
    this.guideName,
    this.guidePrice,
    this.guideImage,
    this.guideAvailability,
  });

  // Create from API JSON response
  factory GetBookingDto.fromJson(Map<String, dynamic> json) {
    final guideData = json['guideId'];

    return GetBookingDto(
      id: json['_id'],
      userId: json['userId'] is Map<String, dynamic> ? json['userId']['_id'] : json['userId'],
      pickupDate: json['pickupDate'] ?? '',
      pickupTime: json['pickupTime'] ?? '',
      placeImage: json['placeImage']?? '',
      noofPeople: json['noofPeople'] ?? '',
      pickupType: json['pickupType'] ?? '',
      pickupLocation: json['pickupLocation'] ?? '',
      
      // Extract guide details
      guideId: guideData is Map<String, dynamic> ? guideData['_id'] : guideData?.toString(),
      guideName: guideData is Map<String, dynamic> ? guideData['full_name'] : null,
      guidePrice: guideData is Map<String, dynamic> ? guideData['price'] : null,
      guideImage: guideData is Map<String, dynamic> ? guideData['image'] : null,
      guideAvailability: guideData is Map<String, dynamic> ? guideData['avaiable'] : null,
    );
  }

  // ✅ **Fix: Convert guide details properly when sending to BookingApiModel**
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'userId': userId,
      'pickupDate': pickupDate,
      'pickupTime': pickupTime,
      'noofPeople': noofPeople,
      'placeImage':placeImage,
      'pickupType': pickupType,
      'pickupLocation': pickupLocation,
      if (guideId != null)
        'guideId': {
          '_id': guideId,
          'full_name': guideName,
          'price': guidePrice,
          'image': guideImage,
          'avaiable': guideAvailability,
        },
    };
  }
}
