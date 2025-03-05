import 'package:equatable/equatable.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final Map<String, dynamic> userId; // Handle userId as a Map
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final Map<String, dynamic> guideId; // Handle guideId as a Map
  final String pickupType;
  final String pickupLocation;
  final String? placeImage;

  const BookingApiModel({
    this.id,
    required this.userId,
     this.placeImage,
    required this.guideId,
    required this.pickupDate,
    required this.pickupTime,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
  });

  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    return BookingApiModel(
      id: json['_id'],
      userId: json['userId'] is Map<String, dynamic> ? json['userId'] : {}, // Ensure userId is a Map
      guideId: json['guideId'] is Map<String, dynamic> ? json['guideId'] : {}, // Ensure guideId is a Map
      pickupDate: json['pickupDate'] ?? '',
      placeImage: json['placeImage']?? '',
      pickupTime: json['pickupTime'] ?? '',
      noofPeople: json['noofPeople'] ?? '',
      pickupType: json['pickupType'] ?? '',
      pickupLocation: json['pickupLocation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  // Convert to entity
  BookGuideEntity toEntity() {
    return BookGuideEntity(
      id: id,
      userId: userId['_id'], // Extract userId from the Map
      guide: guideId, // Pass the entire guideId Map
      pickupDate: pickupDate,
      pickupTime: pickupTime,
      noofPeople: noofPeople,
      placeImage:placeImage,
      pickupType: pickupType,
      pickupLocation: pickupLocation,
    );
  }

  // Convert from entity
  factory BookingApiModel.fromEntity(BookGuideEntity entity) {
    return BookingApiModel(
      id: entity.id,
      userId: {'_id': entity.userId}, // Convert userId back to a Map
      guideId: entity.guide is Map<String, dynamic> ? entity.guide : {}, // Ensure guide is a Map
      pickupDate: entity.pickupDate,
      pickupLocation: entity.pickupLocation,
      pickupTime: entity.pickupTime,
      pickupType: entity.pickupType,
      noofPeople: entity.noofPeople,
      placeImage: entity.placeImage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        guideId,
        placeImage,
        pickupDate,
        pickupTime,
        noofPeople,
        pickupType,
        pickupLocation,
      ];
}