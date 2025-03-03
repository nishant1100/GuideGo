import 'package:equatable/equatable.dart';
import 'package:guide_go/app/constants/hive_table_constant.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'booking_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.bookingTableId)
class BookingHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? userId;
  @HiveField(2)
  final String pickupDate;
  @HiveField(3)
  final String pickupTime;
  @HiveField(4)
  final String noofPeople;
  @HiveField(5)
  final dynamic guideId; // Change to dynamic to handle both Map and String
  @HiveField(6)
  final String pickupType;
  @HiveField(7)
  final String pickupLocation;

  BookingHiveModel({
    String? id,
    this.userId,
    this.guideId,
    required this.pickupDate,
    required this.pickupTime,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
  }) : id = id ?? const Uuid().v4();

  // Convert to entity
  BookGuideEntity toEntity() {
    return BookGuideEntity(
      id: id,
      userId: userId,
      guide: guideId is Map<String, dynamic>
          ? guideId
          : null, // Ensure guide is a Map
      pickupDate: pickupDate,
      pickupTime: pickupTime,
      noofPeople: noofPeople,
      pickupType: pickupType,
      pickupLocation: pickupLocation,
    );
  }

  // Convert from entity
  factory BookingHiveModel.fromEntity(BookGuideEntity entity) {
    return BookingHiveModel(
      id: entity.id,
      userId: entity.userId,
      guideId: entity.guide,
      pickupDate: entity.pickupDate,
      pickupLocation: entity.pickupLocation,
      pickupTime: entity.pickupTime,
      pickupType: entity.pickupType,
      noofPeople: entity.noofPeople,
    );
  }

      static List<BookGuideEntity> toEntityList(List<BookingHiveModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }
    static List<BookingHiveModel> fromEntityList(List<BookGuideEntity> entityList) {
    return entityList
        .map((entity) => BookingHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        guideId,
        pickupDate,
        pickupTime,
        noofPeople,
        pickupType,
        pickupLocation,
      ];
}
