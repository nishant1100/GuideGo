import 'package:equatable/equatable.dart';

class BookGuideEntity extends Equatable {
  final String? id;
  final String? userId;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String pickupType;
  final String? placeImage;
  final String pickupLocation;
  final dynamic? guide;

  const BookGuideEntity(
      {this.id,
      this.placeImage,
      this.userId,
      required this.pickupDate,
      required this.pickupTime,
      required this.noofPeople,
      this.guide,
      required this.pickupType,
      required this.pickupLocation});

  const BookGuideEntity.initial()
      : guide = '',
        id = '',
        userId = '',
        placeImage ='',
        pickupDate = '',
        pickupTime = '',
        pickupType = '',
        noofPeople = '',
        pickupLocation = '';

  @override
  List<Object?> get props => [
        id,
        pickupDate,
        pickupLocation,
        pickupTime,
        noofPeople,
        placeImage,
        pickupType,
        guide
      ];
}
