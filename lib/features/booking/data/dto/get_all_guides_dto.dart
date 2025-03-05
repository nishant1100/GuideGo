import 'package:guide_go/features/booking/data/model/guide_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_guides_dto.g.dart';

@JsonSerializable()
class GetAllGuidesDTO {
  @JsonKey(name: '_id')
  final String? id;
  final String full_name;
  final String price;
  final String image;
  @JsonKey(name: "avaiable")
  final String available;


  Map<String, dynamic> toJson() => _$GetAllGuidesDTOToJson(this);

  factory GetAllGuidesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllGuidesDTOFromJson(json);

  GetAllGuidesDTO({required this.id, required this.full_name, required this.price, required this.image, required this.available});
}