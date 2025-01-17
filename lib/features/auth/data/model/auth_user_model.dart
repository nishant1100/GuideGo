
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/constants/hive_table_constant.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';


part 'auth_user_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String username;
  @HiveField(6)
  final String password;

  AuthHiveModel({
    String? studentId,
    required this.fName,
    required this.lName,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        fName = '',
        lName = '',
        image = '',
        phone = '',
        username = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      phone: entity.phone,
      username: entity.username,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: studentId,
      fName: fName,
      lName: lName,
      image: image,
      phone: phone,
      username: username,
      password: password,
    );
  }

  @override
  List<Object?> get props =>
      [studentId, fName, lName, image, username, password];
}
