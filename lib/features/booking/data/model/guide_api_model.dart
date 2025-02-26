import 'package:equatable/equatable.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guide_api_model.g.dart';

@JsonSerializable()
class GuideApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? guideId;
  final String full_name;
  final String price;
  final String image;
  final String available;

  const GuideApiModel({
    required this.full_name,
    this.guideId,
    required this.price,
    required this.image,
    required this.available,
  });

  factory GuideApiModel.fromJson(Map<String, dynamic> json) =>
      _$GuideApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuideApiModelToJson(this);

  //to entity
  GuideEntity toEntity() {
    return GuideEntity(
      guideId: guideId,
      full_name: full_name,
      price: price,
      image: image,
      available: available,
    );
  }

  //from Entity
  factory GuideApiModel.fromEntiy(GuideEntity entity) {
    return GuideApiModel(
      guideId: entity.guideId,
      full_name: entity.full_name,
      price: entity.price,
      image: entity.image,
      available: entity.available,
    );
  }

  static List<GuideEntity> toEntityList(List<GuideApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
