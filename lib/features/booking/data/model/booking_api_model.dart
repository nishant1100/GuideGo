import 'package:equatable/equatable.dart';
import 'package:guide_go/features/booking/data/model/guide_api_model.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String? guideId;
  final String pickupType;
  final String pickupLocation;

  const BookingApiModel({
    this.id,
    this.userId,
    this.guideId,
    required this.pickupDate,
    required this.pickupTime,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
  });

  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  //to entity
  BookGuideEntity toEntity() {
    return BookGuideEntity(
        id: id,
        userId: userId,
        guideId: guideId,
        pickupDate: pickupDate,
        pickupTime: pickupTime,
        noofPeople: noofPeople,
        pickupType: pickupType,
        pickupLocation: pickupLocation);
  }

  //from Entity
  factory BookingApiModel.fromEntiy(BookGuideEntity entity) {
    return BookingApiModel(
        id: entity.id,
        userId: entity.userId,
        guideId: entity.guideId,
        pickupDate: entity.pickupDate,
        pickupLocation: entity.pickupLocation,
        pickupTime: entity.pickupTime,
        pickupType: entity.pickupType,
        noofPeople: entity.noofPeople);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
