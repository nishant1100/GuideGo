
import 'package:guide_go/features/booking/data/dto/get_all_guides_dto.dart';
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
  final dynamic guide; // Can be either string ID or Map<String, dynamic>

  GetBookingDto({
    this.id,
    this.userId,
    required this.pickupDate,
    required this.pickupTime,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
    required this.guide,
  });

  // Create from API JSON response
  factory GetBookingDto.fromJson(Map<String, dynamic> json) {
    // Check if guideId is a map (object) or string
    dynamic guideData = json['guideId'];
    dynamic processedGuideData;

    if (guideData is Map<String, dynamic>) {
      // It's a guide object, keep it as a Map
      processedGuideData = guideData;
    } else {
      // It's just an ID string
      processedGuideData = guideData?.toString() ?? '';
    }

    return GetBookingDto(
      id: json['_id'],
      userId: json['userId'] is Map<String, dynamic> ? json['userId']['_id'] : json['userId'], // Handle nested userId
      pickupDate: json['pickupDate'] ?? '',
      pickupTime: json['pickupTime'] ?? '',
      noofPeople: json['noofPeople'] ?? '',
      pickupType: json['pickupType'] ?? '',
      pickupLocation: json['pickupLocation'] ?? '',
      guide: processedGuideData,
    );
  }

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    // If guideId is a Map, only send the ID for requests
    String effectiveGuideId = guide is Map<String, dynamic> ? guide['_id'] : guide;

    return {
      if (id != null) '_id': id,
      if (userId != null) 'userId': userId,
      'pickupDate': pickupDate,
      'pickupTime': pickupTime,
      'noofPeople': noofPeople,
      'pickupType': pickupType,
      'pickupLocation': pickupLocation,
      'guideId': effectiveGuideId,
    };
  }
}