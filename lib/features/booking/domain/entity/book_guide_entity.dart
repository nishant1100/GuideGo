import 'package:equatable/equatable.dart';

class BookGuideEntity extends Equatable {
  final String? id;
  final String? userId;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String pickupType;
  final String pickupLocation;
  final String? guideId;

  const BookGuideEntity(
      {this.id,
      this.userId,
      required this.pickupDate,
      required this.pickupTime,
      required this.noofPeople,
      this.guideId,
      required this.pickupType,
      required this.pickupLocation});

  const BookGuideEntity.initial()
      : guideId = '',
        id = '',
        userId = '',
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
        pickupType,
        guideId
      ];
}
