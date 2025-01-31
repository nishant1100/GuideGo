import 'package:equatable/equatable.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String full_name;
  final String? image;
  final String phone;
  final String username;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.full_name,
    required this.image,
    required this.phone,
    required this.username,
    required this.password,
  });


  factory AuthApiModel.fromJson(Map<String, dynamic> json)=> _$AuthApiModelFromJson(json);


  Map<String,dynamic> toJson()=> _$AuthApiModelToJson(this);


  //to entity 
  AuthEntity toEntity(){
    return AuthEntity(
      full_Name: full_name,
       phone: phone, 
       image: image,
       username: username, 
       password: password ?? '',
       );
  }



  //from Entity
  factory AuthApiModel.fromEntiy(AuthEntity entity){
    return AuthApiModel(
      full_name: entity.full_Name, 
      phone: entity.phone,
      image: entity.image,
      username: entity.username, 
      password: entity.password,
      );
  }
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}