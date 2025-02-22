import 'package:equatable/equatable.dart';

class BookGuideEntity extends Equatable {
  final String? id;
  final String? userId;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String pickupType;
  final String pickupLocation;

  const BookGuideEntity(
      {this.id,
      this.userId,
      required this.pickupDate,
      required this.pickupTime,
      required this.noofPeople,
      required this.pickupType,
      required this.pickupLocation});

  @override
  List<Object?> get props =>
      [id, pickupDate, pickupLocation, pickupTime, noofPeople, pickupType];
}
